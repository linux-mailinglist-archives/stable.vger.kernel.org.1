Return-Path: <stable+bounces-171708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA180B2B643
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A2E622A09
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF351F0E58;
	Tue, 19 Aug 2025 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1cy4mpf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC21F0994
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567277; cv=none; b=CvD0UOk1Z1G57EijOJ12OYzr5J8OGJYbzH6uP/QYNbQBXo/cIqr2cKiDz4Z40AzBdmCg+qa3xTQEdSgOdICd7xohzi1nyE+SvGqIkVvj12Fp5onU5nEmHKROZIVicA17hg6l0vsMvHlQRTynLU0ZQyJw6iBblwXgg4QP0xxB0s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567277; c=relaxed/simple;
	bh=/b16gMUt/JSwuC/qD8FchYVZtwe+EA+euMYY67ZbuAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7rES96b4Nd3VScdj/NGgkm5nciqf94+mecCEPrr2/BX5VfcJMH67rRAuJRtiu2Ypl7BSALVA2nJy4cPfQpCbJUfar/N+L+SG/L0ozW2yrveI4T/EGw0Re56jwpUE+sOHS11N7cXn46Qg95OsjcnpsgIjwl4k1XVYjnJqr/YD0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1cy4mpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6061CC4CEEB;
	Tue, 19 Aug 2025 01:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755567277;
	bh=/b16gMUt/JSwuC/qD8FchYVZtwe+EA+euMYY67ZbuAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1cy4mpf1JR97yvXmYglStn9OMPDxZwGgekaBDhw3I72bWis04qjLO7d383Aq0pj/
	 HdkkpsTIFPaUQR5MxFJT8qEgoYP3D88oZl0g2Fcqd1a/ODP2QDB4+aR5RQzufA8WgK
	 AesgGny0h/RpzFC+2qzXw9nDW/LMjeNlgFh2r6s/yL522EQxnCZvtqCdgZICh3c5tI
	 tgpJE2SCLrlSBQ54+d2cOelBxNVAiHCEjQ68CE1yKB3IITCvlxby4GeACCFoWNeII+
	 mu1gceURhBOhWfLPE3KYvjh8GLCjYd1ho6WRhyIilxjZF0gDQ8/fq0YozEIdnbxDTT
	 DPR5MlZ2IZ1CA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 1/5] xfs: decouple xfs_trans_alloc_empty from xfs_trans_alloc
Date: Mon, 18 Aug 2025 21:34:30 -0400
Message-ID: <20250819013434.249383-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081857-glitter-hummus-4836@gregkh>
References: <2025081857-glitter-hummus-4836@gregkh>
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
index c6657072361a..db8f8b1b5d68 100644
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


