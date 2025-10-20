Return-Path: <stable+bounces-188106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAEFBF171A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A96F4F5948
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542243126B1;
	Mon, 20 Oct 2025 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHxM4NKM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9882FB084
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965614; cv=none; b=gXhR6rS5oLIirzjIG5HpbmA7FtqP8C42bV4tBwE1wOEpg7esTK02CPisCeP3I0yg+SHZZH+pvSaLzSmZU2xqT2Pe1NiWxB7BFGG+vOspuT/n8c1ZWkWRZEs8El8/gA4NH9yonCm/E01twPgXBsuZjSG6xcMojMv98NVpwW2awBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965614; c=relaxed/simple;
	bh=3jDhhGugn1t8ZBjaViLRd/U7fyCB7gGJIr6mDE1tB0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MenplEWMux0FEZmtmrP2qSK2jCWWFPcRPOMCzIveQa9NZTQh7OPdYhEa7pGhGzWYZ3RmdKSrfQvPAj8P7AmTp6qBmeVl7DvtxytV1r7WyXqYGgVZ4WBn+/3yuGcosziVBWtGmewnAHMd9cJvu/bAHljhm+S1+ZZVTu/FgYG4feA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHxM4NKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86013C116D0;
	Mon, 20 Oct 2025 13:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965614;
	bh=3jDhhGugn1t8ZBjaViLRd/U7fyCB7gGJIr6mDE1tB0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EHxM4NKMwwj2gF0vjUr1heuvcWLQNncnUqw4/0CuGMTj48dxxL3XGhoTDpYdXsvi1
	 mIyoHwKvcsVCxZFKSPC9nULrjaGCzDNJyHCfRyD0/S+Twi3uDCJSnpjJ8ZHE1eaXhW
	 E2eARxPonbUhy7vTgiUur+CFUZN2krFSKROVqtNI/4zj3zuKDUP2VWynA620Q2ZaTQ
	 AoeSErVy3we4A+WoJo3Ax9I4svflC9gmEk9sea70k1eO2kkH0CLrz/bCe6Sfa98P/g
	 dhHbeWOeCgu3xerZtH/XUnwGG3tP7fIWd3PL44l88S54un1dB+YDloho0VRzrW428R
	 TINH/J2TG9ZzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] md/raid10: Handle bio_split() errors
Date: Mon, 20 Oct 2025 09:06:48 -0400
Message-ID: <20251020130649.1765603-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020130649.1765603-1-sashal@kernel.org>
References: <2025101606-eggshell-static-9bca@gregkh>
 <20251020130649.1765603-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Garry <john.g.garry@oracle.com>

[ Upstream commit 4cf58d9529097328b669e3c8693ed21e3a041903 ]

Add proper bio_split() error handling. For any error, call
raid_end_bio_io() and return. Except for discard, where we end the bio
directly.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Link: https://lore.kernel.org/r/20241111112150.3756529-7-john.g.garry@oracle.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 22f166218f73 ("md: fix mssing blktrace bio split events")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid10.c | 47 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 6579bbb6a39a5..d02bd096824c8 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1153,6 +1153,7 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	int slot = r10_bio->read_slot;
 	struct md_rdev *err_rdev = NULL;
 	gfp_t gfp = GFP_NOIO;
+	int error;
 
 	if (slot >= 0 && r10_bio->devs[slot].rdev) {
 		/*
@@ -1203,6 +1204,10 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	if (max_sectors < bio_sectors(bio)) {
 		struct bio *split = bio_split(bio, max_sectors,
 					      gfp, &conf->bio_split);
+		if (IS_ERR(split)) {
+			error = PTR_ERR(split);
+			goto err_handle;
+		}
 		bio_chain(split, bio);
 		allow_barrier(conf);
 		submit_bio_noacct(bio);
@@ -1233,6 +1238,11 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	mddev_trace_remap(mddev, read_bio, r10_bio->sector);
 	submit_bio_noacct(read_bio);
 	return;
+err_handle:
+	atomic_dec(&rdev->nr_pending);
+	bio->bi_status = errno_to_blk_status(error);
+	set_bit(R10BIO_Uptodate, &r10_bio->state);
+	raid_end_bio_io(r10_bio);
 }
 
 static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
@@ -1341,9 +1351,10 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 				 struct r10bio *r10_bio)
 {
 	struct r10conf *conf = mddev->private;
-	int i;
+	int i, k;
 	sector_t sectors;
 	int max_sectors;
+	int error;
 
 	if ((mddev_is_clustered(mddev) &&
 	     md_cluster_ops->area_resyncing(mddev, WRITE,
@@ -1469,6 +1480,10 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 	if (r10_bio->sectors < bio_sectors(bio)) {
 		struct bio *split = bio_split(bio, r10_bio->sectors,
 					      GFP_NOIO, &conf->bio_split);
+		if (IS_ERR(split)) {
+			error = PTR_ERR(split);
+			goto err_handle;
+		}
 		bio_chain(split, bio);
 		allow_barrier(conf);
 		submit_bio_noacct(bio);
@@ -1488,6 +1503,26 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 			raid10_write_one_disk(mddev, r10_bio, bio, true, i);
 	}
 	one_write_done(r10_bio);
+	return;
+err_handle:
+	for (k = 0;  k < i; k++) {
+		int d = r10_bio->devs[k].devnum;
+		struct md_rdev *rdev = conf->mirrors[d].rdev;
+		struct md_rdev *rrdev = conf->mirrors[d].replacement;
+
+		if (r10_bio->devs[k].bio) {
+			rdev_dec_pending(rdev, mddev);
+			r10_bio->devs[k].bio = NULL;
+		}
+		if (r10_bio->devs[k].repl_bio) {
+			rdev_dec_pending(rrdev, mddev);
+			r10_bio->devs[k].repl_bio = NULL;
+		}
+	}
+
+	bio->bi_status = errno_to_blk_status(error);
+	set_bit(R10BIO_Uptodate, &r10_bio->state);
+	raid_end_bio_io(r10_bio);
 }
 
 static void __make_request(struct mddev *mddev, struct bio *bio, int sectors)
@@ -1629,6 +1664,11 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 	if (remainder) {
 		split_size = stripe_size - remainder;
 		split = bio_split(bio, split_size, GFP_NOIO, &conf->bio_split);
+		if (IS_ERR(split)) {
+			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+			bio_endio(bio);
+			return 0;
+		}
 		bio_chain(split, bio);
 		allow_barrier(conf);
 		/* Resend the fist split part */
@@ -1639,6 +1679,11 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 	if (remainder) {
 		split_size = bio_sectors(bio) - remainder;
 		split = bio_split(bio, split_size, GFP_NOIO, &conf->bio_split);
+		if (IS_ERR(split)) {
+			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+			bio_endio(bio);
+			return 0;
+		}
 		bio_chain(split, bio);
 		allow_barrier(conf);
 		/* Resend the second split part */
-- 
2.51.0


