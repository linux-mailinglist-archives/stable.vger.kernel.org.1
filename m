Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781647827E6
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 13:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjHUL3Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 07:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjHUL3X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 07:29:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDBADC
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 04:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2503F609AE
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 11:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC99C433C7;
        Mon, 21 Aug 2023 11:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692617361;
        bh=iUWSJm1IrtpxYw9/sU4ioSUMSLBCSYMF0Wjx/kxSil8=;
        h=Subject:To:Cc:From:Date:From;
        b=wH5coqBMHnoOS1O3l7VRidxj4UFDHLmAo9NMKfA3nl73fN0OcNrNjNn5Me6E20BJf
         bVvv702XHlUrDWiXBqc1pZ9TFGtvt4U3suh6/ackmHjiSl575mwldevQdCVwzx2vax
         t+4CNRSbgzkQyQRUDDwlCF6BswjpM2D0xxaTvwWQ=
Subject: FAILED: patch "[PATCH] mmc: block: Fix in_flight[issue_type] value error" failed to apply to 4.19-stable tree
To:     yibin.ding@unisoc.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 21 Aug 2023 13:29:18 +0200
Message-ID: <2023082118-donation-clench-604d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 4b430d4ac99750ee2ae2f893f1055c7af1ec3dc5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082118-donation-clench-604d@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

4b430d4ac997 ("mmc: block: Fix in_flight[issue_type] value error")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4b430d4ac99750ee2ae2f893f1055c7af1ec3dc5 Mon Sep 17 00:00:00 2001
From: Yibin Ding <yibin.ding@unisoc.com>
Date: Wed, 2 Aug 2023 10:30:23 +0800
Subject: [PATCH] mmc: block: Fix in_flight[issue_type] value error

For a completed request, after the mmc_blk_mq_complete_rq(mq, req)
function is executed, the bitmap_tags corresponding to the
request will be cleared, that is, the request will be regarded as
idle. If the request is acquired by a different type of process at
this time, the issue_type of the request may change. It further
caused the value of mq->in_flight[issue_type] to be abnormal,
and a large number of requests could not be sent.

p1:					      p2:
mmc_blk_mq_complete_rq
  blk_mq_free_request
					      blk_mq_get_request
					        blk_mq_rq_ctx_init
mmc_blk_mq_dec_in_flight
  mmc_issue_type(mq, req)

This strategy can ensure the consistency of issue_type
before and after executing mmc_blk_mq_complete_rq.

Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
Cc: stable@vger.kernel.org
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20230802023023.1318134-1-yunlong.xing@unisoc.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f701efb1fa78..b6f4be25b31b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2097,14 +2097,14 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
 	mmc_blk_urgent_bkops(mq, mqrq);
 }
 
-static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, enum mmc_issue_type issue_type)
 {
 	unsigned long flags;
 	bool put_card;
 
 	spin_lock_irqsave(&mq->lock, flags);
 
-	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+	mq->in_flight[issue_type] -= 1;
 
 	put_card = (mmc_tot_in_flight(mq) == 0);
 
@@ -2117,6 +2117,7 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
 static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
 				bool can_sleep)
 {
+	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 	struct mmc_host *host = mq->card->host;
@@ -2136,7 +2137,7 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
 			blk_mq_complete_request(req);
 	}
 
-	mmc_blk_mq_dec_in_flight(mq, req);
+	mmc_blk_mq_dec_in_flight(mq, issue_type);
 }
 
 void mmc_blk_mq_recovery(struct mmc_queue *mq)

