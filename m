Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2657BC75F
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 14:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbjJGMDY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 08:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343680AbjJGMDX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 08:03:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1C3BC
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 05:03:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FE8C433C8;
        Sat,  7 Oct 2023 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696680201;
        bh=MeN8PH649dzqB0x7tONcTUTDpTyZMdP23E2ZzOB5LqI=;
        h=Subject:To:Cc:From:Date:From;
        b=urTUM8257Ng/LFRlhckaTFT87oaNaE+JNaS9FEndv/bn88vQo3dO14AoXqSQL57RP
         C3RNuiL5oqU6cEWHM2Nwqqp0WyWNLfSK9HFhKK6d8J5B88qj+kKA6GOm/ZSjQPR4nv
         MlmzOTujFEN9tNCIMLnbmqYlWhWcDD31K8G2tYNA=
Subject: FAILED: patch "[PATCH] net: mana: Fix TX CQE error handling" failed to apply to 5.15-stable tree
To:     haiyangz@microsoft.com, horms@kernel.org, pabeni@redhat.com,
        shradhagupta@linux.microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 07 Oct 2023 14:03:10 +0200
Message-ID: <2023100710-robbing-boned-49d7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b2b000069a4c307b09548dc2243f31f3ca0eac9c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100710-robbing-boned-49d7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

b2b000069a4c ("net: mana: Fix TX CQE error handling")
bd7fc6e1957c ("net: mana: Add new MANA VF performance counters for easier troubleshooting")
068c38ad88cc ("net: Remove the obsolte u64_stats_fetch_*_irq() users (drivers).")
cb45a8bf4693 ("net: axienet: Switch to 64-bit RX/TX statistics")
84b9cd389036 ("net: ethernet: mtk_eth_soc: add support for page_pool_get_stats")
23233e577ef9 ("net: ethernet: mtk_eth_soc: rely on page_pool for single page buffers")
67dffd3db985 ("net: hinic: fix bug that ethtool get wrong stats")
7c2c57263af4 ("hinic: Use the bitmap API when applicable")
7a8938cd024d ("net: mana: Add support of XDP_REDIRECT action")
9ec321aba2ea ("team: adopt u64_stats_t")
5665f48ef309 ("ipvlan: adopt u64_stats_t")
09cca53c1656 ("vlan: adopt u64_stats_t")
a98a62e456e2 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b2b000069a4c307b09548dc2243f31f3ca0eac9c Mon Sep 17 00:00:00 2001
From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Fri, 29 Sep 2023 13:42:25 -0700
Subject: [PATCH] net: mana: Fix TX CQE error handling

For an unknown TX CQE error type (probably from a newer hardware),
still free the SKB, update the queue tail, etc., otherwise the
accounting will be wrong.

Also, TX errors can be triggered by injecting corrupted packets, so
replace the WARN_ONCE to ratelimited error logging.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 4a16ebff3d1d..5cdcf7561b38 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1317,19 +1317,23 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
 		case CQE_TX_VPORT_IDX_OUT_OF_RANGE:
 		case CQE_TX_VPORT_DISABLED:
 		case CQE_TX_VLAN_TAGGING_VIOLATION:
-			WARN_ONCE(1, "TX: CQE error %d: ignored.\n",
-				  cqe_oob->cqe_hdr.cqe_type);
+			if (net_ratelimit())
+				netdev_err(ndev, "TX: CQE error %d\n",
+					   cqe_oob->cqe_hdr.cqe_type);
+
 			apc->eth_stats.tx_cqe_err++;
 			break;
 
 		default:
-			/* If the CQE type is unexpected, log an error, assert,
-			 * and go through the error path.
+			/* If the CQE type is unknown, log an error,
+			 * and still free the SKB, update tail, etc.
 			 */
-			WARN_ONCE(1, "TX: Unexpected CQE type %d: HW BUG?\n",
-				  cqe_oob->cqe_hdr.cqe_type);
+			if (net_ratelimit())
+				netdev_err(ndev, "TX: unknown CQE type %d\n",
+					   cqe_oob->cqe_hdr.cqe_type);
+
 			apc->eth_stats.tx_cqe_unknown_type++;
-			return;
+			break;
 		}
 
 		if (WARN_ON_ONCE(txq->gdma_txq_id != completions[i].wq_num))

