Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27450787687
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbjHXRQ6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242231AbjHXRQs (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:16:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5566019B0
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFEA6639FF
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F221FC433C8;
        Thu, 24 Aug 2023 17:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897405;
        bh=/MV4eOnupNXRIAJqmiBXweZWFM3bGG06I8k/sPEo8SQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ReKpgGzlqcc7kouhbNxHuaeTw0JFbZ+Fa34LdZLst/hqMlRqJS4p/QRIoOhuanqe7
         a7mr44TZS8B5BePwOPsvbD8YxIt/pHKvHYOteWKyK6gZkY0c8Tioe4atFy3D2JSbcD
         4OPpGWqJriITWEfqJ6RrGA8t4gfGpji6w7PtbgNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 003/135] macsec: use DEV_STATS_INC()
Date:   Thu, 24 Aug 2023 19:07:55 +0200
Message-ID: <20230824170617.243399888@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 32d0a49d36a2a306c2e47fe5659361e424f0ed3f ]

syzbot/KCSAN reported data-races in macsec whenever dev->stats fields
are updated.

It appears all of these updates can happen from multiple cpus.

Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 6691c941f8bb8..2ad15b1d7ffd7 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -765,7 +765,7 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsLate++;
 		u64_stats_update_end(&rxsc_stats->syncp);
-		secy->netdev->stats.rx_dropped++;
+		DEV_STATS_INC(secy->netdev, rx_dropped);
 		return false;
 	}
 
@@ -789,7 +789,7 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 			rxsc_stats->stats.InPktsNotValid++;
 			u64_stats_update_end(&rxsc_stats->syncp);
 			this_cpu_inc(rx_sa->stats->InPktsNotValid);
-			secy->netdev->stats.rx_errors++;
+			DEV_STATS_INC(secy->netdev, rx_errors);
 			return false;
 		}
 
@@ -1075,7 +1075,7 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsNoTag++;
 			u64_stats_update_end(&secy_stats->syncp);
-			macsec->secy.netdev->stats.rx_dropped++;
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 			continue;
 		}
 
@@ -1185,7 +1185,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		u64_stats_update_begin(&secy_stats->syncp);
 		secy_stats->stats.InPktsBadTag++;
 		u64_stats_update_end(&secy_stats->syncp);
-		secy->netdev->stats.rx_errors++;
+		DEV_STATS_INC(secy->netdev, rx_errors);
 		goto drop_nosa;
 	}
 
@@ -1202,7 +1202,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsNotUsingSA++;
 			u64_stats_update_end(&rxsc_stats->syncp);
-			secy->netdev->stats.rx_errors++;
+			DEV_STATS_INC(secy->netdev, rx_errors);
 			if (active_rx_sa)
 				this_cpu_inc(active_rx_sa->stats->InPktsNotUsingSA);
 			goto drop_nosa;
@@ -1236,7 +1236,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsLate++;
 			u64_stats_update_end(&rxsc_stats->syncp);
-			macsec->secy.netdev->stats.rx_dropped++;
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 			goto drop;
 		}
 	}
@@ -1277,7 +1277,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	if (ret == NET_RX_SUCCESS)
 		count_rx(dev, len);
 	else
-		macsec->secy.netdev->stats.rx_dropped++;
+		DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 
 	rcu_read_unlock();
 
@@ -1314,7 +1314,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsNoSCI++;
 			u64_stats_update_end(&secy_stats->syncp);
-			macsec->secy.netdev->stats.rx_errors++;
+			DEV_STATS_INC(macsec->secy.netdev, rx_errors);
 			continue;
 		}
 
@@ -1333,7 +1333,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			secy_stats->stats.InPktsUnknownSCI++;
 			u64_stats_update_end(&secy_stats->syncp);
 		} else {
-			macsec->secy.netdev->stats.rx_dropped++;
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 		}
 	}
 
@@ -3442,7 +3442,7 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 
 	if (!secy->operational) {
 		kfree_skb(skb);
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return NETDEV_TX_OK;
 	}
 
@@ -3450,7 +3450,7 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 	skb = macsec_encrypt(skb, dev);
 	if (IS_ERR(skb)) {
 		if (PTR_ERR(skb) != -EINPROGRESS)
-			dev->stats.tx_dropped++;
+			DEV_STATS_INC(dev, tx_dropped);
 		return NETDEV_TX_OK;
 	}
 
@@ -3685,9 +3685,9 @@ static void macsec_get_stats64(struct net_device *dev,
 
 	dev_fetch_sw_netstats(s, dev->tstats);
 
-	s->rx_dropped = dev->stats.rx_dropped;
-	s->tx_dropped = dev->stats.tx_dropped;
-	s->rx_errors = dev->stats.rx_errors;
+	s->rx_dropped = atomic_long_read(&dev->stats.__rx_dropped);
+	s->tx_dropped = atomic_long_read(&dev->stats.__tx_dropped);
+	s->rx_errors = atomic_long_read(&dev->stats.__rx_errors);
 }
 
 static int macsec_get_iflink(const struct net_device *dev)
-- 
2.40.1



