Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EC772C238
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbjFLLDh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbjFLLDW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:03:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587497DBC
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4CF762523
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0523FC4339C;
        Mon, 12 Jun 2023 10:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567061;
        bh=0cyYx0L4udcF3sFr86PyDu7MhaotetV0bmOuV3Kqb0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCHrBE5w4OGWwawcKZPOcoA63xGrjzDegzG18hwLHVvrzxJGmGCe4p/LNIwWvf3Os
         Yf6C5aeIe3O7ZKKMMocy5aKrsgBb2k4jxniMabNcqMuZ1xbmtXjr5NjY+8QF+j6CZi
         QYrq2ZaruQWlzslH22Yq5gQ1ppHUGyYohbQi7Oq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tian Lan <tian.lan@twosigma.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 135/160] blk-mq: fix blk_mq_hw_ctx active request accounting
Date:   Mon, 12 Jun 2023 12:27:47 +0200
Message-ID: <20230612101721.246495166@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Tian Lan <tian.lan@twosigma.com>

[ Upstream commit ddad59331a4e16088468ca0ad228a9fe32d7955a ]

The nr_active counter continues to increase over time which causes the
blk_mq_get_tag to hang until the thread is rescheduled to a different
core despite there are still tags available.

kernel-stack

  INFO: task inboundIOReacto:3014879 blocked for more than 2 seconds
  Not tainted 6.1.15-amd64 #1 Debian 6.1.15~debian11
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:inboundIOReacto state:D stack:0  pid:3014879 ppid:4557 flags:0x00000000
    Call Trace:
    <TASK>
    __schedule+0x351/0xa20
    scheduler+0x5d/0xe0
    io_schedule+0x42/0x70
    blk_mq_get_tag+0x11a/0x2a0
    ? dequeue_task_stop+0x70/0x70
    __blk_mq_alloc_requests+0x191/0x2e0

kprobe output showing RQF_MQ_INFLIGHT bit is not cleared before
__blk_mq_free_request being called.

  320    320  kworker/29:1H __blk_mq_free_request rq_flags 0x220c0 in-flight 1
         b'__blk_mq_free_request+0x1 [kernel]'
         b'bt_iter+0x50 [kernel]'
         b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
         b'blk_mq_timeout_work+0x7c [kernel]'
         b'process_one_work+0x1c4 [kernel]'
         b'worker_thread+0x4d [kernel]'
         b'kthread+0xe6 [kernel]'
         b'ret_from_fork+0x1f [kernel]'

Signed-off-by: Tian Lan <tian.lan@twosigma.com>
Fixes: 2e315dc07df0 ("blk-mq: grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter")
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230513221227.497327-1-tilan7663@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae08c4936743d..f2e2ffd135baf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -717,6 +717,10 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_crypto_free_request(rq);
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
+
+	if (rq->rq_flags & RQF_MQ_INFLIGHT)
+		__blk_mq_dec_active_requests(hctx);
+
 	if (rq->tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
 	if (sched_tag != BLK_MQ_NO_TAG)
@@ -728,15 +732,11 @@ static void __blk_mq_free_request(struct request *rq)
 void blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	if ((rq->rq_flags & RQF_ELVPRIV) &&
 	    q->elevator->type->ops.finish_request)
 		q->elevator->type->ops.finish_request(rq);
 
-	if (rq->rq_flags & RQF_MQ_INFLIGHT)
-		__blk_mq_dec_active_requests(hctx);
-
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
 		laptop_io_completion(q->disk->bdi);
 
-- 
2.39.2



