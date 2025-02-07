Return-Path: <stable+bounces-114300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55649A2CC94
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 20:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75ED33AADA8
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 19:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE781A3143;
	Fri,  7 Feb 2025 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqKLX7cz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1931218DB0E;
	Fri,  7 Feb 2025 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956519; cv=none; b=ZmsGgNZLcvhtPLFJ+81xF13c8OIhvNOCh6k8FQ9b6TVzP+QlzgVNa5QL9Mqiph3IesT2sihF+PBS1+PMWq485TphSiyhddptyKuAjKemtmpX6tN0bIpyu3h5Wf5SX1qJMBYveYo1vRj2vwo50kTEu8U6g19akjZZ+eqbIyUR3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956519; c=relaxed/simple;
	bh=0dpsnUeiBRsogmiTDRaqBMn1+//11clSOwauom1k8+U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hc/5kV7y53oSPbkSL95Nqq0AMRntOvfT/Y8tsuleEtxpdz44zbZK8wBHeMxZpULyl8yICS/DnZ+4oeGdW/Fuztperj1ieaEOdNpdqA8EBVnVfqGL334YSWSeMMn1p2DDvakDT9mmpNBolBturfNjquaQwOvHHHXGmMZstN7eB3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqKLX7cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4E7C4CED1;
	Fri,  7 Feb 2025 19:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738956518;
	bh=0dpsnUeiBRsogmiTDRaqBMn1+//11clSOwauom1k8+U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LqKLX7czbYvZ2r6SmfAP6HiMPK2fn/bzwA9mn3raBEslCOx+MEE20Bn+sD1b3YO73
	 2O07TqeCOYVCXA7P6OurB6o/L7NV/xj8YB5gVhJ8DUYcKZJafUyapMObCDBjf5oCRA
	 RpuUXLpzN6y78hlbBXVl4jQus3E/ZLLrZqViZ6C0aaJYpXrjrqHp/my3M5t+T4eQVu
	 nFUF1izf0ju2k9/W0Db0KqVDBMaCVW6drDxOnGRwLE7klZkmIbLqlLRaLG2u315pKp
	 ByAxF89ecjQ4E/iNYLliHBRNThaTKvu7enwxoIuKF0eZZfP2xI/hnjWUQ0g+Lx9tcb
	 Du/kjmVQ8l4mg==
Date: Fri, 07 Feb 2025 11:28:38 -0800
Subject: [PATCH 09/11] xfs: release the dquot buf outside of qli_lock
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: syzbot+3126ab3db03db42e7a31@syzkaller.appspotmail.com, hch@lst.de,
 stable@vger.kernel.org
Message-ID: <173895601550.3373740.12378168291194427407.stgit@frogsfrogsfrogs>
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

commit 1aacd3fac248902ea1f7607f2d12b93929a4833b upstream

Lai Yi reported a lockdep complaint about circular locking:

 Chain exists of:
   &lp->qli_lock --> &bch->bc_lock --> &l->lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&l->lock);
                                lock(&bch->bc_lock);
                                lock(&l->lock);
   lock(&lp->qli_lock);

I /think/ the problem here is that xfs_dquot_attach_buf during
quotacheck will release the buffer while it's holding the qli_lock.
Because this is a cached buffer, xfs_buf_rele_cached takes b_lock before
decrementing b_hold.  Other threads have taught lockdep that a locking
dependency chain is bp->b_lock -> bch->bc_lock -> l(ru)->lock; and that
another chain is l(ru)->lock -> lp->qli_lock.  Hence we do not want to
take b_lock while holding qli_lock.

Reported-by: syzbot+3126ab3db03db42e7a31@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org> # v6.13-rc3
Fixes: ca378189fdfa89 ("xfs: convert quotacheck to attach dquot buffers")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_dquot.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)


diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index d2b06ca2ec7a9c..d64d454cbe8bca 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1308,7 +1308,8 @@ xfs_dquot_read_buf(
 
 /*
  * Attach a dquot buffer to this dquot to avoid allocating a buffer during a
- * dqflush, since dqflush can be called from reclaim context.
+ * dqflush, since dqflush can be called from reclaim context.  Caller must hold
+ * the dqlock.
  */
 int
 xfs_dquot_attach_buf(
@@ -1329,13 +1330,16 @@ xfs_dquot_attach_buf(
 			return error;
 
 		/*
-		 * Attach the dquot to the buffer so that the AIL does not have
-		 * to read the dquot buffer to push this item.
+		 * Hold the dquot buffer so that we retain our ref to it after
+		 * detaching it from the transaction, then give that ref to the
+		 * dquot log item so that the AIL does not have to read the
+		 * dquot buffer to push this item.
 		 */
 		xfs_buf_hold(bp);
+		xfs_trans_brelse(tp, bp);
+
 		spin_lock(&qlip->qli_lock);
 		lip->li_buf = bp;
-		xfs_trans_brelse(tp, bp);
 	}
 	qlip->qli_dirty = true;
 	spin_unlock(&qlip->qli_lock);


