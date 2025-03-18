Return-Path: <stable+bounces-124845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9981DA67A08
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 17:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8253A8BCE
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41320E038;
	Tue, 18 Mar 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2JV2VoiT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD5720B7FD
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316485; cv=none; b=WMf9oGdS44Fp0y+7ZZJW0pT1R2U10V1sGhfsiCYNEzpdArBpQUR5uWhP7k968FwGbADp1539uwvo5fyEhupP+W+FMuAxdTYtL3xu9Iuyl5R87F+bVOm2ptfdMMB9BxJe4koi2nMIgNpiXXEU5f/ISYGWCptFMznBd26q2ZorGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316485; c=relaxed/simple;
	bh=MAjLYxL02w6QuZYPOs8UR1P3jxxH1zk2wgKxit2R3uw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BfIWl1LpsxXl5oGbaa5C2yQktSdsrBEl3m9RfXpoWgEnAnwiL5EU7rVdsaNqmYXNiLMnxoFj7EGvbBVKHXXHtK6V4MjOP77Y1B6jlfXNA3WSJLAm02+mW2TM0ZXQmEOPZQ5NNAXHqpU+snZoh2ni/dJdWA2MxyRORgyavE34txo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2JV2VoiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486BDC4CEE3;
	Tue, 18 Mar 2025 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742316485;
	bh=MAjLYxL02w6QuZYPOs8UR1P3jxxH1zk2wgKxit2R3uw=;
	h=Subject:To:Cc:From:Date:From;
	b=2JV2VoiTXwYwpoU2ypGcnfqtXxMNbp+yErLRXidfWjjuAuCWEevij6O78LQKRJS8d
	 U/ow4yGo/mNZSFaR/xXKvB9HDvcOFMxaiaHz3JraPAPiotGNCWb7XhRVnpRFCm+BUG
	 IgISlCO8jiR06cYVxl5sD4EKpMOPqJ3etyH3I79k=
Subject: FAILED: patch "[PATCH] xfs: use the recalculated transaction reservation in" failed to apply to 6.1-stable tree
To: hch@lst.de,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Mar 2025 17:46:46 +0100
Message-ID: <2025031846-septic-french-4efb@gregkh>
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
git cherry-pick -x a18a69bbec083093c3bfebaec13ce0b4c6b2af7e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031846-septic-french-4efb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a18a69bbec083093c3bfebaec13ce0b4c6b2af7e Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 30 Aug 2024 15:37:00 -0700
Subject: [PATCH] xfs: use the recalculated transaction reservation in
 xfs_growfs_rt_bmblock

After going great length to calculate the transaction reservation for
the new geometry, we should also use it to allocate the transaction it
was calculated for.

Fixes: 578bd4ce7100 ("xfs: recompute growfsrtfree transaction reservation while growing rt volume")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index d290749b0304..a9f08d96f1fe 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -730,10 +730,12 @@ xfs_growfs_rt_bmblock(
 		xfs_rtsummary_blockcount(mp, nmp->m_rsumlevels,
 			nmp->m_sb.sb_rbmblocks));
 
-	/* recompute growfsrt reservation from new rsumsize */
+	/*
+	 * Recompute the growfsrt reservation from the new rsumsize, so that the
+	 * transaction below use the new, potentially larger value.
+	 * */
 	xfs_trans_resv_calc(nmp, &nmp->m_resv);
-
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_growrtfree, 0, 0, 0,
+	error = xfs_trans_alloc(mp, &M_RES(nmp)->tr_growrtfree, 0, 0, 0,
 			&args.tp);
 	if (error)
 		goto out_free;


