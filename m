Return-Path: <stable+bounces-116610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FBAA38A8F
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 18:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF80A7A20AB
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 17:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D576229B12;
	Mon, 17 Feb 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN+AJG+Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BFC21C9F1;
	Mon, 17 Feb 2025 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813374; cv=none; b=HVMqUbjjtZI3T8sGqbXIJZ5nTjii16dp1I5Hz07I6dyi5bXgwzgJMmGzOhFHbI9EHJ1S2AaB/u5Zq6r2efQol2KCT+K+6eC0F/kLPFA24OV+o557roGOpeJxNjQRW8l6riehHPnpcu6FfmZcwCQB8UsDNjYKtjT/ooJ+LUpcdsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813374; c=relaxed/simple;
	bh=KYBtsIubLBWD+pZzSJzcuqVx2Bl831i/E2j8omVyfko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZihVsgQSkk2bD++XyEO+3eEb40xKDoNA09sZ2dPzzbPmcjGHoyz6fLE6fh9QuGxxqOW5zwAFppX+uBhj6fu6/3Gueo/eu51Ow7GT2WThUKRmGcUKHzk3etyVPBQfWh5l7FPOtIvcQqzOOOrRsCX7S+Grhz2vexuRFdRVHjSv3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN+AJG+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97183C4CED1;
	Mon, 17 Feb 2025 17:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739813373;
	bh=KYBtsIubLBWD+pZzSJzcuqVx2Bl831i/E2j8omVyfko=;
	h=Date:From:To:Cc:Subject:From;
	b=vN+AJG+YcuG10rdIN9jLt5pAxVObIJEq/N0zmEdIGEILg+s/4WqyfAm6Z6ha74BK3
	 xa/Pz9hnjlemNTcSkAGAqD7MuJVj3C+lo/L6ATI5urdq2IfV5KuvnxBC2Tmv1fApBX
	 EcJHVrsM89Q/CfS0cUPYr3VlzWuS/f3c1M6Yp3oP+IeQc3+Kq71Wv7r6fwoF0lFtqL
	 Kb6Eqt4nV1wKiISCyybo9A+BBwAnp2Qp0efy7f7iIZWQjkphG+Gc06spFjCvChRGQu
	 jVkA/qpVWyJmjjjKKOJ6VP9TfWiKBwLsqRSLLFfPD/cGVbXAI08PUT4UuDdPGXoIfi
	 JFYVJ6tM+kiIA==
Date: Mon, 17 Feb 2025 09:29:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: xfs-stable@lists.linux.dev
Cc: hch@lst.de, stable@vger.kernel.org, djwong@kernel.org,
	lorenz@monogon.tech, regressions@lists.linux.dev
Subject: [PATCH 6.12] xfs: don't lose solo dquot update transactions
Message-ID: <20250217172933.GI21799@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Darrick J. Wong <djwong@kernel.org>

commit 07137e925fa951646325762bda6bd2503dfe64c6 upstream

Quota counter updates are tracked via incore objects which hang off the
xfs_trans object.  These changes are then turned into dirty log items in
xfs_trans_apply_dquot_deltas just prior to commiting the log items to
the CIL.

However, updating the incore deltas do not cause XFS_TRANS_DIRTY to be
set on the transaction.  In other words, a pure quota counter update
will be silently discarded if there are no other dirty log items
attached to the transaction.

This is currently not the case anywhere in the filesystem because quota
updates always dirty at least one other metadata item, but a subsequent
bug fix will add dquot log item precommits, so we actually need a dirty
dquot log item prior to xfs_trans_run_precommits.  Also let's not leave
a logic bomb.

Cc: <stable@vger.kernel.org> # v2.6.35
Fixes: 0924378a689ccb ("xfs: split out iclog writing from xfs_trans_commit()")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_quota.h       |    5 +++--
 fs/xfs/xfs_trans.c       |   10 +++-------
 fs/xfs/xfs_trans_dquot.c |   31 ++++++++++++++++++++++++++-----
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_quota.h b/fs/xfs/xfs_quota.h
index 23d71a55bbc006..032f3a70f21ddd 100644
--- a/fs/xfs/xfs_quota.h
+++ b/fs/xfs/xfs_quota.h
@@ -96,7 +96,8 @@ extern void xfs_trans_free_dqinfo(struct xfs_trans *);
 extern void xfs_trans_mod_dquot_byino(struct xfs_trans *, struct xfs_inode *,
 		uint, int64_t);
 extern void xfs_trans_apply_dquot_deltas(struct xfs_trans *);
-extern void xfs_trans_unreserve_and_mod_dquots(struct xfs_trans *);
+void xfs_trans_unreserve_and_mod_dquots(struct xfs_trans *tp,
+		bool already_locked);
 int xfs_trans_reserve_quota_nblks(struct xfs_trans *tp, struct xfs_inode *ip,
 		int64_t dblocks, int64_t rblocks, bool force);
 extern int xfs_trans_reserve_quota_bydquots(struct xfs_trans *,
@@ -166,7 +167,7 @@ static inline void xfs_trans_mod_dquot_byino(struct xfs_trans *tp,
 {
 }
 #define xfs_trans_apply_dquot_deltas(tp)
-#define xfs_trans_unreserve_and_mod_dquots(tp)
+#define xfs_trans_unreserve_and_mod_dquots(tp, a)
 static inline int xfs_trans_reserve_quota_nblks(struct xfs_trans *tp,
 		struct xfs_inode *ip, int64_t dblocks, int64_t rblocks,
 		bool force)
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index ee46051db12dde..39cd11cbe21fcb 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -840,6 +840,7 @@ __xfs_trans_commit(
 	 */
 	if (tp->t_flags & XFS_TRANS_SB_DIRTY)
 		xfs_trans_apply_sb_deltas(tp);
+	xfs_trans_apply_dquot_deltas(tp);
 
 	error = xfs_trans_run_precommits(tp);
 	if (error)
@@ -868,11 +869,6 @@ __xfs_trans_commit(
 
 	ASSERT(tp->t_ticket != NULL);
 
-	/*
-	 * If we need to update the superblock, then do it now.
-	 */
-	xfs_trans_apply_dquot_deltas(tp);
-
 	xlog_cil_commit(log, tp, &commit_seq, regrant);
 
 	xfs_trans_free(tp);
@@ -898,7 +894,7 @@ __xfs_trans_commit(
 	 * the dqinfo portion to be.  All that means is that we have some
 	 * (non-persistent) quota reservations that need to be unreserved.
 	 */
-	xfs_trans_unreserve_and_mod_dquots(tp);
+	xfs_trans_unreserve_and_mod_dquots(tp, true);
 	if (tp->t_ticket) {
 		if (regrant && !xlog_is_shutdown(log))
 			xfs_log_ticket_regrant(log, tp->t_ticket);
@@ -992,7 +988,7 @@ xfs_trans_cancel(
 	}
 #endif
 	xfs_trans_unreserve_and_mod_sb(tp);
-	xfs_trans_unreserve_and_mod_dquots(tp);
+	xfs_trans_unreserve_and_mod_dquots(tp, false);
 
 	if (tp->t_ticket) {
 		xfs_log_ticket_ungrant(log, tp->t_ticket);
diff --git a/fs/xfs/xfs_trans_dquot.c b/fs/xfs/xfs_trans_dquot.c
index b368e13424c4f4..b92eeaa1a2a9e7 100644
--- a/fs/xfs/xfs_trans_dquot.c
+++ b/fs/xfs/xfs_trans_dquot.c
@@ -602,6 +602,24 @@ xfs_trans_apply_dquot_deltas(
 			ASSERT(dqp->q_blk.reserved >= dqp->q_blk.count);
 			ASSERT(dqp->q_ino.reserved >= dqp->q_ino.count);
 			ASSERT(dqp->q_rtb.reserved >= dqp->q_rtb.count);
+
+			/*
+			 * We've applied the count changes and given back
+			 * whatever reservation we didn't use.  Zero out the
+			 * dqtrx fields.
+			 */
+			qtrx->qt_blk_res = 0;
+			qtrx->qt_bcount_delta = 0;
+			qtrx->qt_delbcnt_delta = 0;
+
+			qtrx->qt_rtblk_res = 0;
+			qtrx->qt_rtblk_res_used = 0;
+			qtrx->qt_rtbcount_delta = 0;
+			qtrx->qt_delrtb_delta = 0;
+
+			qtrx->qt_ino_res = 0;
+			qtrx->qt_ino_res_used = 0;
+			qtrx->qt_icount_delta = 0;
 		}
 	}
 }
@@ -638,7 +656,8 @@ xfs_trans_unreserve_and_mod_dquots_hook(
  */
 void
 xfs_trans_unreserve_and_mod_dquots(
-	struct xfs_trans	*tp)
+	struct xfs_trans	*tp,
+	bool			already_locked)
 {
 	int			i, j;
 	struct xfs_dquot	*dqp;
@@ -667,10 +686,12 @@ xfs_trans_unreserve_and_mod_dquots(
 			 * about the number of blocks used field, or deltas.
 			 * Also we don't bother to zero the fields.
 			 */
-			locked = false;
+			locked = already_locked;
 			if (qtrx->qt_blk_res) {
-				xfs_dqlock(dqp);
-				locked = true;
+				if (!locked) {
+					xfs_dqlock(dqp);
+					locked = true;
+				}
 				dqp->q_blk.reserved -=
 					(xfs_qcnt_t)qtrx->qt_blk_res;
 			}
@@ -691,7 +712,7 @@ xfs_trans_unreserve_and_mod_dquots(
 				dqp->q_rtb.reserved -=
 					(xfs_qcnt_t)qtrx->qt_rtblk_res;
 			}
-			if (locked)
+			if (locked && !already_locked)
 				xfs_dqunlock(dqp);
 
 		}

