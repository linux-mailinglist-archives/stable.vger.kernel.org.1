Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61FE7ED454
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbjKOU5q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344626AbjKOU5a (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D95EBD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39371C116D6;
        Wed, 15 Nov 2023 20:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081311;
        bh=MzohjNPywIyD60mt0gNk8paixAhPMhavAOIZkR45Vio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lm4n3HZmUMRReZh7HrtSjA1hcnBy9qSuGylO4h/QGqtGCMdIDwu7V5pfyIqvgdI78
         yQyvzmQu7br+wBddvDTlXZjwI77NL82OfxrOR4BThWX8ZNpr2L7KvPwBzL1Az2Jzmp
         b1LmouUBcytPPTVtgVeLtOiuWvpW/AeZEfZM3bKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 050/244] ipvlan: properly track tx_errors
Date:   Wed, 15 Nov 2023 15:34:02 -0500
Message-ID: <20231115203551.371381180@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit ff672b9ffeb3f82135488ac16c5c5eb4b992999b ]

Both ipvlan_process_v4_outbound() and ipvlan_process_v6_outbound()
increment dev->stats.tx_errors in case of errors.

Unfortunately there are two issues :

1) ipvlan_get_stats64() does not propagate dev->stats.tx_errors to user.

2) Increments are not atomic. KCSAN would complain eventually.

Use DEV_STATS_INC() to not miss an update, and change ipvlan_get_stats64()
to copy the value back to user.

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mahesh Bandewar <maheshb@google.com>
Link: https://lore.kernel.org/r/20231026131446.3933175-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipvlan/ipvlan_core.c | 8 ++++----
 drivers/net/ipvlan/ipvlan_main.c | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index e10cb98b0f4f5..905542df3b682 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -442,12 +442,12 @@ static int ipvlan_process_v4_outbound(struct sk_buff *skb)
 
 	err = ip_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out;
 err:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out:
 	return ret;
@@ -483,12 +483,12 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 
 	err = ip6_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out;
 err:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out:
 	return ret;
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index c199f0b465cd0..8660d452f642b 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -324,6 +324,7 @@ static void ipvlan_get_stats64(struct net_device *dev,
 		s->rx_dropped = rx_errs;
 		s->tx_dropped = tx_drps;
 	}
+	s->tx_errors = DEV_STATS_READ(dev, tx_errors);
 }
 
 static int ipvlan_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
-- 
2.42.0



