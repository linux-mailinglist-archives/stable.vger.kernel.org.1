Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6AB7B8A31
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244373AbjJDSdH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244372AbjJDSdG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:33:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B34E98
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:33:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4538C433C9;
        Wed,  4 Oct 2023 18:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444383;
        bh=6rd0l23x3+8dIKyn7jH/PqnVEFfELCwhaOIJKmTXCnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7NPWid3XtSXrCbCooIVFjAN9a98QRXYdDVCUCMPBHJTLkrrPQj+1rPPhQgwUqBlZ
         7XtyO2rZ+d9LbV8KBXdjg+i3rl8twBQx+n8yA4zsg+owsaOIpiFUnGomyv6gfqW76/
         B+Qn/dBwFsFe67Lgwcmmqse4jFUDISYQ+MP2NRWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 230/321] tsnep: Fix ethtool channels
Date:   Wed,  4 Oct 2023 19:56:15 +0200
Message-ID: <20231004175239.880087694@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerhard Engleder <gerhard@engleder-embedded.com>

[ Upstream commit a7f991953d73dd50c4c23b5437c0139960e1fad4 ]

According to the NAPI documentation networking/napi.rst, for the ethtool
API a channel is a IRQ/NAPI which services queues of a given type.

tsnep uses a single IRQ/NAPI instance for every TX/RX queue pair.
Therefore, combined channels shall be returned instead of separate tx/rx
channels.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/engleder/tsnep_ethtool.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_ethtool.c b/drivers/net/ethernet/engleder/tsnep_ethtool.c
index 716815dad7d21..65ec1abc94421 100644
--- a/drivers/net/ethernet/engleder/tsnep_ethtool.c
+++ b/drivers/net/ethernet/engleder/tsnep_ethtool.c
@@ -300,10 +300,8 @@ static void tsnep_ethtool_get_channels(struct net_device *netdev,
 {
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
 
-	ch->max_rx = adapter->num_rx_queues;
-	ch->max_tx = adapter->num_tx_queues;
-	ch->rx_count = adapter->num_rx_queues;
-	ch->tx_count = adapter->num_tx_queues;
+	ch->max_combined = adapter->num_queues;
+	ch->combined_count = adapter->num_queues;
 }
 
 static int tsnep_ethtool_get_ts_info(struct net_device *netdev,
-- 
2.40.1



