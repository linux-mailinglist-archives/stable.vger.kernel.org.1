Return-Path: <stable+bounces-46714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C4F8D0AF0
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3FAB2252E
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3115FCF0;
	Mon, 27 May 2024 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="orjv6QqK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CAC1078F;
	Mon, 27 May 2024 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836665; cv=none; b=TQKTAOKv4GzyyVcSlKeQi1KYJh+0Pl7zdELnal9HFOdAZ467IzPD0kdKNaKaJdhgu+4X3Ld1I9TH/GU7V8h74/ZNxGJnAml0WNSby1cGr3ecqQB1ktywoIsIjUgRi0XxenWHQ1OCt4dh0+SYwo7Puh9BJmLsUrpdrzuj0Alvz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836665; c=relaxed/simple;
	bh=SzNjURK/GVg1zllD753La0ul2M/xNJF1DDgwgGEE4D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkoVzTbCcbCslKtVlmvhzYOwwo2aabPk/YUqrF48g2LOoI7ot0r1Wzw2rnM3oHVN11ZtdqLfmPKJR8SkCeuBuvirzXKsBDe66X7zTzlRqTRNBMIzta9phybWj2ZaB/r6CCY4NgTvBoDgLpqL7x81ekfKjqb43+YJfW+Rw7l5/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=orjv6QqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F17C2BBFC;
	Mon, 27 May 2024 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836665;
	bh=SzNjURK/GVg1zllD753La0ul2M/xNJF1DDgwgGEE4D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orjv6QqKmt3ASYTrVs2iboA16+ID02WlsMG9zT1f1NUJwOA/nfBVN3Xa8e8IvxADR
	 GWFy2G3QdimehHnPWif4xTcbYeO22JQkAp6+cY9Ad1cJALO/884hf8botCega914Ow
	 gZ2AZvWltyeiCD6bu/o6z+vU8iakxZ2hqiV37mCs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 089/427] block: support to account io_ticks precisely
Date: Mon, 27 May 2024 20:52:16 +0200
Message-ID: <20240527185610.058342996@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 99dc422335d8b2bd4d105797241d3e715bae90e9 ]

Currently, io_ticks is accounted based on sampling, specifically
update_io_ticks() will always account io_ticks by 1 jiffies from
bdev_start_io_acct()/blk_account_io_start(), and the result can be
inaccurate, for example(HZ is 250):

Test script:
fio -filename=/dev/sda -bs=4k -rw=write -direct=1 -name=test -thinktime=4ms

Test result: util is about 90%, while the disk is really idle.

This behaviour is introduced by commit 5b18b5a73760 ("block: delete
part_round_stats and switch to less precise counting"), however, there
was a key point that is missed that this patch also improve performance
a lot:

Before the commit:
part_round_stats:
  if (part->stamp != now)
   stats |= 1;

  part_in_flight()
  -> there can be lots of task here in 1 jiffies.
  part_round_stats_single()
   __part_stat_add()
  part->stamp = now;

After the commit:
update_io_ticks:
  stamp = part->bd_stamp;
  if (time_after(now, stamp))
   if (try_cmpxchg())
    __part_stat_add()
    -> only one task can reach here in 1 jiffies.

Hence in order to account io_ticks precisely, we only need to know if
there are IO inflight at most once in one jiffies. Noted that for
rq-based device, iterating tags should not be used here because
'tags->lock' is grabbed in blk_mq_find_and_get_req(), hence
part_stat_lock_inc/dec() and part_in_flight() is used to trace inflight.
The additional overhead is quite little:

 - per cpu add/dec for each IO for rq-based device;
 - per cpu sum for each jiffies;

And it's verified by null-blk that there are no performance degration
under heavy IO pressure.

Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20240509123717.3223892-2-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c  | 9 +++++----
 block/blk-merge.c | 2 ++
 block/blk-mq.c    | 4 ++++
 block/blk.h       | 1 +
 block/genhd.c     | 2 +-
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b795ac177281a..6fcf8ed5fc1f1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -987,10 +987,11 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 	unsigned long stamp;
 again:
 	stamp = READ_ONCE(part->bd_stamp);
-	if (unlikely(time_after(now, stamp))) {
-		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
-			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
-	}
+	if (unlikely(time_after(now, stamp)) &&
+	    likely(try_cmpxchg(&part->bd_stamp, &stamp, now)) &&
+	    (end || part_in_flight(part)))
+		__part_stat_add(part, io_ticks, now - stamp);
+
 	if (part->bd_partno) {
 		part = bdev_whole(part);
 		goto again;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4e3483a16b757..ae61a9c2fc93c 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -779,6 +779,8 @@ static void blk_account_io_merge_request(struct request *req)
 	if (blk_do_io_stat(req)) {
 		part_stat_lock();
 		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
+		part_stat_local_dec(req->part,
+				    in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32afb87efbd0e..5ac2087b05630 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -997,6 +997,8 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 		update_io_ticks(req->part, jiffies, true);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
+		part_stat_local_dec(req->part,
+				    in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
@@ -1019,6 +1021,8 @@ static inline void blk_account_io_start(struct request *req)
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, false);
+		part_stat_local_inc(req->part,
+				    in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
diff --git a/block/blk.h b/block/blk.h
index d9f584984bc44..da5dbc6b13068 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -357,6 +357,7 @@ static inline bool blk_do_io_stat(struct request *rq)
 }
 
 void update_io_ticks(struct block_device *part, unsigned long now, bool end);
+unsigned int part_in_flight(struct block_device *part);
 
 static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 {
diff --git a/block/genhd.c b/block/genhd.c
index 52a4521df067b..345d80ab9791b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -118,7 +118,7 @@ static void part_stat_read_all(struct block_device *part,
 	}
 }
 
-static unsigned int part_in_flight(struct block_device *part)
+unsigned int part_in_flight(struct block_device *part)
 {
 	unsigned int inflight = 0;
 	int cpu;
-- 
2.43.0




