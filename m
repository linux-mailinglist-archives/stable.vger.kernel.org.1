Return-Path: <stable+bounces-169992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9582DB29F9A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687A95E6091
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D902765EA;
	Mon, 18 Aug 2025 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EjKjsTuP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317A27BF6F
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514261; cv=none; b=EuKjmA9HeaBastnSgutNoY+sHzui0bIEEw971DG1c8+P7pEOYV1CtfIiVTEWrza3pmicH2RDKnfAJkFU3ZNA8NdmMSgndUtvN69FUADSBq+qcurvBCsrfQEBLM3SqRMbtEu/16/JDCiVhnTbq9uvZB0Wujtr5D9ouaOlM0+88iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514261; c=relaxed/simple;
	bh=ExVCS64GY8l+EGjOw250dLAJDCrturktakPjmdPSn24=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oXKhPpkYBM+XTtuLmSjptjmmp6Q77ELfl3Zqzd/UP7AEinyXrxyYi0lhYEzYHdRBQBFBkvVcu5dNZNk7DJGFnaaybu9DPoYsO05rYy2S450pmxPky67/GSSu5SvwiP6USezD5ZrW80LtYiVwDUQwrQqmSmu1nkCnbKPccU3klNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EjKjsTuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22E1C116C6;
	Mon, 18 Aug 2025 10:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514260;
	bh=ExVCS64GY8l+EGjOw250dLAJDCrturktakPjmdPSn24=;
	h=Subject:To:Cc:From:Date:From;
	b=EjKjsTuPNNb3Z1utwLxcTCk62Pl4fXamYXNfSwCMKH07ZUFNbo/6D7mh27g0Fkb5v
	 mu/BY+ivx3AtD51AeMaa14f2CJv59Ccwh5YBKSnPcH6YmrFJBzmZdlTwQFE17zkDeK
	 p0DF4QnP8x+z1Emnsp6DjcKIxtOj+zll692ippwY=
Subject: FAILED: patch "[PATCH] xfs: fully decouple XFS_IBULK* flags from XFS_IWALK* flags" failed to apply to 6.16-stable tree
To: hch@lst.de,cem@kernel.org,djwong@kernel.org,stable@vger.kernel.org,zzzccc427@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:50:57 +0200
Message-ID: <2025081857-swerve-preschool-2c2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x d2845519b0723c5d5a0266cbf410495f9b8fd65c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081857-swerve-preschool-2c2c@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d2845519b0723c5d5a0266cbf410495f9b8fd65c Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 23 Jul 2025 14:19:44 +0200
Subject: [PATCH] xfs: fully decouple XFS_IBULK* flags from XFS_IWALK* flags

Fix up xfs_inumbers to now pass in the XFS_IBULK* flags into the flags
argument to xfs_inobt_walk, which expects the XFS_IWALK* flags.

Currently passing the wrong flags works for non-debug builds because
the only XFS_IWALK* flag has the same encoding as the corresponding
XFS_IBULK* flag, but in debug builds it can trigger an assert that no
incorrect flag is passed.  Instead just extra the relevant flag.

Fixes: 5b35d922c52798 ("xfs: Decouple XFS_IBULK flags from XFS_IWALK flags")
Cc: <stable@vger.kernel.org> # v5.19
Reported-by: cen zhang <zzzccc427@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
index c8c9b8d8309f..5116842420b2 100644
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -447,17 +447,21 @@ xfs_inumbers(
 		.breq		= breq,
 	};
 	struct xfs_trans	*tp;
+	unsigned int		iwalk_flags = 0;
 	int			error = 0;
 
 	if (xfs_bulkstat_already_done(breq->mp, breq->startino))
 		return 0;
 
+	if (breq->flags & XFS_IBULK_SAME_AG)
+		iwalk_flags |= XFS_IWALK_SAME_AG;
+
 	/*
 	 * Grab an empty transaction so that we can use its recursive buffer
 	 * locking abilities to detect cycles in the inobt without deadlocking.
 	 */
 	tp = xfs_trans_alloc_empty(breq->mp);
-	error = xfs_inobt_walk(breq->mp, tp, breq->startino, breq->flags,
+	error = xfs_inobt_walk(breq->mp, tp, breq->startino, iwalk_flags,
 			xfs_inumbers_walk, breq->icount, &ic);
 	xfs_trans_cancel(tp);
 


