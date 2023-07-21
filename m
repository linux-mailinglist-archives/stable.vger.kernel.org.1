Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB63975CD55
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjGUQK2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjGUQK2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C8930D0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7853061D26
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F5AC433C7;
        Fri, 21 Jul 2023 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955806;
        bh=vFb9m783xJIvC3aPlcuyv0v0nqHaFfFynC8gtJKsVr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/UwlIY9/8qWPaF3yRzwMnS573EgDGRgrY+vWt0BbCdz4RsNjeWsgvR//wqegIBEm
         iWI34aAg9fVY6QllvAGjXjVLHrOZ2W0JB+rGPAX1On85mLDhTWwQmUS52QlF0yRpxc
         s3merYR5wtXNit/CNMGDZZaCLxF1CsyiMel6VXbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tan Tee Min <tee.min.tan@linux.intel.com>,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 036/292] igc: Include the length/type field and VLAN tag in queueMaxSDU
Date:   Fri, 21 Jul 2023 18:02:25 +0200
Message-ID: <20230721160530.350071548@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tan Tee Min <tee.min.tan@linux.intel.com>

[ Upstream commit 25102893e409bc02761ab82dbcfa092006404790 ]

IEEE 802.1Q does not have clear definitions of what constitutes an
SDU (Service Data Unit), but IEEE Std 802.3 clause 3.1.2 does define
the MAC service primitives and clause 3.2.7 does define the MAC Client
Data for Q-tagged frames.

It shows that the mac_service_data_unit (MSDU) does NOT contain the
preamble, destination and source address, or FCS. The MSDU does contain
the length/type field, MAC client data, VLAN tag and any padding
data (prior to the FCS).

Thus, the maximum 802.3 frame size that is allowed to be transmitted
should be QueueMaxSDU (MSDU) + 16 (6 byte SA + 6 byte DA + 4 byte FCS).

Fixes: 92a0dcb8427d ("igc: offload queue max SDU from tc-taprio")
Signed-off-by: Tan Tee Min <tee.min.tan@linux.intel.com>
Reviewed-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 826556e609800..e7bd2c60ee383 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1575,16 +1575,9 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	if (adapter->qbv_transition || tx_ring->oper_gate_closed)
 		goto out_drop;
 
-	if (tx_ring->max_sdu > 0) {
-		u32 max_sdu = 0;
-
-		max_sdu = tx_ring->max_sdu +
-			  (skb_vlan_tagged(first->skb) ? VLAN_HLEN : 0);
-
-		if (first->bytecount > max_sdu) {
-			adapter->stats.txdrop++;
-			goto out_drop;
-		}
+	if (tx_ring->max_sdu > 0 && first->bytecount > tx_ring->max_sdu) {
+		adapter->stats.txdrop++;
+		goto out_drop;
 	}
 
 	if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
@@ -6215,7 +6208,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 		struct net_device *dev = adapter->netdev;
 
 		if (qopt->max_sdu[i])
-			ring->max_sdu = qopt->max_sdu[i] + dev->hard_header_len;
+			ring->max_sdu = qopt->max_sdu[i] + dev->hard_header_len - ETH_TLEN;
 		else
 			ring->max_sdu = 0;
 	}
-- 
2.39.2



