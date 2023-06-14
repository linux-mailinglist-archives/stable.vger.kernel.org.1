Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8167D713FA2
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjE1Tr0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjE1TrZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:47:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9439E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF2E861FA8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182EFC433EF;
        Sun, 28 May 2023 19:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303243;
        bh=0EwTRxhSXUqGRcP1zOukaj42H+SmOj0oYf7juqLd//4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e5/NEu9yzC0F+ly5uh/a1f+FRqDiKXItblGQGuaWqq7qaCADprQ3ocO+obHcX71yU
         fKi7Z2DzSLGxtsGOYRFLPqovqG/vm8RlI5zV0yb/8nOkY+GMJM5n0ihYYY7sa/XFD/
         SFOu5QNV1ERHXfH5OL7E5aJQvmNIbMXq67reVX/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tariq Toukan <tariqt@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.10 205/211] net/mlx5e: do as little as possible in napi poll when budget is 0
Date:   Sun, 28 May 2023 20:12:06 +0100
Message-Id: <20230528190848.587216328@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

commit afbed3f74830163f9559579dee382cac3cff82da upstream.

NAPI gets called with budget of 0 from netpoll, which has interrupts
disabled. We should try to free some space on Tx rings and nothing
else.

Specifically do not try to handle XDP TX or try to refill Rx buffers -
we can't use the page pool from IRQ context. Don't check if IRQs moved,
either, that makes no sense in netpoll. Netpoll calls _all_ the rings
from whatever CPU it happens to be invoked on.

In general do as little as possible, the work quickly adds up when
there's tens of rings to poll.

The immediate stack trace I was seeing is:

    __do_softirq+0xd1/0x2c0
    __local_bh_enable_ip+0xc7/0x120
    </IRQ>
    <TASK>
    page_pool_put_defragged_page+0x267/0x320
    mlx5e_free_xdpsq_desc+0x99/0xd0
    mlx5e_poll_xdpsq_cq+0x138/0x3b0
    mlx5e_napi_poll+0xc3/0x8b0
    netpoll_poll_dev+0xce/0x150

AFAIU page pool takes a BH lock, releases it and since BH is now
enabled tries to run softirqs.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Fixes: 60bbf7eeef10 ("mlx5: use page_pool for xdp_return_frame call")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -137,20 +137,22 @@ int mlx5e_napi_poll(struct napi_struct *
 	for (i = 0; i < c->num_tc; i++)
 		busy |= mlx5e_poll_tx_cq(&c->sq[i].cq, budget);
 
+	/* budget=0 means we may be in IRQ context, do as little as possible */
+	if (unlikely(!budget))
+		goto out;
+
 	busy |= mlx5e_poll_xdpsq_cq(&c->xdpsq.cq);
 
 	if (c->xdp)
 		busy |= mlx5e_poll_xdpsq_cq(&c->rq_xdpsq.cq);
 
-	if (likely(budget)) { /* budget=0 means: don't poll rx rings */
-		if (xsk_open)
-			work_done = mlx5e_poll_rx_cq(&xskrq->cq, budget);
+	if (xsk_open)
+		work_done = mlx5e_poll_rx_cq(&xskrq->cq, budget);
 
-		if (likely(budget - work_done))
-			work_done += mlx5e_poll_rx_cq(&rq->cq, budget - work_done);
+	if (likely(budget - work_done))
+		work_done += mlx5e_poll_rx_cq(&rq->cq, budget - work_done);
 
-		busy |= work_done == budget;
-	}
+	busy |= work_done == budget;
 
 	mlx5e_poll_ico_cq(&c->icosq.cq);
 	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))


