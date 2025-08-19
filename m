Return-Path: <stable+bounces-171702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A77B2B5D7
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14FEC7A96C0
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60D01D514E;
	Tue, 19 Aug 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFHaq1NN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746112110
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566403; cv=none; b=YopnlZwvxB0ZIUZXqmclIAAd0cmDoc/bAWJE1DcGr5emKmb3ick/9roV3TM+iBkyefFm34jsUHhJ3ta6x0kuRiexqqQ9PRFKqOqrZZuXvml5hPTC7t3G/Fm0hVlcDVimB5FGrMKm/2QWLBByfwBiJ2vI7nIuP5wAp5EEPVItArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566403; c=relaxed/simple;
	bh=lDJrxu9TaElUWVEuEozba/xGt/0aBe2HqMmTO8YoOZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/mjsSpte8SwE9/4aljRXyK+urNvi2ySbdZ42ZQK6wwEK5+d4HVyolgDBc8jaczBwyYN8BxrrRlpCO6jI66Gz7aGsYjT5TvXhqDcM7fuGJ5bgLzv5F9Y0iN/8pyVrDM2GzkqsjBpIbSdl/M0ugVh7SC2UPCK9dHhIbnfIjDZUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFHaq1NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D71EC4CEEB;
	Tue, 19 Aug 2025 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755566403;
	bh=lDJrxu9TaElUWVEuEozba/xGt/0aBe2HqMmTO8YoOZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFHaq1NN42u+8F+DsH1s4SqJB7yC8ypJdFMAat/ehH+/p1YGbhByDVuGJBHGErv1y
	 nyccfpIkx9LY/INmclEKdbsIUI8UpnWernct6l1CfEwALF88Yif0fOZH1kZkCWs2K2
	 1fCPawjnGgBWzeRySo7LQA8tDHaaqpdC+yOT00U74qVZ58SqyRa1v3BzZ+hA2EGIej
	 E1OdWvrgVPA4Phyo+DVOIg6R4t2WgDrmfTBkcWg7lstAsdM46huAdTCio0e4hk1TKx
	 5gfEdHY6l3OqBT0dCLc+db+9f5kINWwC0Cc6/p1Rt7wVu+IczDNJ7h/0/IRY18npFv
	 BKf+Sqt6WWU/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/5] xfs: decouple xfs_trans_alloc_empty from xfs_trans_alloc
Date: Mon, 18 Aug 2025 21:19:55 -0400
Message-ID: <20250819011959.244870-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081857-swerve-preschool-2c2c@gregkh>
References: <2025081857-swerve-preschool-2c2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 83a80e95e797a2a6d14bf7983e5e6eecf8f5facb ]

xfs_trans_alloc_empty only shares the very basic transaction structure
allocation and initialization with xfs_trans_alloc.

Split out a new __xfs_trans_alloc helper for that and otherwise decouple
xfs_trans_alloc_empty from xfs_trans_alloc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: d2845519b072 ("xfs: fully decouple XFS_IBULK* flags from XFS_IWALK* flags")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_trans.c | 52 +++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index b4a07af513ba..09ba598a10d3 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -241,6 +241,28 @@ xfs_trans_reserve(
 	return error;
 }
 
+static struct xfs_trans *
+__xfs_trans_alloc(
+	struct xfs_mount	*mp,
+	uint			flags)
+{
+	struct xfs_trans	*tp;
+
+	ASSERT(!(flags & XFS_TRANS_RES_FDBLKS) || xfs_has_lazysbcount(mp));
+
+	tp = kmem_cache_zalloc(xfs_trans_cache, GFP_KERNEL | __GFP_NOFAIL);
+	if (!(flags & XFS_TRANS_NO_WRITECOUNT))
+		sb_start_intwrite(mp->m_super);
+	xfs_trans_set_context(tp);
+	tp->t_flags = flags;
+	tp->t_mountp = mp;
+	INIT_LIST_HEAD(&tp->t_items);
+	INIT_LIST_HEAD(&tp->t_busy);
+	INIT_LIST_HEAD(&tp->t_dfops);
+	tp->t_highest_agno = NULLAGNUMBER;
+	return tp;
+}
+
 int
 xfs_trans_alloc(
 	struct xfs_mount	*mp,
@@ -254,33 +276,16 @@ xfs_trans_alloc(
 	bool			want_retry = true;
 	int			error;
 
+	ASSERT(resp->tr_logres > 0);
+
 	/*
 	 * Allocate the handle before we do our freeze accounting and setting up
 	 * GFP_NOFS allocation context so that we avoid lockdep false positives
 	 * by doing GFP_KERNEL allocations inside sb_start_intwrite().
 	 */
 retry:
-	tp = kmem_cache_zalloc(xfs_trans_cache, GFP_KERNEL | __GFP_NOFAIL);
-	if (!(flags & XFS_TRANS_NO_WRITECOUNT))
-		sb_start_intwrite(mp->m_super);
-	xfs_trans_set_context(tp);
-
-	/*
-	 * Zero-reservation ("empty") transactions can't modify anything, so
-	 * they're allowed to run while we're frozen.
-	 */
-	WARN_ON(resp->tr_logres > 0 &&
-		mp->m_super->s_writers.frozen == SB_FREEZE_COMPLETE);
-	ASSERT(!(flags & XFS_TRANS_RES_FDBLKS) ||
-	       xfs_has_lazysbcount(mp));
-
-	tp->t_flags = flags;
-	tp->t_mountp = mp;
-	INIT_LIST_HEAD(&tp->t_items);
-	INIT_LIST_HEAD(&tp->t_busy);
-	INIT_LIST_HEAD(&tp->t_dfops);
-	tp->t_highest_agno = NULLAGNUMBER;
-
+	WARN_ON(mp->m_super->s_writers.frozen == SB_FREEZE_COMPLETE);
+	tp = __xfs_trans_alloc(mp, flags);
 	error = xfs_trans_reserve(tp, resp, blocks, rtextents);
 	if (error == -ENOSPC && want_retry) {
 		xfs_trans_cancel(tp);
@@ -329,9 +334,8 @@ xfs_trans_alloc_empty(
 	struct xfs_mount		*mp,
 	struct xfs_trans		**tpp)
 {
-	struct xfs_trans_res		resv = {0};
-
-	return xfs_trans_alloc(mp, &resv, 0, 0, XFS_TRANS_NO_WRITECOUNT, tpp);
+	*tpp = __xfs_trans_alloc(mp, XFS_TRANS_NO_WRITECOUNT);
+	return 0;
 }
 
 /*
-- 
2.50.1


