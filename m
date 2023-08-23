Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC7F785E55
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 19:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjHWRMl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 13:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjHWRMl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 13:12:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76101E67
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 10:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692810759; x=1724346759;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5Ulk0Bu3sN0RtTnpf9zDQqQkXkaEHU82J2k6zJcx200=;
  b=lK0X0TlYqLE/JdNlWCxD9VOwBn6IHbakTRDJsTF7llZI48yX5EQPbMyF
   1mLNfzm3kVrgE7A1oXImkAP9b+67/7GnW2LeQ6BOc6mCAdtahmuiw46UP
   7+9eAs+0jOFhnV62SsMkrzOM0AVRy/IbOKLIn2zaEqklmz93DVhh2iVKa
   GUvNouBr1wdNaSnPKUsS4eZ2T8YUuSmUwJ0UxPdvOGqD/ApE1aKJd1Taj
   K1pB+XwWkF2g/SNF+DoBT/7cZNkGbPrDCtPfl/f4Qbg8ycsb5miv9pu1R
   dwzXbLvSzb2UkTVLadF3sw+FbiWJCVAF8p+8Apx5KETYEnHWrbQhTcF8V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="438148117"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438148117"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 10:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="860382362"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="860382362"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.188])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 10:12:37 -0700
Message-ID: <9aa71735-a941-dc24-e04b-529d6092e340@intel.com>
Date:   Wed, 23 Aug 2023 20:12:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: [PATCH 4.19] mmc: block: Fix in_flight[issue_type] value error
Content-Language: en-US
To:     stable@vger.kernel.org
Cc:     yibin.ding@unisoc.com, ulf.hansson@linaro.org
References: <2023082118-donation-clench-604d@gregkh>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <2023082118-donation-clench-604d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
(cherry picked from commit 4b430d4ac99750ee2ae2f893f1055c7af1ec3dc5)
(backport to 4.19.y)
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 88114e576efb..039058fe6a41 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1976,15 +1976,16 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
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
 
@@ -1996,9 +1997,11 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
 
 static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 {
+	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 	struct mmc_host *host = mq->card->host;
+	struct request_queue *q = req->q;
 
 	mmc_post_req(host, mrq, 0);
 
@@ -2011,7 +2014,7 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 	else
 		blk_mq_complete_request(req);
 
-	mmc_blk_mq_dec_in_flight(mq, req);
+	mmc_blk_mq_dec_in_flight(mq, q, issue_type);
 }
 
 void mmc_blk_mq_recovery(struct mmc_queue *mq)
-- 
2.34.1
