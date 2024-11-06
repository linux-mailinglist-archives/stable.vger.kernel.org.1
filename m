Return-Path: <stable+bounces-90107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA89BE502
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 11:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32B9281DFE
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 10:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37D61DE3DC;
	Wed,  6 Nov 2024 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0CVEkhLX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC91DE3CD
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890717; cv=none; b=a+TLrJtZ1xHQgghhPKsn85FD48pXnug5TP9lv+zdkWizb2Ts3RRihUIvh1s7ZU2mNhV1qTCLK97asoTi/gTvqnZZP+a0D1zyHJ00RtFtdsLLxrJwMxW/NB6vNXIDyZbRZyIEOwNa+e1BalMeYs/iNoS4q3KSo1NEwRxFG1oHTzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890717; c=relaxed/simple;
	bh=KL0o3DTpOE7FR+rdI6lipb6tAaehEKsnXkNsW5xps5s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nB0Ccezoq3NInV4h4chQ4XOpj2ZpebtV9iEEOqDTzcSRy6URxToNR85cm5SfghduyaKPLr7/J/Pv+QxAifIUgCJfkgcMDtEMCu8EwGPQHh1NIjmdHHcC8yyyY3Bjh/2QYLVs4uJPNEUS5oz6LivnSqiTaQFBbgSQtvpLRU352K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0CVEkhLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D131BC4CED2;
	Wed,  6 Nov 2024 10:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730890717;
	bh=KL0o3DTpOE7FR+rdI6lipb6tAaehEKsnXkNsW5xps5s=;
	h=Subject:To:Cc:From:Date:From;
	b=0CVEkhLXG4Hp3gf81HVDooTxBCUU0H0P7nqnaRKCqfAu1au7FHX/CcruQO0a4H276
	 RhesMfVYFWUS5KXfIU6XHyQ+Ofh3d85PZ7OQcvG9Kkge5b3IuPh83Oi99LO034MRu9
	 ZTaufPHWvLVEtb6WYCR9XiOYGbbAr4hU1bsnMFQU=
Subject: FAILED: patch "[PATCH] block: fix queue limits checks in blk_rq_map_user_bvec for" failed to apply to 6.1-stable tree
To: hch@lst.de,axboe@kernel.dk,john.g.garry@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 06 Nov 2024 11:58:19 +0100
Message-ID: <2024110618-voicing-yield-48ff@gregkh>
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
git cherry-pick -x be0e822bb3f5259c7f9424ba97e8175211288813
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110618-voicing-yield-48ff@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be0e822bb3f5259c7f9424ba97e8175211288813 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 28 Oct 2024 10:07:48 +0100
Subject: [PATCH] block: fix queue limits checks in blk_rq_map_user_bvec for
 real

blk_rq_map_user_bvec currently only has ad-hoc checks for queue limits,
and the last fix to it enabled valid NVMe I/O to pass, but also allowed
invalid one for drivers that set a max_segment_size or seg_boundary
limit.

Fix it once for all by using the bio_split_rw_at helper from the I/O
path that indicates if and where a bio would be have to be split to
adhere to the queue limits, and it returns a positive value, turn that
into -EREMOTEIO to retry using the copy path.

Fixes: 2ff949441802 ("block: fix sanity checks in blk_rq_map_user_bvec")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Link: https://lore.kernel.org/r/20241028090840.446180-1-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-map.c b/block/blk-map.c
index 6ef2ec1f7d78..b5fd1d857461 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -561,55 +561,33 @@ EXPORT_SYMBOL(blk_rq_append_bio);
 /* Prepare bio for passthrough IO given ITER_BVEC iter */
 static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 {
-	struct request_queue *q = rq->q;
-	size_t nr_iter = iov_iter_count(iter);
-	size_t nr_segs = iter->nr_segs;
-	struct bio_vec *bvecs, *bvprvp = NULL;
-	const struct queue_limits *lim = &q->limits;
-	unsigned int nsegs = 0, bytes = 0;
+	const struct queue_limits *lim = &rq->q->limits;
+	unsigned int max_bytes = lim->max_hw_sectors << SECTOR_SHIFT;
+	unsigned int nsegs;
 	struct bio *bio;
-	size_t i;
+	int ret;
 
-	if (!nr_iter || (nr_iter >> SECTOR_SHIFT) > queue_max_hw_sectors(q))
-		return -EINVAL;
-	if (nr_segs > queue_max_segments(q))
+	if (!iov_iter_count(iter) || iov_iter_count(iter) > max_bytes)
 		return -EINVAL;
 
-	/* no iovecs to alloc, as we already have a BVEC iterator */
+	/* reuse the bvecs from the iterator instead of allocating new ones */
 	bio = blk_rq_map_bio_alloc(rq, 0, GFP_KERNEL);
-	if (bio == NULL)
+	if (!bio)
 		return -ENOMEM;
-
 	bio_iov_bvec_set(bio, (struct iov_iter *)iter);
-	blk_rq_bio_prep(rq, bio, nr_segs);
 
-	/* loop to perform a bunch of sanity checks */
-	bvecs = (struct bio_vec *)iter->bvec;
-	for (i = 0; i < nr_segs; i++) {
-		struct bio_vec *bv = &bvecs[i];
-
-		/*
-		 * If the queue doesn't support SG gaps and adding this
-		 * offset would create a gap, fallback to copy.
-		 */
-		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv->bv_offset)) {
-			blk_mq_map_bio_put(bio);
-			return -EREMOTEIO;
-		}
-		/* check full condition */
-		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len)
-			goto put_bio;
-		if (bytes + bv->bv_len > nr_iter)
-			break;
-
-		nsegs++;
-		bytes += bv->bv_len;
-		bvprvp = bv;
+	/* check that the data layout matches the hardware restrictions */
+	ret = bio_split_rw_at(bio, lim, &nsegs, max_bytes);
+	if (ret) {
+		/* if we would have to split the bio, copy instead */
+		if (ret > 0)
+			ret = -EREMOTEIO;
+		blk_mq_map_bio_put(bio);
+		return ret;
 	}
+
+	blk_rq_bio_prep(rq, bio, nsegs);
 	return 0;
-put_bio:
-	blk_mq_map_bio_put(bio);
-	return -EINVAL;
 }
 
 /**


