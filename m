Return-Path: <stable+bounces-169995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698A7B29FA2
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DC81670F9
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425752765EF;
	Mon, 18 Aug 2025 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p+iYx9Lh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F342B30E855
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514276; cv=none; b=gguMC6A3YxQO6OdamOTuHRj1a8JO0nGPVRqp2x78N6f5Er56poN7m49cEY2GC1zUrTTuwtWfz+KpEd58d/GeQAJv237GjtD3HU+kMAC28ZhKdDY2AmllTIHI461ELQu95/uLjajzT+4QVdSUoLebTEu+UfIPXFTWBq2wh/5xI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514276; c=relaxed/simple;
	bh=jbOP6v7Dg5B5xJFcTsMxs6yvJgyru2QNOkr4D69OWPk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LZucBO8P8yMi+yioNM0SCPAEvBSniXY3IWewjALvz5xiOiK7Bl8OvkGUHrMLOm1RM6YkxrpGulQev1zKosY5iUoZouC/e9qcCUrK+LffeYvGRqw8ctaWtg6qNjIWnNeY7c+iAQAUd/Cex4o/qGz1F1fllQLuuyJ4LrWmXzPHe5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p+iYx9Lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62621C4CEEB;
	Mon, 18 Aug 2025 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514275;
	bh=jbOP6v7Dg5B5xJFcTsMxs6yvJgyru2QNOkr4D69OWPk=;
	h=Subject:To:Cc:From:Date:From;
	b=p+iYx9LhtFoc7cDZd9VqgCUW2pCFFTSxM9YJStlmswk+NX5BsKoLV7RtyU4T8kupQ
	 Jm2AbAVp7ga85/V3fylIqCk/DKyp0F+uu2DiZ8NMMjwh325av2wXoo3+1xFEK2uyPW
	 FLui42dCBCDvuQ2tJB8SgE3U5LnA4jF3312zO8FY=
Subject: FAILED: patch "[PATCH] xfs: fully decouple XFS_IBULK* flags from XFS_IWALK* flags" failed to apply to 6.1-stable tree
To: hch@lst.de,cem@kernel.org,djwong@kernel.org,stable@vger.kernel.org,zzzccc427@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:50:59 +0200
Message-ID: <2025081859-matcher-handprint-c398@gregkh>
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
git cherry-pick -x d2845519b0723c5d5a0266cbf410495f9b8fd65c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081859-matcher-handprint-c398@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


