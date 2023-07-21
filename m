Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DEE75D328
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjGUTHl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjGUTHj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:07:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001813AB6
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D817B61D7F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABFCC433C7;
        Fri, 21 Jul 2023 19:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966448;
        bh=FRKskgbr15T/xvLME4WGWUYCkU0EmhO8V8CXiN5Cq8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHIe/LAj00tUSgzgy5BBJQhwN/t8JRaRcsNr41tvrSG2QzIEWdzrXFk79CKUBdjvf
         GOVogz353iw5ioGqa0p8cMaAekQRNw0y7ggLqAlp+bJTfHvb680P20MA9WPJ4W/Od/
         SqJuhb78HJcnbG2AwhFk6cSnocVcyW8EVr0cscTc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nick Child <nnac123@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 319/532] ibmvnic: Do not reset dql stats on NON_FATAL err
Date:   Fri, 21 Jul 2023 18:03:43 +0200
Message-ID: <20230721160631.708766504@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nick Child <nnac123@linux.ibm.com>

[ Upstream commit 48538ccb825b05544ec308a509e2cc9c013402db ]

All ibmvnic resets, make a call to netdev_tx_reset_queue() when
re-opening the device. netdev_tx_reset_queue() resets the num_queued
and num_completed byte counters. These stats are used in Byte Queue
Limit (BQL) algorithms. The difference between these two stats tracks
the number of bytes currently sitting on the physical NIC. ibmvnic
increases the number of queued bytes though calls to
netdev_tx_sent_queue() in the drivers xmit function. When, VIOS reports
that it is done transmitting bytes, the ibmvnic device increases the
number of completed bytes through calls to netdev_tx_completed_queue().
It is important to note that the driver batches its transmit calls and
num_queued is increased every time that an skb is added to the next
batch, not necessarily when the batch is sent to VIOS for transmission.

Unlike other reset types, a NON FATAL reset will not flush the sub crq
tx buffers. Therefore, it is possible for the batched skb array to be
partially full. So if there is call to netdev_tx_reset_queue() when
re-opening the device, the value of num_queued (0) would not account
for the skb's that are currently batched. Eventually, when the batch
is sent to VIOS, the call to netdev_tx_completed_queue() would increase
num_completed to a value greater than the num_queued. This causes a
BUG_ON crash:

ibmvnic 30000002: Firmware reports error, cause: adapter problem.
Starting recovery...
ibmvnic 30000002: tx error 600
ibmvnic 30000002: tx error 600
ibmvnic 30000002: tx error 600
ibmvnic 30000002: tx error 600
------------[ cut here ]------------
kernel BUG at lib/dynamic_queue_limits.c:27!
Oops: Exception in kernel mode, sig: 5
[....]
NIP dql_completed+0x28/0x1c0
LR ibmvnic_complete_tx.isra.0+0x23c/0x420 [ibmvnic]
Call Trace:
ibmvnic_complete_tx.isra.0+0x3f8/0x420 [ibmvnic] (unreliable)
ibmvnic_interrupt_tx+0x40/0x70 [ibmvnic]
__handle_irq_event_percpu+0x98/0x270
---[ end trace ]---

Therefore, do not reset the dql stats when performing a NON_FATAL reset.

Fixes: 0d973388185d ("ibmvnic: Introduce xmit_more support using batched subCRQ hcalls")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 8a92c6a6e764f..765dee2e4882e 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1240,7 +1240,14 @@ static int __ibmvnic_open(struct net_device *netdev)
 		if (prev_state == VNIC_CLOSED)
 			enable_irq(adapter->tx_scrq[i]->irq);
 		enable_scrq_irq(adapter, adapter->tx_scrq[i]);
-		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, i));
+		/* netdev_tx_reset_queue will reset dql stats. During NON_FATAL
+		 * resets, don't reset the stats because there could be batched
+		 * skb's waiting to be sent. If we reset dql stats, we risk
+		 * num_completed being greater than num_queued. This will cause
+		 * a BUG_ON in dql_completed().
+		 */
+		if (adapter->reset_reason != VNIC_RESET_NON_FATAL)
+			netdev_tx_reset_queue(netdev_get_tx_queue(netdev, i));
 	}
 
 	rc = set_link_state(adapter, IBMVNIC_LOGICAL_LNK_UP);
-- 
2.39.2



