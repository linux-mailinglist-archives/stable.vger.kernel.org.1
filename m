Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0917876EC
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbjHXRVM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242861AbjHXRUu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAFFE50
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C72B6245D
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A27AC433C8;
        Thu, 24 Aug 2023 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897647;
        bh=G7HlSQBEaIZSwyVxOKGducYTsn4ZoNn65yk2/F90tj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ok4w82K5T0xM5F2y03QddaDufUTJJlNEcgMr10jlXYpAWXrhudjIend7LVR/U6IOd
         fwL513rxQyZLOewSM6JBfGWJUA+AOV5h6T8kCTCuL/O1/GiXLxZtvEN4CuHgWB6lGA
         abj4oRfb4H/7yN14vqOFP935SlcRGT9w5/HPzVaU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yibin Ding <yibin.ding@unisoc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.10 113/135] mmc: block: Fix in_flight[issue_type] value error
Date:   Thu, 24 Aug 2023 19:09:45 +0200
Message-ID: <20230824170622.180372253@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yibin Ding <yibin.ding@unisoc.com>

commit 4b430d4ac99750ee2ae2f893f1055c7af1ec3dc5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/block.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1980,14 +1980,14 @@ static void mmc_blk_mq_poll_completion(s
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
 
@@ -1999,6 +1999,7 @@ static void mmc_blk_mq_dec_in_flight(str
 
 static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 {
+	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 	struct mmc_host *host = mq->card->host;
@@ -2014,7 +2015,7 @@ static void mmc_blk_mq_post_req(struct m
 	else if (likely(!blk_should_fake_timeout(req->q)))
 		blk_mq_complete_request(req);
 
-	mmc_blk_mq_dec_in_flight(mq, req);
+	mmc_blk_mq_dec_in_flight(mq, issue_type);
 }
 
 void mmc_blk_mq_recovery(struct mmc_queue *mq)


