Return-Path: <stable+bounces-186061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B1CBE37C7
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3585841F2
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031E02E229C;
	Thu, 16 Oct 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BTUjjwCc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F6262FE9
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619080; cv=none; b=chqR3QX4yy1ma78UHC5sHyY8aKc2gI2aJZtXoLytxh5o2jrnEpu2b2M4W0f3FSn/YZc0S6SzmQPbusQTtVjvWnu96UwXBF2G28nou6GFZkOvSQ09c8KEevy69wd+TzY5iSbA25SIpNhDADtLuVMCmiQJLhgedpcHkV76pHXMNaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619080; c=relaxed/simple;
	bh=6lCE9bhhDv1lm8wfAEbzcybjs+4HSFcuVpkYAggEu3I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K0h6BITI0jCSFJvYRMbdeR/0potATXpphPt05Ld+0OxSp6jVye8Zt4mACfcB3yMhj5mhMUknUWlf9Q6z1iL50qDAkJyRSxNx85f/bvYOxML16jCCj1WpVqAS3fY1DbmSPZ7Cb3LMNt+UA6rQIk/IfcW9M5cy65/uYjSaRDnOHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BTUjjwCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B00C4CEFE;
	Thu, 16 Oct 2025 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619080;
	bh=6lCE9bhhDv1lm8wfAEbzcybjs+4HSFcuVpkYAggEu3I=;
	h=Subject:To:Cc:From:Date:From;
	b=BTUjjwCcyL2+BbJ8l5IWnVdW1gjbDR0X4kLPwXJrHvVokbXCjphu7C0mG+BARy/or
	 +EjK7LvjTFp2yF0P9RS6+sETL4qLH4tshW3RuV94IxBXux4GJsiwwcRm2hhiTaU20Q
	 x317L2/47DtsyDaHiKfUvQiNA2tjHGKwxHd3WPsg=
Subject: FAILED: patch "[PATCH] md: fix mssing blktrace bio split events" failed to apply to 6.12-stable tree
To: yukuai3@huawei.com,axboe@kernel.dk,dlemoal@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:49:06 +0200
Message-ID: <2025101606-eggshell-static-9bca@gregkh>
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
git cherry-pick -x 22f166218f7313e8fe2d19213b5f4b3265f8c39e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101606-eggshell-static-9bca@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 22f166218f7313e8fe2d19213b5f4b3265f8c39e Mon Sep 17 00:00:00 2001
From: Yu Kuai <yukuai3@huawei.com>
Date: Wed, 10 Sep 2025 14:30:44 +0800
Subject: [PATCH] md: fix mssing blktrace bio split events

If bio is split by internal handling like chunksize or badblocks, the
corresponding trace_block_split() is missing, resulting in blktrace
inability to catch BIO split events and making it harder to analyze the
BIO sequence.

Cc: stable@vger.kernel.org
Fixes: 4b1faf931650 ("block: Kill bio_pair_split()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 5d9b08115375..59d7963c7843 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -266,6 +266,7 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 		}
 
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		bio = split;
 	}
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f1d8811a542a..1ba7d0c090f7 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -472,7 +472,9 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 			bio_endio(bio);
 			return;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		bio = split;
 		end = zone->zone_end;
@@ -620,7 +622,9 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 			bio_endio(bio);
 			return true;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		raid0_map_submit_bio(mddev, bio);
 		bio = split;
 	}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index f096f4d0fca7..64a1e0b47e87 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1384,7 +1384,9 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 			error = PTR_ERR(split);
 			goto err_handle;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		bio = split;
 		r1_bio->master_bio = bio;
@@ -1616,7 +1618,9 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			error = PTR_ERR(split);
 			goto err_handle;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		bio = split;
 		r1_bio->master_bio = bio;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 312e8a0e93e7..3d7b24d6b4eb 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1209,7 +1209,9 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 			error = PTR_ERR(split);
 			goto err_handle;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		allow_barrier(conf);
 		submit_bio_noacct(bio);
 		wait_barrier(conf, false);
@@ -1495,7 +1497,9 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 			error = PTR_ERR(split);
 			goto err_handle;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		allow_barrier(conf);
 		submit_bio_noacct(bio);
 		wait_barrier(conf, false);
@@ -1679,7 +1683,9 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 			bio_endio(bio);
 			return 0;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		allow_barrier(conf);
 		/* Resend the fist split part */
 		submit_bio_noacct(split);
@@ -1694,7 +1700,9 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 			bio_endio(bio);
 			return 0;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		allow_barrier(conf);
 		/* Resend the second split part */
 		submit_bio_noacct(bio);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 5112658ef5f6..96a6d63b3d62 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5493,8 +5493,10 @@ static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
 
 	if (sectors < bio_sectors(raid_bio)) {
 		struct r5conf *conf = mddev->private;
+
 		split = bio_split(raid_bio, sectors, GFP_NOIO, &conf->bio_split);
 		bio_chain(split, raid_bio);
+		trace_block_split(split, raid_bio->bi_iter.bi_sector);
 		submit_bio_noacct(raid_bio);
 		raid_bio = split;
 	}


