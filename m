Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4D7A3AA0
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbjIQUG5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbjIQUG3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:06:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98726EE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:06:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E84C433C8;
        Sun, 17 Sep 2023 20:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981182;
        bh=GrTWm9QQscidQ0GQF9B1rX0/OzKSNZLraOdxQUmqEHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pwn2TgRm+JYZDYDf7ZkPK7Dn9jSSMMNGxRF9h6QK+01GYdZmHVzHZEzaWOJyVR5cX
         EDn1yQ3lD/7CeJiaS3mzLJIU+rxcUb8qDSIoNdWOHvTS9h9y5L4XvPeBfBO9sJjBTh
         iMUt984vQp4tV8f5nNhZtEn+xHwTICKmisl/7UTY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 083/219] blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()
Date:   Sun, 17 Sep 2023 21:13:30 +0200
Message-ID: <20230917191043.978499995@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit e8368b57c006dc0e02dcd8a9dc9f2060ff5476fe ]

There are no functional changes, just make the code cleaner.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230816012708.1193747-4-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: eead0056648c ("blk-throttle: consider 'carryover_ios/bytes' in throtl_trim_slice()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-throttle.c | 86 +++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f1bc600c4ded6..931795da4d65d 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -697,11 +697,40 @@ static bool throtl_slice_used(struct throtl_grp *tg, bool rw)
 	return true;
 }
 
+static unsigned int calculate_io_allowed(u32 iops_limit,
+					 unsigned long jiffy_elapsed)
+{
+	unsigned int io_allowed;
+	u64 tmp;
+
+	/*
+	 * jiffy_elapsed should not be a big value as minimum iops can be
+	 * 1 then at max jiffy elapsed should be equivalent of 1 second as we
+	 * will allow dispatch after 1 second and after that slice should
+	 * have been trimmed.
+	 */
+
+	tmp = (u64)iops_limit * jiffy_elapsed;
+	do_div(tmp, HZ);
+
+	if (tmp > UINT_MAX)
+		io_allowed = UINT_MAX;
+	else
+		io_allowed = tmp;
+
+	return io_allowed;
+}
+
+static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
+{
+	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
+}
+
 /* Trim the used slices and adjust slice start accordingly */
 static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 {
-	unsigned long nr_slices, time_elapsed, io_trim;
-	u64 bytes_trim, tmp;
+	unsigned long time_elapsed, io_trim;
+	u64 bytes_trim;
 
 	BUG_ON(time_before(tg->slice_end[rw], tg->slice_start[rw]));
 
@@ -723,19 +752,14 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 
 	throtl_set_slice_end(tg, rw, jiffies + tg->td->throtl_slice);
 
-	time_elapsed = jiffies - tg->slice_start[rw];
-
-	nr_slices = time_elapsed / tg->td->throtl_slice;
-
-	if (!nr_slices)
+	time_elapsed = rounddown(jiffies - tg->slice_start[rw],
+				 tg->td->throtl_slice);
+	if (!time_elapsed)
 		return;
-	tmp = tg_bps_limit(tg, rw) * tg->td->throtl_slice * nr_slices;
-	do_div(tmp, HZ);
-	bytes_trim = tmp;
-
-	io_trim = (tg_iops_limit(tg, rw) * tg->td->throtl_slice * nr_slices) /
-		HZ;
 
+	bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
+					     time_elapsed);
+	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed);
 	if (!bytes_trim && !io_trim)
 		return;
 
@@ -749,41 +773,13 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	else
 		tg->io_disp[rw] = 0;
 
-	tg->slice_start[rw] += nr_slices * tg->td->throtl_slice;
+	tg->slice_start[rw] += time_elapsed;
 
 	throtl_log(&tg->service_queue,
 		   "[%c] trim slice nr=%lu bytes=%llu io=%lu start=%lu end=%lu jiffies=%lu",
-		   rw == READ ? 'R' : 'W', nr_slices, bytes_trim, io_trim,
-		   tg->slice_start[rw], tg->slice_end[rw], jiffies);
-}
-
-static unsigned int calculate_io_allowed(u32 iops_limit,
-					 unsigned long jiffy_elapsed)
-{
-	unsigned int io_allowed;
-	u64 tmp;
-
-	/*
-	 * jiffy_elapsed should not be a big value as minimum iops can be
-	 * 1 then at max jiffy elapsed should be equivalent of 1 second as we
-	 * will allow dispatch after 1 second and after that slice should
-	 * have been trimmed.
-	 */
-
-	tmp = (u64)iops_limit * jiffy_elapsed;
-	do_div(tmp, HZ);
-
-	if (tmp > UINT_MAX)
-		io_allowed = UINT_MAX;
-	else
-		io_allowed = tmp;
-
-	return io_allowed;
-}
-
-static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
-{
-	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
+		   rw == READ ? 'R' : 'W', time_elapsed / tg->td->throtl_slice,
+		   bytes_trim, io_trim, tg->slice_start[rw], tg->slice_end[rw],
+		   jiffies);
 }
 
 static void __tg_update_carryover(struct throtl_grp *tg, bool rw)
-- 
2.40.1



