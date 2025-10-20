Return-Path: <stable+bounces-188107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63156BF16F0
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B4D188C8E2
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09293128D6;
	Mon, 20 Oct 2025 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubaK0Sn5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F978313537
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965615; cv=none; b=pUNvLqUcqOf3QnLvvaYb16CLXXk7mObzKEN0Jwmjwr/KDwYmtdl8InCIqpetnTX3Cz8wCdOUxM4C/iQq0dHhqWUcOEBqj0wk6t9bsmJYuT8b7qpM+wXqT3SPoKTxTQ5HTusv6Nws/TZZ1/1IImpM5cdNZ/ADrrtFhVMGxpyDwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965615; c=relaxed/simple;
	bh=qP43lfoQc+i1Ce3w1e/QzUAsdoBnEXVZfTkA3ZhhgGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgbGcmOctNZKv/VboQ3Lzk85RayDqVQSp8dsV4KoBR0WWACe2RR0tAkL3cp7R52UcuVInDU7jW6c0MITfW8Lff2PoL6NB8OzUxD8s5vQCY8+z90z/w/wVcbsXQIh+PtSqBwFftHpJZONU02RP42LkpDKfg0I8xQW/EASf2PwEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubaK0Sn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84426C116B1;
	Mon, 20 Oct 2025 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965615;
	bh=qP43lfoQc+i1Ce3w1e/QzUAsdoBnEXVZfTkA3ZhhgGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubaK0Sn5ApNkAVRO+h7+ffGDjhErhfrv++gTcdsMtj7E6bqH+A2wsxpEr9AZZuXjj
	 JPcXTiqABTA8wXajDOU86PdI715EtYDQNIq+fWNIYZPU3bVkD3IClkrK6sNvr5Zh5w
	 LJUlNbI5mZNso2Ve91k1JChwPoL4wGBwureS8grg/oIFHlm61qOz68Ht2j7x1U72R5
	 RjG2wRlk2XARAnoItHxQAeRtULp0r1tASIQJKSXCTnFtSCO84brneAAH4SvMHWZ4OP
	 XieNW8JWSh+m3r65d+V238du7efOSoy/lMFFLt0C7MuhYtt1U6/qW5PN6kZDL+O2Yo
	 5HdDl0owCGMCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] md: fix mssing blktrace bio split events
Date: Mon, 20 Oct 2025 09:06:49 -0400
Message-ID: <20251020130649.1765603-4-sashal@kernel.org>
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

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 22f166218f7313e8fe2d19213b5f4b3265f8c39e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md-linear.c | 1 +
 drivers/md/raid0.c     | 4 ++++
 drivers/md/raid1.c     | 4 ++++
 drivers/md/raid10.c    | 8 ++++++++
 drivers/md/raid5.c     | 2 ++
 5 files changed, 19 insertions(+)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 369aed044b409..d733ebee624b7 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -267,6 +267,7 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 		}
 
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		bio = split;
 	}
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 67ec633d27e26..db1ab214250f9 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -470,7 +470,9 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 			bio_endio(bio);
 			return;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		bio = split;
 		end = zone->zone_end;
@@ -618,7 +620,9 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
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
index 31081d9e94025..4c6b1bd6da9bb 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1383,7 +1383,9 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 			error = PTR_ERR(split);
 			goto err_handle;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		bio = split;
 		r1_bio->master_bio = bio;
@@ -1574,7 +1576,9 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
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
index d02bd096824c8..b0062ad9b1d95 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1208,7 +1208,9 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 			error = PTR_ERR(split);
 			goto err_handle;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		allow_barrier(conf);
 		submit_bio_noacct(bio);
 		wait_barrier(conf, false);
@@ -1484,7 +1486,9 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 			error = PTR_ERR(split);
 			goto err_handle;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		allow_barrier(conf);
 		submit_bio_noacct(bio);
 		wait_barrier(conf, false);
@@ -1669,7 +1673,9 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 			bio_endio(bio);
 			return 0;
 		}
+
 		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
 		allow_barrier(conf);
 		/* Resend the fist split part */
 		submit_bio_noacct(split);
@@ -1684,7 +1690,9 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
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
index 39e7596e78c0b..4fae8ade24090 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5484,8 +5484,10 @@ static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
 
 	if (sectors < bio_sectors(raid_bio)) {
 		struct r5conf *conf = mddev->private;
+
 		split = bio_split(raid_bio, sectors, GFP_NOIO, &conf->bio_split);
 		bio_chain(split, raid_bio);
+		trace_block_split(split, raid_bio->bi_iter.bi_sector);
 		submit_bio_noacct(raid_bio);
 		raid_bio = split;
 	}
-- 
2.51.0


