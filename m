Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4305572C05E
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjFLKwM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjFLKvq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:51:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EED193CE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 878AE623DE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F2EC433EF;
        Mon, 12 Jun 2023 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566166;
        bh=EZXBSrnn4rmcAiIq/uelneWDWeLhfV7v914TMY92T2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGApX0UVthjOFQleYxNZssQK8eaVugXobuQIUnXm3InS7wTSk5O4cLXwE6IAk9q0L
         O02l6W8rOre9dw6Lyy/tDCkMwthiCcFLTonDLQFKTOVqUMY3AaFwZDHIkj2Eg1jRmt
         XlPpc9h3JmrbXESyKgBrn2eY2PIzV+PLdbE5nWRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Fang <wei.fang@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 20/91] net: enetc: correct the statistics of rx bytes
Date:   Mon, 12 Jun 2023 12:26:09 +0200
Message-ID: <20230612101702.931145494@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit 7190d0ff0e17690a9b1279d84a06473600ba2060 ]

The rx_bytes of struct net_device_stats should count the length of
ethernet frames excluding the FCS. However, there are two problems
with the rx_bytes statistics of the current enetc driver. one is
that the length of VLAN header is not counted if the VLAN extraction
feature is enabled. The other is that the length of L2 header is not
counted, because eth_type_trans() is invoked before updating rx_bytes
which will subtract the length of L2 header from skb->len.
BTW, the rx_bytes statistics of XDP path also have similar problem,
I will fix it in another patch.

Fixes: a800abd3ecb9 ("net: enetc: move skb creation into enetc_build_skb")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 8b7c93447770c..e16bd2b7692f3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -940,7 +940,13 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 		if (!skb)
 			break;
 
-		rx_byte_cnt += skb->len;
+		/* When set, the outer VLAN header is extracted and reported
+		 * in the receive buffer descriptor. So rx_byte_cnt should
+		 * add the length of the extracted VLAN header.
+		 */
+		if (bd_status & ENETC_RXBD_FLAG_VLAN)
+			rx_byte_cnt += VLAN_HLEN;
+		rx_byte_cnt += skb->len + ETH_HLEN;
 		rx_frm_cnt++;
 
 		napi_gro_receive(napi, skb);
-- 
2.39.2



