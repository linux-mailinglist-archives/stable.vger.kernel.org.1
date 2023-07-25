Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7476137C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjGYLLA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjGYLKg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:10:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C072137
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36B3B6165D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451C8C433C7;
        Tue, 25 Jul 2023 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283380;
        bh=vn1+6KUuDs5vuPg9PDSVYe/0BrWiVIUPjwT4JYb2ixo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dvz5cM8DolbMi6tBOUjPzklmCtZAOosQ9cC7dzRKQ7TE6A/Wc7MlKLzbk5ZJhoUIK
         X41dnIADUE2BtKhAE5+RsaDmq+Lgw/xKedcLzPYTdwH3A6k7EBPJZfFGbx4VUQA/zS
         0LZWhAUdVi4w4YIYXyU0Tl3cGFdDdPrYuDL90lBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Florian Kauer <florian.kauer@linutronix.de>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 54/78] igc: Prevent garbled TX queue with XDP ZEROCOPY
Date:   Tue, 25 Jul 2023 12:46:45 +0200
Message-ID: <20230725104453.364066666@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Kauer <florian.kauer@linutronix.de>

[ Upstream commit 78adb4bcf99effbb960c5f9091e2e062509d1030 ]

In normal operation, each populated queue item has
next_to_watch pointing to the last TX desc of the packet,
while each cleaned item has it set to 0. In particular,
next_to_use that points to the next (necessarily clean)
item to use has next_to_watch set to 0.

When the TX queue is used both by an application using
AF_XDP with ZEROCOPY as well as a second non-XDP application
generating high traffic, the queue pointers can get in
an invalid state where next_to_use points to an item
where next_to_watch is NOT set to 0.

However, the implementation assumes at several places
that this is never the case, so if it does hold,
bad things happen. In particular, within the loop inside
of igc_clean_tx_irq(), next_to_clean can overtake next_to_use.
Finally, this prevents any further transmission via
this queue and it never gets unblocked or signaled.
Secondly, if the queue is in this garbled state,
the inner loop of igc_clean_tx_ring() will never terminate,
completely hogging a CPU core.

The reason is that igc_xdp_xmit_zc() reads next_to_use
before acquiring the lock, and writing it back
(potentially unmodified) later. If it got modified
before locking, the outdated next_to_use is written
pointing to an item that was already used elsewhere
(and thus next_to_watch got written).

Fixes: 9acf59a752d4 ("igc: Enable TX via AF_XDP zero-copy")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://lore.kernel.org/r/20230717175444.3217831-1-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2748,15 +2748,15 @@ static void igc_xdp_xmit_zc(struct igc_r
 	struct netdev_queue *nq = txring_txq(ring);
 	union igc_adv_tx_desc *tx_desc = NULL;
 	int cpu = smp_processor_id();
-	u16 ntu = ring->next_to_use;
 	struct xdp_desc xdp_desc;
-	u16 budget;
+	u16 budget, ntu;
 
 	if (!netif_carrier_ok(ring->netdev))
 		return;
 
 	__netif_tx_lock(nq, cpu);
 
+	ntu = ring->next_to_use;
 	budget = igc_desc_unused(ring);
 
 	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {


