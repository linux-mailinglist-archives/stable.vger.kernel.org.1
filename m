Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662587A3AA1
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbjIQUG6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240435AbjIQUGe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:06:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E4D97
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:06:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6B1C433C7;
        Sun, 17 Sep 2023 20:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981189;
        bh=hgchqwMhRLXTa9gfy3mGsceHiNzAZzYxFMxE2Vcrp9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbBnMhfZ2PyrbvjixQ9mGCE+eivixauzF30dlwINIrEI34Ikj8m1KDpAKwAjY6Xup
         tX0RBZhlekYChXYnVisz3xettBqO4+1QFJXpiDEL3x8d1iJAKG2K+wyuJEqd7N913s
         C3CDZSbNwFpjisZkQJKar4wX2c4znbI+I9YO7MX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, zhuxiaohui <zhuxiaohui.400@bytedance.com>,
        Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 084/219] blk-throttle: consider carryover_ios/bytes in throtl_trim_slice()
Date:   Sun, 17 Sep 2023 21:13:31 +0200
Message-ID: <20230917191044.014858635@linuxfoundation.org>
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

[ Upstream commit eead0056648cef49d7b15c07ae612fa217083165 ]

Currently, 'carryover_ios/bytes' is not handled in throtl_trim_slice(),
for consequence, 'carryover_ios/bytes' will be used to throttle bio
multiple times, for example:

1) set iops limit to 100, and slice start is 0, slice end is 100ms;
2) current time is 0, and 10 ios are dispatched, those io won't be
   throttled and io_disp is 10;
3) still at current time 0, update iops limit to 1000, carryover_ios is
   updated to (0 - 10) = -10;
4) in this slice(0 - 100ms), io_allowed = 100 + (-10) = 90, which means
   only 90 ios can be dispatched without waiting;
5) assume that io is throttled in slice(0 - 100ms), and
   throtl_trim_slice() update silce to (100ms - 200ms). In this case,
   'carryover_ios/bytes' is not cleared and still only 90 ios can be
   dispatched between 100ms - 200ms.

Fix this problem by updating 'carryover_ios/bytes' in
throtl_trim_slice().

Fixes: a880ae93e5b5 ("blk-throttle: fix io hung due to configuration updates")
Reported-by: zhuxiaohui <zhuxiaohui.400@bytedance.com>
Link: https://lore.kernel.org/all/20230812072116.42321-1-zhuxiaohui.400@bytedance.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230816012708.1193747-5-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-throttle.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 931795da4d65d..1007f80278579 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -729,8 +729,9 @@ static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 /* Trim the used slices and adjust slice start accordingly */
 static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 {
-	unsigned long time_elapsed, io_trim;
-	u64 bytes_trim;
+	unsigned long time_elapsed;
+	long long bytes_trim;
+	int io_trim;
 
 	BUG_ON(time_before(tg->slice_end[rw], tg->slice_start[rw]));
 
@@ -758,17 +759,21 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 		return;
 
 	bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
-					     time_elapsed);
-	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed);
-	if (!bytes_trim && !io_trim)
+					     time_elapsed) +
+		     tg->carryover_bytes[rw];
+	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed) +
+		  tg->carryover_ios[rw];
+	if (bytes_trim <= 0 && io_trim <= 0)
 		return;
 
-	if (tg->bytes_disp[rw] >= bytes_trim)
+	tg->carryover_bytes[rw] = 0;
+	if ((long long)tg->bytes_disp[rw] >= bytes_trim)
 		tg->bytes_disp[rw] -= bytes_trim;
 	else
 		tg->bytes_disp[rw] = 0;
 
-	if (tg->io_disp[rw] >= io_trim)
+	tg->carryover_ios[rw] = 0;
+	if ((int)tg->io_disp[rw] >= io_trim)
 		tg->io_disp[rw] -= io_trim;
 	else
 		tg->io_disp[rw] = 0;
@@ -776,7 +781,7 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	tg->slice_start[rw] += time_elapsed;
 
 	throtl_log(&tg->service_queue,
-		   "[%c] trim slice nr=%lu bytes=%llu io=%lu start=%lu end=%lu jiffies=%lu",
+		   "[%c] trim slice nr=%lu bytes=%lld io=%d start=%lu end=%lu jiffies=%lu",
 		   rw == READ ? 'R' : 'W', time_elapsed / tg->td->throtl_slice,
 		   bytes_trim, io_trim, tg->slice_start[rw], tg->slice_end[rw],
 		   jiffies);
-- 
2.40.1



