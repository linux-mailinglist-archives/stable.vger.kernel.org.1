Return-Path: <stable+bounces-188105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CD0BF16ED
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284A23E29E4
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29F531329A;
	Mon, 20 Oct 2025 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLHTotBV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006631283C
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965614; cv=none; b=crcIRoEVrGC47hjzo85XBCbZVj0zhti3fLW/lUakBeVkJKul/7BXBiSW6xzdHD1tqPDyPxBzeQHWaD5fJQDkB8a4vz8ROF9OXZbGaudBvR8UrVm/9orKIhtQt0OAMCv0EU8hNX48dFyj52ODxQoYru/r4twfY/kHbHX0Y5peCuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965614; c=relaxed/simple;
	bh=Wq/72kVIPhTH08/ze+PKalAUWvgAdXfxeMRJt2J8iD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oadxUY6t/g6Tg6IfUWQVocWXnKVgrIxnfmMl0Q95+Pq8dQXOF9NAkPoMvOeqj2Z0jqnh7OSw7XYZPtnkBkTC+6s7UGTI9WwYvaHjm/tI0qSMJbn7WXqRY/lhAt9fiaWdj+RrSD766PD9PokJJ90AKUc5Y7VpgWJ5Gpvdae2T5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLHTotBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8765BC116B1;
	Mon, 20 Oct 2025 13:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965613;
	bh=Wq/72kVIPhTH08/ze+PKalAUWvgAdXfxeMRJt2J8iD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLHTotBVFU8sB1JwAc+jppe6JGSvbV7m5pcYvJ0pvp+0/zT7CtayCKWdePmDKmRJa
	 wtacmPtYIwwEGx08ozFVy82HAd7ePnCyI/zFVT6d50Q7e6/43iEajhnrnTqIW1CUFU
	 hHq0ZgM/UzaAx7TKSC35yM8US2cLV9sLX8BBjX8Sy9YveynCzObiJaPq3ZLNDAmAYc
	 FtJMuanXg6aT73N5G55SUiFSj83Uazp2wyxPwQ3tZgbQgwEEvGz1aBF0oPKIgKxEMB
	 AmAJBvsqVyebBzuk+//rr65x4ZYYHE9keLzn+PT0XoyI5G5cb+Cjae/7A9I6a2CI65
	 wnihPN9bpy8Zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] md/raid1: Handle bio_split() errors
Date: Mon, 20 Oct 2025 09:06:47 -0400
Message-ID: <20251020130649.1765603-2-sashal@kernel.org>
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

[ Upstream commit b1a7ad8b5c4fa28325ee7b369a2d545d3e16ccde ]

Add proper bio_split() error handling. For any error, call
raid_end_bio_io() and return.

For the case of an in the write path, we need to undo the increment in
the rdev pending count and NULLify the r1_bio->bios[] pointers.

For read path failure, we need to undo rdev pending count increment from
the earlier read_balance() call.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Link: https://lore.kernel.org/r/20241111112150.3756529-6-john.g.garry@oracle.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 22f166218f73 ("md: fix mssing blktrace bio split events")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index faccf7344ef93..31081d9e94025 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1317,7 +1317,7 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	struct raid1_info *mirror;
 	struct bio *read_bio;
 	int max_sectors;
-	int rdisk;
+	int rdisk, error;
 	bool r1bio_existed = !!r1_bio;
 
 	/*
@@ -1378,6 +1378,11 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	if (max_sectors < bio_sectors(bio)) {
 		struct bio *split = bio_split(bio, max_sectors,
 					      gfp, &conf->bio_split);
+
+		if (IS_ERR(split)) {
+			error = PTR_ERR(split);
+			goto err_handle;
+		}
 		bio_chain(split, bio);
 		submit_bio_noacct(bio);
 		bio = split;
@@ -1404,6 +1409,13 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	read_bio->bi_private = r1_bio;
 	mddev_trace_remap(mddev, read_bio, r1_bio->sector);
 	submit_bio_noacct(read_bio);
+	return;
+
+err_handle:
+	atomic_dec(&mirror->rdev->nr_pending);
+	bio->bi_status = errno_to_blk_status(error);
+	set_bit(R1BIO_Uptodate, &r1_bio->state);
+	raid_end_bio_io(r1_bio);
 }
 
 static void raid1_write_request(struct mddev *mddev, struct bio *bio,
@@ -1411,7 +1423,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 {
 	struct r1conf *conf = mddev->private;
 	struct r1bio *r1_bio;
-	int i, disks;
+	int i, disks, k, error;
 	unsigned long flags;
 	struct md_rdev *blocked_rdev;
 	int first_clone;
@@ -1557,6 +1569,11 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	if (max_sectors < bio_sectors(bio)) {
 		struct bio *split = bio_split(bio, max_sectors,
 					      GFP_NOIO, &conf->bio_split);
+
+		if (IS_ERR(split)) {
+			error = PTR_ERR(split);
+			goto err_handle;
+		}
 		bio_chain(split, bio);
 		submit_bio_noacct(bio);
 		bio = split;
@@ -1640,6 +1657,18 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 	/* In case raid1d snuck in to freeze_array */
 	wake_up_barrier(conf);
+	return;
+err_handle:
+	for (k = 0; k < i; k++) {
+		if (r1_bio->bios[k]) {
+			rdev_dec_pending(conf->mirrors[k].rdev, mddev);
+			r1_bio->bios[k] = NULL;
+		}
+	}
+
+	bio->bi_status = errno_to_blk_status(error);
+	set_bit(R1BIO_Uptodate, &r1_bio->state);
+	raid_end_bio_io(r1_bio);
 }
 
 static bool raid1_make_request(struct mddev *mddev, struct bio *bio)
-- 
2.51.0


