Return-Path: <stable+bounces-104262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8079F22BA
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495B9165F98
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE2F13E03A;
	Sun, 15 Dec 2024 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZtDQCn4w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65713D28F
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734252836; cv=none; b=VI2xrpqkQBejeCFKwfGFIQfC92jpKApecuP1pKVZgie7ElyTNIpa+fNmbFqZInYcLJTVSf2AbUCW7+d+B0aJJvc3wHmPcaPF+adtr8xm4EtY7om6OGWpdrGg2K08HXZhE80hx+eDuyYP0C8ioAWYnf7SMbb5azceV4un9Db9uwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734252836; c=relaxed/simple;
	bh=N4FURxuyAQKwYvk0kG/bf388tHDA9hwDSOSa1LCs+BM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sMXKDy532UHuX1D0Khq5wvy8vWxzHq/y6ugcLrWsWz2SxSKOIiUs6fNC3ygHdVYLzekxB/hyq3LCryuzf6bLIcZ5gwP11Em3CzVcHQ4zEShFUWKbS8I7l3Ku8dSDWz60g0QYlnQ6SHnXXk2f3qHVQmLSrGww5nJAklfoRqCMfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZtDQCn4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3040C4CECE;
	Sun, 15 Dec 2024 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734252836;
	bh=N4FURxuyAQKwYvk0kG/bf388tHDA9hwDSOSa1LCs+BM=;
	h=Subject:To:Cc:From:Date:From;
	b=ZtDQCn4wWZxxY4oMvNUbY50JvrcyfVZSJ5UvwbQp4zx6XLiRDvlG0rwK7Mwbsxoaw
	 fVEtyeLUJvTlaKXUotCOD7OXZzphmLW/mVRX7v1mP3GPWQHhWJZs71nu5z2v04mQ2P
	 YnD5Tm/rux7kD/3fG81kLE1mZX4Km2FRua4WFHu8=
Subject: FAILED: patch "[PATCH] xfs: fix off-by-one error in fsmap's end_daddr usage" failed to apply to 6.12-stable tree
To: djwong@kernel.org,hch@lst.de,stable@vger.kernel.org,wozizhi@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:53:53 +0100
Message-ID: <2024121553-prison-usage-c221@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a440a28ddbdcb861150987b4d6e828631656b92f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121553-prison-usage-c221@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a440a28ddbdcb861150987b4d6e828631656b92f Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 2 Dec 2024 10:57:24 -0800
Subject: [PATCH] xfs: fix off-by-one error in fsmap's end_daddr usage

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
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reported-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 82f2e0dd2249..3290dd8524a6 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -163,7 +163,8 @@ struct xfs_getfsmap_info {
 	xfs_daddr_t		next_daddr;	/* next daddr we expect */
 	/* daddr of low fsmap key when we're using the rtbitmap */
 	xfs_daddr_t		low_daddr;
-	xfs_daddr_t		end_daddr;	/* daddr of high fsmap key */
+	/* daddr of high fsmap key, or the last daddr on the device */
+	xfs_daddr_t		end_daddr;
 	u64			missing_owner;	/* owner of holes */
 	u32			dev;		/* device id */
 	/*
@@ -387,8 +388,8 @@ xfs_getfsmap_group_helper(
 	 * we calculated from userspace's high key to synthesize the record.
 	 * Note that if the btree query found a mapping, there won't be a gap.
 	 */
-	if (info->last && info->end_daddr != XFS_BUF_DADDR_NULL)
-		frec->start_daddr = info->end_daddr;
+	if (info->last)
+		frec->start_daddr = info->end_daddr + 1;
 	else
 		frec->start_daddr = xfs_gbno_to_daddr(xg, startblock);
 
@@ -736,11 +737,10 @@ xfs_getfsmap_rtdev_rtbitmap_helper(
 	 * we calculated from userspace's high key to synthesize the record.
 	 * Note that if the btree query found a mapping, there won't be a gap.
 	 */
-	if (info->last && info->end_daddr != XFS_BUF_DADDR_NULL) {
-		frec.start_daddr = info->end_daddr;
-	} else {
+	if (info->last)
+		frec.start_daddr = info->end_daddr + 1;
+	else
 		frec.start_daddr = xfs_rtb_to_daddr(mp, start_rtb);
-	}
 
 	frec.len_daddr = XFS_FSB_TO_BB(mp, rtbcount);
 	return xfs_getfsmap_helper(tp, info, &frec);
@@ -933,7 +933,10 @@ xfs_getfsmap(
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
@@ -998,9 +1001,6 @@ xfs_getfsmap(
 
 	info.next_daddr = head->fmh_keys[0].fmr_physical +
 			  head->fmh_keys[0].fmr_length;
-	info.end_daddr = XFS_BUF_DADDR_NULL;
-	info.fsmap_recs = fsmap_recs;
-	info.head = head;
 
 	/* For each device we support... */
 	for (i = 0; i < XFS_GETFSMAP_DEVS; i++) {
@@ -1013,17 +1013,23 @@ xfs_getfsmap(
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
 


