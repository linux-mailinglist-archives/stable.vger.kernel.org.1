Return-Path: <stable+bounces-93018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC61C9C8E72
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 16:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBC3288EB0
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 15:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B2318DF72;
	Thu, 14 Nov 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fkrtNc+z"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DC1632EF
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598453; cv=none; b=crY+uvI9GBeLdEXszPA60ivT3IqPfeikFIRQ9V1KPz+T399DTSLjmJjur6hsKSgKA2e6XOsPreGgobiHygpISK39qZ/OO21IrGYv2xPjC7nUT6cSfmVzl2YR9Dxmv9vIdxiHmwv20fClrj+6mNW6JmH2CgvXQEiboAPC58u9T0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598453; c=relaxed/simple;
	bh=LxBGfIl0sgrPYZfOjDAMjbmKdhTb+HwW/Yb+QsHEcQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTtCGnelKSvCemXwQofQd2bt0sMwK+xycQu9Br6wBzfxw+tAUASpTeEwg0ZGtLrEITeeP89D2s0kPtMpG2o/oseAfxmhQwQuaYf87FqzLD7ACIFe0qXb32WtP8yWLwBrupNL6tKsJHTIkzenhCCmwJDyNrzT1MtZG2AGwl+kSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fkrtNc+z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=g3dl1yOtDRwiYvNnurJG8aD2yaZbxSbQdU1pZyvI8gc=; b=fkrtNc+zuammw4VOUOUxhDZnII
	RRxE6obOS6/3sZp5ANcwdM2UVB2m2Z4xEv1oqsw1Z9idxzpsM34fOs29F9LpucBHgXYf9Uu0kHJ1t
	gDnPPtZ+o5dSxecTvUyoGWV6uMdAHnKyzMDrH8tdLqHsoMKYQoh3Kh0FHIvpy+/sqe8BsSGYigrTW
	/6NxnPGuPxy3KvG9QQxSCHAjg+VWHzGpb0QsBtes3T2gvUMdwMzrWxe3rOOoInr7tJ4jRHBj1Ga1L
	dbE2rgsQSZnbVBRK2eJOaJOeO9QbXbN4/wQel07Z9nNdk+EyrRtI2pnLDhP4O92JHPrWwcwoWVbN3
	gsJw79WA==;
Received: from 2a02-8389-2341-5b80-7760-efdd-0bcf-e551.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7760:efdd:bcf:e551] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBbrE-000000000pM-46oL;
	Thu, 14 Nov 2024 15:34:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Hans Holmberg <hans.holmberg@wdc.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Zizhi Wo <wozizhi@huawei.com>
Subject: [PATCH 5/7] xfs: fix off-by-one error in fsmap's end_daddr usage
Date: Thu, 14 Nov 2024 16:33:49 +0100
Message-ID: <20241114153353.318020-6-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114153353.318020-1-hch@lst.de>
References: <20241114153353.318020-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Darrick J. Wong" <djwong@kernel.org>

In commit ca6448aed4f10a, we created an "end_daddr" variable to fix
fsmap reporting when the end of the range requested falls in the middle
of an unknown (aka free on the rmapbt) region.  Unfortunately, I didn't
notice that the the code sets end_daddr to the last sector of the device
but then uses that quantity to compute the length of the synthesized
mapping.

Zizhi Wo later observed that when end_daddr isn't set, we still don't
report the last fsblock on a device because in that case (aka when
info->last is true), the info->high mapping that we pass to
xfs_getfsmap_group_helper has a startblock that points to the last
fsblock.  This is also wrong because the code uses startblock to
compute the length of the synthesized mapping.

Fix the second problem by setting end_daddr unconditionally, and fix the
first problem by setting start_daddr to one past the end of the range to
query.

Cc: <stable@vger.kernel.org> # v6.11
Fixes: ca6448aed4f10a ("xfs: Fix missing interval for missing_owner in xfs fsmap")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reported-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/xfs/xfs_fsmap.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 8d5d4d172d15..59b7a8e50414 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -165,7 +165,8 @@ struct xfs_getfsmap_info {
 	xfs_daddr_t		next_daddr;	/* next daddr we expect */
 	/* daddr of low fsmap key when we're using the rtbitmap */
 	xfs_daddr_t		low_daddr;
-	xfs_daddr_t		end_daddr;	/* daddr of high fsmap key */
+	/* daddr of high fsmap key, or the last daddr on the device */
+	xfs_daddr_t		end_daddr;
 	u64			missing_owner;	/* owner of holes */
 	u32			dev;		/* device id */
 	/*
@@ -388,8 +389,8 @@ xfs_getfsmap_group_helper(
 	 * we calculated from userspace's high key to synthesize the record.
 	 * Note that if the btree query found a mapping, there won't be a gap.
 	 */
-	if (info->last && info->end_daddr != XFS_BUF_DADDR_NULL)
-		frec->start_daddr = info->end_daddr;
+	if (info->last)
+		frec->start_daddr = info->end_daddr + 1;
 	else
 		frec->start_daddr = xfs_gbno_to_daddr(xg, startblock);
 
@@ -737,8 +738,8 @@ xfs_getfsmap_rtdev_rtbitmap_helper(
 	 * we calculated from userspace's high key to synthesize the record.
 	 * Note that if the btree query found a mapping, there won't be a gap.
 	 */
-	if (info->last && info->end_daddr != XFS_BUF_DADDR_NULL) {
-		frec.start_daddr = info->end_daddr;
+	if (info->last) {
+		frec.start_daddr = info->end_daddr + 1;
 	} else {
 		frec.start_daddr = xfs_rtb_to_daddr(mp, start_rtb);
 	}
@@ -1108,7 +1109,10 @@ xfs_getfsmap(
 	struct xfs_trans		*tp = NULL;
 	struct xfs_fsmap		dkeys[2];	/* per-dev keys */
 	struct xfs_getfsmap_dev		handlers[XFS_GETFSMAP_DEVS];
-	struct xfs_getfsmap_info	info = { NULL };
+	struct xfs_getfsmap_info	info = {
+		.fsmap_recs		= fsmap_recs,
+		.head			= head,
+	};
 	bool				use_rmap;
 	int				i;
 	int				error = 0;
@@ -1185,9 +1189,6 @@ xfs_getfsmap(
 
 	info.next_daddr = head->fmh_keys[0].fmr_physical +
 			  head->fmh_keys[0].fmr_length;
-	info.end_daddr = XFS_BUF_DADDR_NULL;
-	info.fsmap_recs = fsmap_recs;
-	info.head = head;
 
 	/* For each device we support... */
 	for (i = 0; i < XFS_GETFSMAP_DEVS; i++) {
@@ -1200,17 +1201,23 @@ xfs_getfsmap(
 			break;
 
 		/*
-		 * If this device number matches the high key, we have
-		 * to pass the high key to the handler to limit the
-		 * query results.  If the device number exceeds the
-		 * low key, zero out the low key so that we get
-		 * everything from the beginning.
+		 * If this device number matches the high key, we have to pass
+		 * the high key to the handler to limit the query results, and
+		 * set the end_daddr so that we can synthesize records at the
+		 * end of the query range or device.
 		 */
 		if (handlers[i].dev == head->fmh_keys[1].fmr_device) {
 			dkeys[1] = head->fmh_keys[1];
 			info.end_daddr = min(handlers[i].nr_sectors - 1,
 					     dkeys[1].fmr_physical);
+		} else {
+			info.end_daddr = handlers[i].nr_sectors - 1;
 		}
+
+		/*
+		 * If the device number exceeds the low key, zero out the low
+		 * key so that we get everything from the beginning.
+		 */
 		if (handlers[i].dev > head->fmh_keys[0].fmr_device)
 			memset(&dkeys[0], 0, sizeof(struct xfs_fsmap));
 
-- 
2.45.2


