Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72945713B15
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 19:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjE1RRi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 13:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjE1RRh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 13:17:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943BAB1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 10:17:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2400960D2E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 17:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FC7C433D2;
        Sun, 28 May 2023 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685294255;
        bh=yxGL6/JL6F+7RAhZsFbTRAEsHoP80XPK7LzsE5KgzjE=;
        h=Subject:To:Cc:From:Date:From;
        b=c4lgD+vMOfg6PUNCw73g2/Nakr0xg8eSSQl+50+/kZnrs71WarSIPjyJ22VHXCaPX
         n7CKkt1e4YW6ML4W+DME2LWn8/6iQ4/4pc8XnhPC7VFcp93EvdqtY7dsAd9cu+VN01
         eqE5M+16BoCwy3jsvZ8Ve37EJAmG+CMHJlfy2pD8=
Subject: FAILED: patch "[PATCH] net/mlx5e: do as little as possible in napi poll when budget" failed to apply to 5.4-stable tree
To:     kuba@kernel.org, davem@davemloft.net, simon.horman@corigine.com,
        tariqt@nvidia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 18:17:33 +0100
Message-ID: <2023052832-bunkbed-probable-b8e8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x afbed3f74830163f9559579dee382cac3cff82da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052832-bunkbed-probable-b8e8@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

afbed3f74830 ("net/mlx5e: do as little as possible in napi poll when budget is 0")
214baf22870c ("net/mlx5e: Support HTB offload")
1880bc4e4a96 ("net/mlx5e: Add TX port timestamp support")
145e5637d941 ("net/mlx5e: Add TX PTP port object support")
1a7f51240dfb ("net/mlx5e: Split SW group counters update function")
0b676aaecc25 ("net/mlx5e: Change skb fifo push/pop API to be used without SQ")
579524c6eace ("net/mlx5e: Validate stop_room size upon user input")
3180472f582b ("net/mlx5: Add functions to set/query MFRL register")
573a8095f68c ("Merge tag 'mlx5-updates-2020-09-21' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From afbed3f74830163f9559579dee382cac3cff82da Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 16 May 2023 18:59:35 -0700
Subject: [PATCH] net/mlx5e: do as little as possible in napi poll when budget
 is 0

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

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index a50bfda18e96..fbb2d963fb7e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -161,20 +161,22 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
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

