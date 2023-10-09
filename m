Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07B07BDE5F
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377026AbjJINTN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377086AbjJINS5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:18:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E072A91
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:18:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC42C433C7;
        Mon,  9 Oct 2023 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857534;
        bh=C7yM5o69/xxrFDbNbTCbfdjl4vX4Owf/faeL9kjUBRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XU0YFG1P+aNw+yVuWBZ6yXzYVokmc/7EIpO327d6jaRVtlYTnFlVzr1BE35oulhNj
         YQh+GXOgg8chhghutnzx/RXV/0Pbfwlc5cis8MwWVRe6fQj7ikM5JSl1x+DXPSD8dL
         vWKfYlllgmlYquM9g98dCBMvwvGOI1t2W+vVgdIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Zhang Wensheng <zhangwensheng@huaweicloud.com>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Hillf Danton <hdanton@sina.com>, Yu Kuai <yukuai3@huawei.com>,
        Dennis Zhou <dennis@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Saranya Muruganandam <saranyamohan@google.com>
Subject: [PATCH 6.1 050/162] block: fix use-after-free of q->q_usage_counter
Date:   Mon,  9 Oct 2023 15:00:31 +0200
Message-ID: <20231009130124.320135372@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit d36a9ea5e7766961e753ee38d4c331bbe6ef659b upstream.

For blk-mq, queue release handler is usually called after
blk_mq_freeze_queue_wait() returns. However, the
q_usage_counter->release() handler may not be run yet at that time, so
this can cause a use-after-free.

Fix the issue by moving percpu_ref_exit() into blk_free_queue_rcu().
Since ->release() is called with rcu read lock held, it is agreed that
the race should be covered in caller per discussion from the two links.

Reported-by: Zhang Wensheng <zhangwensheng@huaweicloud.com>
Reported-by: Zhong Jinghua <zhongjinghua@huawei.com>
Link: https://lore.kernel.org/linux-block/Y5prfOjyyjQKUrtH@T590/T/#u
Link: https://lore.kernel.org/lkml/Y4%2FmzMd4evRg9yDi@fedora/
Cc: Hillf Danton <hdanton@sina.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Dennis Zhou <dennis@kernel.org>
Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20221215021629.74870-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-sysfs.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -737,6 +737,7 @@ static void blk_free_queue_rcu(struct rc
 	struct request_queue *q = container_of(rcu_head, struct request_queue,
 					       rcu_head);
 
+	percpu_ref_exit(&q->q_usage_counter);
 	kmem_cache_free(blk_get_queue_kmem_cache(blk_queue_has_srcu(q)), q);
 }
 
@@ -762,8 +763,6 @@ static void blk_release_queue(struct kob
 
 	might_sleep();
 
-	percpu_ref_exit(&q->q_usage_counter);
-
 	if (q->poll_stat)
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);


