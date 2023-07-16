Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6110475512B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjGPTxb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPTxb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:53:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB36199
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:53:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B89B260E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9066C433C8;
        Sun, 16 Jul 2023 19:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537209;
        bh=z/ZsT1jcYwNb7ax/VtNUfQkxQ/eId54uF8d1+B3/YiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EkmnAHHy9gPPenOOO98/VuxA7u//WYQLTXKfUJmuXRxPNGAsGCIldUUqTaNRSelrE
         ixaYYCo00JfYaHUiSs/wrTUYc4tl5MjWwvyqOVp/SEf3556nw/ux1OTYqmL/psfNfx
         8T0fZxHovSc+rB/PqkGF8tbcQ5elk62pWGO+A7S4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guangwu Zhang <guazhang@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Subject: [PATCH 6.4 015/800] blk-mq: dont queue plugged passthrough requests into scheduler
Date:   Sun, 16 Jul 2023 21:37:48 +0200
Message-ID: <20230716194949.458921693@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit d97217e7f024bbe9aa62aea070771234c2879358 ]

Passthrough requests should never be queued to the I/O scheduler,
as scheduling these opaque requests doesn't make sense, and I/O
schedulers might require req->bio to be always valid.

We never let passthrough requests insert into the scheduler before
commit 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging"),
restore this behavior even for passthrough requests issued under a plug.

[hch: use blk_mq_insert_requests for passthrough requests,
      fix up the commit message and comments]

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Closes: https://lore.kernel.org/linux-block/CAGS2=YosaYaUTEMU3uaf+y=8MqSrhL7sYsJn8EwbaM=76p_4Qg@mail.gmail.com/
Investigated-by: Yu Kuai <yukuai1@huaweicloud.com>
Fixes: 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230518053101.760632-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 850bfb844ed2f..c763f0bc66371 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2711,6 +2711,7 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 	struct request *requeue_list = NULL;
 	struct request **requeue_lastp = &requeue_list;
 	unsigned int depth = 0;
+	bool is_passthrough = false;
 	LIST_HEAD(list);
 
 	do {
@@ -2719,7 +2720,9 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 		if (!this_hctx) {
 			this_hctx = rq->mq_hctx;
 			this_ctx = rq->mq_ctx;
-		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx) {
+			is_passthrough = blk_rq_is_passthrough(rq);
+		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
+			   is_passthrough != blk_rq_is_passthrough(rq)) {
 			rq_list_add_tail(&requeue_lastp, rq);
 			continue;
 		}
@@ -2731,7 +2734,8 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 	trace_block_unplug(this_hctx->queue, depth, !from_sched);
 
 	percpu_ref_get(&this_hctx->queue->q_usage_counter);
-	if (this_hctx->queue->elevator) {
+	/* passthrough requests should never be issued to the I/O scheduler */
+	if (this_hctx->queue->elevator && !is_passthrough) {
 		this_hctx->queue->elevator->type->ops.insert_requests(this_hctx,
 				&list, 0);
 		blk_mq_run_hw_queue(this_hctx, from_sched);
-- 
2.39.2



