Return-Path: <stable+bounces-186062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E405BE37C4
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 038B2358B0B
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA113314AE;
	Thu, 16 Oct 2025 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VsR8KZKh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9225A357
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619083; cv=none; b=cmbKsn3CJI+XzzBdO7uojO0DS342t3VuzopdayR5PxPhM5d0LV949+ymenE6VYHtjILGx/PSHktuW3Wj8OV5Bi3rG7ZrdUEHCu2yUBmBv363MrcnakXB8tpo2LqzcScrHCdijWBslioceAJMtjzTSX1FTh01ppTBhDHmBOZ5H7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619083; c=relaxed/simple;
	bh=AFlngSCsfFWEgL1cm6EysEBSbamOwHpJIPLp6qs4eUA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pUrDVeASzC6UaJ+u6EPamgsSNHJ2pP1V1vRij2Vz/cDLmBHs25KBBAkiYcOxF0YD/lkoY1saBXD9ID8WdkL28fUI1QbxcvcK6CWW1KvQV+xX8PGM6yKNgbLoeawNYV+2WKcXtkUQSvYM8A1EPpB2m58qhjyVdo75XO1KyWEmCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VsR8KZKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE8DC4CEF1;
	Thu, 16 Oct 2025 12:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619083;
	bh=AFlngSCsfFWEgL1cm6EysEBSbamOwHpJIPLp6qs4eUA=;
	h=Subject:To:Cc:From:Date:From;
	b=VsR8KZKh40McMYTT2ynx+IO0cAy+yNnwkr3NZEbeeIpAyvGAE6hL81zFWhJeYzQsB
	 3QzJTm/OIzcexy3J3gy85zeCO/CnwuaLuuQzgL7oODlDuIkraDI9mjwFDqY1SxPdsC
	 G7g1rC3bZuTrWDGSOFjYtiJ2G8uBA6zdOB5nIBmo=
Subject: FAILED: patch "[PATCH] md: fix mssing blktrace bio split events" failed to apply to 6.1-stable tree
To: yukuai3@huawei.com,axboe@kernel.dk,dlemoal@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:49:07 +0200
Message-ID: <2025101607-musket-agile-64f4@gregkh>
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
git cherry-pick -x 22f166218f7313e8fe2d19213b5f4b3265f8c39e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101607-musket-agile-64f4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


