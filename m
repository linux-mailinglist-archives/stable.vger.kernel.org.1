Return-Path: <stable+bounces-114296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA58A2CC8F
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 20:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A983AACD8
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79971A3142;
	Fri,  7 Feb 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mr9RJCRO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240F19D072;
	Fri,  7 Feb 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956456; cv=none; b=cKXAcOC9RIOTU6jaKq+/fkLi/tQIQCLujfmlstB/ad5Bv39KUbhevr1Ttcwc5IXCAumTlwfG09Kxnzt3S9h4nEyPYCkQ62HTn3MjWtIBrJ691X+gAfRfApiTog5GP9Ac1v0e1BM1wDhWVLgCfWK1EDaylBdo4Y8Eghjex3RS5no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956456; c=relaxed/simple;
	bh=pDiCFKmVT8F/FtxMm6fLl3R1XtRDH1QMV/dkDJdKu9A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghytYbyN4m0mTAeh0r6lahtGD884m6V5CrBHtYKoLk6urRmifz8IUHwiZGcMh5hDS8D6USINtrYmbVy77UMsbcNUeN8D35H8DlFsYvZN5F0bKas18naUqzSB0Rmc/Dg1UoldMxe68P7as/vvpgvwYl4+8Fbr0pODQFS16WceLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mr9RJCRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5219FC4CED1;
	Fri,  7 Feb 2025 19:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738956456;
	bh=pDiCFKmVT8F/FtxMm6fLl3R1XtRDH1QMV/dkDJdKu9A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mr9RJCROFA2c6rx8RRJ9/OAEtXgyOiNvz3xqQ++2SiAJIdSKUW2+kTWhziIuSFnBD
	 wnBAclzGWPc80Ek0AkSYw7RF6/m1WmsrY5GPKxpkAxIc8VNnGOHorUNsGv86TABUqs
	 kjvlmRtB9HjKB7zsFQhl2tv7A3DCO8BhFxBL54GwVumD7eVzB7INU+SlqvhatN8oMv
	 bD7yRyH/DrIryyAGFHXjLvlk4jCylA+kFc3jyFnbtx+xVTiLC0tiLzTzy0zGXqwBv+
	 6CqrbRFtgyhnifXlKiVEWjdBihsh/chYkQBrSojtFVqXstnBmSLX3czDjw1PG9IRZC
	 KcNgPn9uTf+ig==
Date: Fri, 07 Feb 2025 11:27:35 -0800
Subject: [PATCH 05/11] xfs: clean up log item accesses in
 xfs_qm_dqflush{,_done}
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: hch@lst.de, stable@vger.kernel.org
Message-ID: <173895601484.3373740.13028897086121340654.stgit@frogsfrogsfrogs>
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

commit ec88b41b932d5731291dcc0d0d63ea13ab8e07d5 upstream

Clean up these functions a little bit before we move on to the real
modifications, and make the variable naming consistent for dquot log items.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_dquot.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)


diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 5c4ede3e0fc70d..4f8fd1fa94dae2 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1136,8 +1136,9 @@ static void
 xfs_qm_dqflush_done(
 	struct xfs_log_item	*lip)
 {
-	struct xfs_dq_logitem	*qip = (struct xfs_dq_logitem *)lip;
-	struct xfs_dquot	*dqp = qip->qli_dquot;
+	struct xfs_dq_logitem	*qlip =
+			container_of(lip, struct xfs_dq_logitem, qli_item);
+	struct xfs_dquot	*dqp = qlip->qli_dquot;
 	struct xfs_ail		*ailp = lip->li_ailp;
 	xfs_lsn_t		tail_lsn;
 
@@ -1150,12 +1151,12 @@ xfs_qm_dqflush_done(
 	 * holding the lock before removing the dquot from the AIL.
 	 */
 	if (test_bit(XFS_LI_IN_AIL, &lip->li_flags) &&
-	    ((lip->li_lsn == qip->qli_flush_lsn) ||
+	    ((lip->li_lsn == qlip->qli_flush_lsn) ||
 	     test_bit(XFS_LI_FAILED, &lip->li_flags))) {
 
 		spin_lock(&ailp->ail_lock);
 		xfs_clear_li_failed(lip);
-		if (lip->li_lsn == qip->qli_flush_lsn) {
+		if (lip->li_lsn == qlip->qli_flush_lsn) {
 			/* xfs_ail_update_finish() drops the AIL lock */
 			tail_lsn = xfs_ail_delete_one(ailp, lip);
 			xfs_ail_update_finish(ailp, tail_lsn);
@@ -1313,7 +1314,7 @@ xfs_qm_dqflush(
 	dqp->q_flags &= ~XFS_DQFLAG_DIRTY;
 
 	xfs_trans_ail_copy_lsn(mp->m_ail, &dqp->q_logitem.qli_flush_lsn,
-					&dqp->q_logitem.qli_item.li_lsn);
+			&lip->li_lsn);
 
 	/*
 	 * copy the lsn into the on-disk dquot now while we have the in memory
@@ -1325,7 +1326,7 @@ xfs_qm_dqflush(
 	 * of a dquot without an up-to-date CRC getting to disk.
 	 */
 	if (xfs_has_crc(mp)) {
-		dqblk->dd_lsn = cpu_to_be64(dqp->q_logitem.qli_item.li_lsn);
+		dqblk->dd_lsn = cpu_to_be64(lip->li_lsn);
 		xfs_update_cksum((char *)dqblk, sizeof(struct xfs_dqblk),
 				 XFS_DQUOT_CRC_OFF);
 	}
@@ -1335,7 +1336,7 @@ xfs_qm_dqflush(
 	 * the AIL and release the flush lock once the dquot is synced to disk.
 	 */
 	bp->b_flags |= _XBF_DQUOTS;
-	list_add_tail(&dqp->q_logitem.qli_item.li_bio_list, &bp->b_li_list);
+	list_add_tail(&lip->li_bio_list, &bp->b_li_list);
 
 	/*
 	 * If the buffer is pinned then push on the log so we won't


