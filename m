Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924346FA9E1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjEHK4m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjEHK4X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:56:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910243154F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A916461236
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB37C433D2;
        Mon,  8 May 2023 10:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543321;
        bh=locGV9iio/HtpP5WMfWl7Z3f1oqcWiQPfUbfQB3EWD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQhG2rY/REFc+Q1LRtm8rjthm88fdqRP8dUTwXlk+8wBkOdIQcrGYJ14Cnji+XS76
         R4ZlFwKNbuKfnh5i3uuxpGIHLpUg6iCGxEJrdF3zJdK848MuH7rFpTVF6ltRvhUpWg
         wGcwaO90L3GSlKQnUeDSN6MrM6heSYj50Dp+F02g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.3 022/694] blk-stat: fix QUEUE_FLAG_STATS clear
Date:   Mon,  8 May 2023 11:37:37 +0200
Message-Id: <20230508094433.356204030@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

commit 20de765f6d9da0c47b756429c60b41063b990a10 upstream.

We need to set QUEUE_FLAG_STATS for two cases:
1. blk_stat_enable_accounting()
2. blk_stat_add_callback()

So we should clear it only when ((q->stats->accounting == 0) &&
list_empty(&q->stats->callbacks)).

blk_stat_disable_accounting() only check if q->stats->accounting
is 0 before clear the flag, this patch fix it.

Also add list_empty(&q->stats->callbacks)) check when enable, or
the flag is already set.

The bug can be reproduced on kernel without BLK_DEV_THROTTLING
(since it unconditionally enable accounting, see the next patch).

  # cat /sys/block/sr0/queue/scheduler
  none mq-deadline [bfq]

  # cat /sys/kernel/debug/block/sr0/state
  SAME_COMP|IO_STAT|INIT_DONE|STATS|REGISTERED|NOWAIT|30

  # echo none > /sys/block/sr0/queue/scheduler

  # cat /sys/kernel/debug/block/sr0/state
  SAME_COMP|IO_STAT|INIT_DONE|REGISTERED|NOWAIT

  # cat /sys/block/sr0/queue/wbt_lat_usec
  75000

We can see that after changing elevator from "bfq" to "none",
"STATS" flag is lost even though WBT callback still need it.

Fixes: 68497092bde9 ("block: make queue stat accounting a reference")
Cc: <stable@vger.kernel.org> # v5.17+
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230413062805.2081970-1-chengming.zhou@linux.dev
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-stat.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -190,7 +190,7 @@ void blk_stat_disable_accounting(struct
 	unsigned long flags;
 
 	spin_lock_irqsave(&q->stats->lock, flags);
-	if (!--q->stats->accounting)
+	if (!--q->stats->accounting && list_empty(&q->stats->callbacks))
 		blk_queue_flag_clear(QUEUE_FLAG_STATS, q);
 	spin_unlock_irqrestore(&q->stats->lock, flags);
 }
@@ -201,7 +201,7 @@ void blk_stat_enable_accounting(struct r
 	unsigned long flags;
 
 	spin_lock_irqsave(&q->stats->lock, flags);
-	if (!q->stats->accounting++)
+	if (!q->stats->accounting++ && list_empty(&q->stats->callbacks))
 		blk_queue_flag_set(QUEUE_FLAG_STATS, q);
 	spin_unlock_irqrestore(&q->stats->lock, flags);
 }


