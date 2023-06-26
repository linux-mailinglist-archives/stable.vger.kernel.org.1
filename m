Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D20D73E954
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjFZSez (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjFZSep (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:34:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C9410D7
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB3E160F24
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40F9C433C8;
        Mon, 26 Jun 2023 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804480;
        bh=BTSyExj0K+ylLZERpJeALYBf8Qakbgtntea/TrquynU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oiMPkT+ZZZ9dgVrenvl+LKL0Avzd+h6nEJP1CfpIFq82EGsPi/qhTcsRNefrhwTay
         uKDh1cBq/0GiE5+9aOAJxaoC5GQufpmWb2VN8ThwVf0zYvcVqHuzI3xsWwgN81Pu1q
         /28sVC6QEMHkIYldbIgxg2A653j8or1GpJRVQZbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Costa Sapuntzakis <costa@purestorage.com>,
        Randy Jennings <randyj@purestorage.com>,
        Uday Shankar <ushankar@purestorage.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 143/170] nvme: improve handling of long keep alives
Date:   Mon, 26 Jun 2023 20:11:52 +0200
Message-ID: <20230626180806.954518925@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit c7275ce6a5fd32ca9f5a6294ed89cf0523181af9 ]

Upon keep alive completion, nvme_keep_alive_work is scheduled with the
same delay every time. If keep alive commands are completing slowly,
this may cause a keep alive timeout. The following trace illustrates the
issue, taking KATO = 8 and TBKAS off for simplicity:

1. t = 0: run nvme_keep_alive_work, send keep alive
2. t = ε: keep alive reaches controller, controller restarts its keep
          alive timer
3. t = 4: host receives keep alive completion, schedules
          nvme_keep_alive_work with delay 4
4. t = 8: run nvme_keep_alive_work, send keep alive

Here, a keep alive having RTT of 4 causes a delay of at least 8 - ε
between the controller receiving successive keep alives. With ε small,
the controller is likely to detect a keep alive timeout.

Fix this by calculating the RTT of the keep alive command, and adjusting
the scheduling delay of the next keep alive work accordingly.

Reported-by: Costa Sapuntzakis <costa@purestorage.com>
Reported-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 15eb2ee1be66e..a7d9b5b42b388 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1234,6 +1234,20 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 	struct nvme_ctrl *ctrl = rq->end_io_data;
 	unsigned long flags;
 	bool startka = false;
+	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
+	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+
+	/*
+	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
+	 * at the desired frequency.
+	 */
+	if (rtt <= delay) {
+		delay -= rtt;
+	} else {
+		dev_warn(ctrl->device, "long keepalive RTT (%u ms)\n",
+			 jiffies_to_msecs(rtt));
+		delay = 0;
+	}
 
 	blk_mq_free_request(rq);
 
@@ -1252,7 +1266,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-		nvme_queue_keep_alive_work(ctrl);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 	return RQ_END_IO_NONE;
 }
 
-- 
2.39.2



