Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97427D3117
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjJWLF2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjJWLF1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:05:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EC4D7C
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:05:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7947C433C7;
        Mon, 23 Oct 2023 11:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059124;
        bh=a0w98Fuq2HnAtQAp/AIYQYmguwtnvTUHbu8GjDM/+aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6QeqeQAR9aMnaz+R1Au1+ANWEOe5tC0J+0Tj0an9XnOcDQ6Eo0GOeW3BCr0lW6LU
         dS26izyx4CzzqGDyn3p4dHh09JjDPjCketj5voYikw5cFd88c1aeyq+Jzpn42tpOAs
         t78P+NcbMSh9Ffeo+SItnm0KRUB3xkwQegBXdqGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shinas Rasheed <srasheed@marvell.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 072/241] octeon_ep: update BQL sent bytes before ringing doorbell
Date:   Mon, 23 Oct 2023 12:54:18 +0200
Message-ID: <20231023104835.649539996@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shinas Rasheed <srasheed@marvell.com>

commit a0ca6b9dfef0b3cc83aa8bb485ed61a018f84982 upstream.

Sometimes Tx is completed immediately after doorbell is updated, which
causes Tx completion routing to update completion bytes before the
same packet bytes are updated in sent bytes in transmit function, hence
hitting BUG_ON() in dql_completed(). To avoid this, update BQL
sent bytes before ringing doorbell.

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Link: https://lore.kernel.org/r/20231017105030.2310966-1-srasheed@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -715,20 +715,19 @@ static netdev_tx_t octep_start_xmit(stru
 		hw_desc->dptr = tx_buffer->sglist_dma;
 	}
 
-	/* Flush the hw descriptor before writing to doorbell */
-	wmb();
-
-	/* Ring Doorbell to notify the NIC there is a new packet */
-	writel(1, iq->doorbell_reg);
+	netdev_tx_sent_queue(iq->netdev_q, skb->len);
+	skb_tx_timestamp(skb);
 	atomic_inc(&iq->instr_pending);
 	wi++;
 	if (wi == iq->max_count)
 		wi = 0;
 	iq->host_write_index = wi;
+	/* Flush the hw descriptor before writing to doorbell */
+	wmb();
 
-	netdev_tx_sent_queue(iq->netdev_q, skb->len);
+	/* Ring Doorbell to notify the NIC there is a new packet */
+	writel(1, iq->doorbell_reg);
 	iq->stats.instr_posted++;
-	skb_tx_timestamp(skb);
 	return NETDEV_TX_OK;
 
 dma_map_sg_err:


