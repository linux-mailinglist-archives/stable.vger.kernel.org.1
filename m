Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9919D78AB47
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjH1K3p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjH1K3X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:29:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9C8AB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C229163BFD
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D645CC433C8;
        Mon, 28 Aug 2023 10:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218560;
        bh=s3rASLW+Q82ni6FayfndvZGk7xYX5BOL76wIPcwm32s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWGDjrAk2kLyHFT+sLyxnB/Y0g0x/JrReS8IIZA/DHbbYr0zLx1wnEl/BpcTrAWNw
         U8LSCb5woH1Qq45DWGOmg3XyJnm5x3cBv9+2eS2nkmriR4myP5rG1ap8TiYWTzFGqO
         H26Ar9kaEY+W9DymzpElIN8KzIaMtFjVOCQQ1X8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yibin Ding <yibin.ding@unisoc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 121/129] mmc: block: Fix in_flight[issue_type] value error
Date:   Mon, 28 Aug 2023 12:13:35 +0200
Message-ID: <20230828101157.638612575@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/block.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1976,15 +1976,16 @@ static void mmc_blk_mq_poll_completion(s
 	mmc_blk_urgent_bkops(mq, mqrq);
 }
 
-static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq,
+				     struct request_queue *q,
+				     enum mmc_issue_type issue_type)
 {
-	struct request_queue *q = req->q;
 	unsigned long flags;
 	bool put_card;
 
 	spin_lock_irqsave(q->queue_lock, flags);
 
-	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+	mq->in_flight[issue_type] -= 1;
 
 	put_card = (mmc_tot_in_flight(mq) == 0);
 
@@ -1996,9 +1997,11 @@ static void mmc_blk_mq_dec_in_flight(str
 
 static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 {
+	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 	struct mmc_host *host = mq->card->host;
+	struct request_queue *q = req->q;
 
 	mmc_post_req(host, mrq, 0);
 
@@ -2011,7 +2014,7 @@ static void mmc_blk_mq_post_req(struct m
 	else
 		blk_mq_complete_request(req);
 
-	mmc_blk_mq_dec_in_flight(mq, req);
+	mmc_blk_mq_dec_in_flight(mq, q, issue_type);
 }
 
 void mmc_blk_mq_recovery(struct mmc_queue *mq)


