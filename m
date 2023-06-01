Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DAC719DE0
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjFAN1J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjFAN05 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37925E54
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:26:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB94B644B1
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C72C433D2;
        Thu,  1 Jun 2023 13:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626002;
        bh=kp4NH6kuTfoajtNRN44vB2bn8bHkMuohEdDR+u0O1Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=secnZF2lAK5umyLNip3wd7zVZBaBTNpDkTf9t5iK2yPy3KOSqXxP3HC3YvdbXxmoL
         /p6ij2hRcbUo5rowK/8Fhco3jAem564B00oippYyBC/x4lMpZmuARMVMoibBdHUkef
         qV84KYkg41T3jE3pR8Tku2u8hytEC5XP0fDCVaeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 37/45] blk-wbt: fix that wbt cant be disabled by default
Date:   Thu,  1 Jun 2023 14:21:33 +0100
Message-Id: <20230601131940.390074247@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 8a2b20a997a3779ae9fcae268f2959eb82ec05a1 ]

commit b11d31ae01e6 ("blk-wbt: remove unnecessary check in
wbt_enable_default()") removes the checking of CONFIG_BLK_WBT_MQ by
mistake, which is used to control enable or disable wbt by default.

Fix the problem by adding back the checking. This patch also do a litter
cleanup to make related code more readable.

Fixes: b11d31ae01e6 ("blk-wbt: remove unnecessary check in wbt_enable_default()")
Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Link: https://lore.kernel.org/lkml/CAKXUXMzfKq_J9nKHGyr5P5rvUETY4B-fxoQD4sO+NYjFOfVtZA@mail.gmail.com/t/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230522121854.2928880-1-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-wbt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index e49a486845327..9ec2a2f1eda38 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -730,14 +730,16 @@ void wbt_enable_default(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct rq_qos *rqos;
-	bool disable_flag = q->elevator &&
-		    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags);
+	bool enable = IS_ENABLED(CONFIG_BLK_WBT_MQ);
+
+	if (q->elevator &&
+	    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags))
+		enable = false;
 
 	/* Throttling already enabled? */
 	rqos = wbt_rq_qos(q);
 	if (rqos) {
-		if (!disable_flag &&
-		    RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
+		if (enable && RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
 			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
 		return;
 	}
@@ -746,7 +748,7 @@ void wbt_enable_default(struct gendisk *disk)
 	if (!blk_queue_registered(q))
 		return;
 
-	if (queue_is_mq(q) && !disable_flag)
+	if (queue_is_mq(q) && enable)
 		wbt_init(disk);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
-- 
2.39.2



