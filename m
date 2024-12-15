Return-Path: <stable+bounces-104256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614DE9F22B4
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864D5165F90
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611751428E3;
	Sun, 15 Dec 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SWGt5iZm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5D313E043
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734252802; cv=none; b=o7l2cfx3ornoGmjd3Oxa8RDWGZNIGwFL86TZLKWmTEv2u88vxq6uni3umYFoUAZouW5V8uHT2MVGzp46nnnt/aHHCCKbd25LdONMzjLLeinJOnH14Jj15kbUiiG/+VIJ1jgKl0TPH0XFWVhiGWVZ39WsfRIvR3wV2SyZQRWFssI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734252802; c=relaxed/simple;
	bh=iv9AefUfGWdkCRjLcAMCEEXocdeGjUAHzSgbJQ7hfmM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=as8SNfKHyhpTHtoKGbHGyI7FcrM5xJdIBx/l2Z98NQe1bYRXnZIKRAdFXiaV7c2+CiSHIgeyJq1P/gL/Yl/zXnL/ZOalLNkgauaMR/1ck1tJ3pUrZyeGjJX/TvVEBEhLfMi9qPdCd49Opeh3ASUA39WGW6j6J0Dr+LxGqVuyAp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SWGt5iZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D43DC4CECE;
	Sun, 15 Dec 2024 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734252802;
	bh=iv9AefUfGWdkCRjLcAMCEEXocdeGjUAHzSgbJQ7hfmM=;
	h=Subject:To:Cc:From:Date:From;
	b=SWGt5iZmPFPCzoymo8U9dQl+XHU3Rm21Jv45eKrJvEvoxIeqEDtwMqtkh6TQRZHeA
	 zQqalUsLty70nMj8+GJ2NkZXHsx/IuJrd97REhWz1KQLmFSH/uj8HcXc0Ob1AMHxCL
	 vHEw3VEr5aZBw8AyUkxYrGc6jps9c/nGo76vTYfw=
Subject: FAILED: patch "[PATCH] xfs: don't lose solo dquot update transactions" failed to apply to 6.1-stable tree
To: djwong@kernel.org,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:53:13 +0100
Message-ID: <2024121513-porcupine-corporate-5dfe@gregkh>
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
git cherry-pick -x 07137e925fa951646325762bda6bd2503dfe64c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121513-porcupine-corporate-5dfe@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07137e925fa951646325762bda6bd2503dfe64c6 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 2 Dec 2024 10:57:36 -0800
Subject: [PATCH] xfs: don't lose solo dquot update transactions

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

diff --git a/fs/xfs/xfs_quota.h b/fs/xfs/xfs_quota.h
index fa1317cc396c..d7565462af3d 100644
--- a/fs/xfs/xfs_quota.h
+++ b/fs/xfs/xfs_quota.h
@@ -101,7 +101,8 @@ extern void xfs_trans_free_dqinfo(struct xfs_trans *);
 extern void xfs_trans_mod_dquot_byino(struct xfs_trans *, struct xfs_inode *,
 		uint, int64_t);
 extern void xfs_trans_apply_dquot_deltas(struct xfs_trans *);
-extern void xfs_trans_unreserve_and_mod_dquots(struct xfs_trans *);
+void xfs_trans_unreserve_and_mod_dquots(struct xfs_trans *tp,
+		bool already_locked);
 int xfs_trans_reserve_quota_nblks(struct xfs_trans *tp, struct xfs_inode *ip,
 		int64_t dblocks, int64_t rblocks, bool force);
 extern int xfs_trans_reserve_quota_bydquots(struct xfs_trans *,
@@ -173,7 +174,7 @@ static inline void xfs_trans_mod_dquot_byino(struct xfs_trans *tp,
 {
 }
 #define xfs_trans_apply_dquot_deltas(tp)
-#define xfs_trans_unreserve_and_mod_dquots(tp)
+#define xfs_trans_unreserve_and_mod_dquots(tp, a)
 static inline int xfs_trans_reserve_quota_nblks(struct xfs_trans *tp,
 		struct xfs_inode *ip, int64_t dblocks, int64_t rblocks,
 		bool force)
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 427a8ba0ab99..4cd25717c9d1 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -866,6 +866,7 @@ __xfs_trans_commit(
 	 */
 	if (tp->t_flags & XFS_TRANS_SB_DIRTY)
 		xfs_trans_apply_sb_deltas(tp);
+	xfs_trans_apply_dquot_deltas(tp);
 
 	error = xfs_trans_run_precommits(tp);
 	if (error)
@@ -894,11 +895,6 @@ __xfs_trans_commit(
 
 	ASSERT(tp->t_ticket != NULL);
 
-	/*
-	 * If we need to update the superblock, then do it now.
-	 */
-	xfs_trans_apply_dquot_deltas(tp);
-
 	xlog_cil_commit(log, tp, &commit_seq, regrant);
 
 	xfs_trans_free(tp);
@@ -924,7 +920,7 @@ __xfs_trans_commit(
 	 * the dqinfo portion to be.  All that means is that we have some
 	 * (non-persistent) quota reservations that need to be unreserved.
 	 */
-	xfs_trans_unreserve_and_mod_dquots(tp);
+	xfs_trans_unreserve_and_mod_dquots(tp, true);
 	if (tp->t_ticket) {
 		if (regrant && !xlog_is_shutdown(log))
 			xfs_log_ticket_regrant(log, tp->t_ticket);
@@ -1018,7 +1014,7 @@ xfs_trans_cancel(
 	}
 #endif
 	xfs_trans_unreserve_and_mod_sb(tp);
-	xfs_trans_unreserve_and_mod_dquots(tp);
+	xfs_trans_unreserve_and_mod_dquots(tp, false);
 
 	if (tp->t_ticket) {
 		xfs_log_ticket_ungrant(log, tp->t_ticket);
diff --git a/fs/xfs/xfs_trans_dquot.c b/fs/xfs/xfs_trans_dquot.c
index 481ba3dc9f19..713b6d243e56 100644
--- a/fs/xfs/xfs_trans_dquot.c
+++ b/fs/xfs/xfs_trans_dquot.c
@@ -606,6 +606,24 @@ xfs_trans_apply_dquot_deltas(
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
@@ -642,7 +660,8 @@ xfs_trans_unreserve_and_mod_dquots_hook(
  */
 void
 xfs_trans_unreserve_and_mod_dquots(
-	struct xfs_trans	*tp)
+	struct xfs_trans	*tp,
+	bool			already_locked)
 {
 	int			i, j;
 	struct xfs_dquot	*dqp;
@@ -671,10 +690,12 @@ xfs_trans_unreserve_and_mod_dquots(
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
@@ -695,7 +716,7 @@ xfs_trans_unreserve_and_mod_dquots(
 				dqp->q_rtb.reserved -=
 					(xfs_qcnt_t)qtrx->qt_rtblk_res;
 			}
-			if (locked)
+			if (locked && !already_locked)
 				xfs_dqunlock(dqp);
 
 		}


