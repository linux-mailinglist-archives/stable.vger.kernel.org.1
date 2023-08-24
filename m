Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8917872FB
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbjHXO64 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241985AbjHXO6j (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:58:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77B21BC9
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E44767069
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505D0C433C8;
        Thu, 24 Aug 2023 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889114;
        bh=AqO6jOTYVM5CEzproR2D2kbakzzL+2/TmRj3xTT+1Fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIBrH1Wr3/LenCYX9Ze2T9E3S/CPgk6ITiAoIMoiNJwOmi350MfTqRZjey5aQOLfq
         ERq1soSeaaaBHsGISPSQL+Enw//IM9srzKwzz3v/Plv+Flc2Vws3NIsqVyAcpk2sae
         rBek4K6+8TdTismViLQ2SpLtGhbWKfS04J2+rjI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Clayton Yager <Clayton_Yager@selinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 002/135] macsec: Fix traffic counters/statistics
Date:   Thu, 24 Aug 2023 16:49:05 +0200
Message-ID: <20230824145027.124063244@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Clayton Yager <Clayton_Yager@selinc.com>

[ Upstream commit 91ec9bd57f3524ff3d86bfb7c9ee5a315019733c ]

OutOctetsProtected, OutOctetsEncrypted, InOctetsValidated, and
InOctetsDecrypted were incrementing by the total number of octets in frames
instead of by the number of octets of User Data in frames.

The Controlled Port statistics ifOutOctets and ifInOctets were incrementing
by the total number of octets instead of the number of octets of the MSDUs
plus octets of the destination and source MAC addresses.

The Controlled Port statistics ifInDiscards and ifInErrors were not
incrementing each time the counters they aggregate were.

The Controlled Port statistic ifInErrors was not included in the output of
macsec_get_stats64 so the value was not present in ip commands output.

The ReceiveSA counters InPktsNotValid, InPktsNotUsingSA, and InPktsUnusedSA
were not incrementing.

Signed-off-by: Clayton Yager <Clayton_Yager@selinc.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 32d0a49d36a2 ("macsec: use DEV_STATS_INC()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 58 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 4fdb970e34823..6691c941f8bb8 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -159,6 +159,19 @@ static struct macsec_rx_sa *macsec_rxsa_get(struct macsec_rx_sa __rcu *ptr)
 	return sa;
 }
 
+static struct macsec_rx_sa *macsec_active_rxsa_get(struct macsec_rx_sc *rx_sc)
+{
+	struct macsec_rx_sa *sa = NULL;
+	int an;
+
+	for (an = 0; an < MACSEC_NUM_AN; an++)	{
+		sa = macsec_rxsa_get(rx_sc->sa[an]);
+		if (sa)
+			break;
+	}
+	return sa;
+}
+
 static void free_rx_sc_rcu(struct rcu_head *head)
 {
 	struct macsec_rx_sc *rx_sc = container_of(head, struct macsec_rx_sc, rcu_head);
@@ -497,18 +510,28 @@ static void macsec_encrypt_finish(struct sk_buff *skb, struct net_device *dev)
 	skb->protocol = eth_hdr(skb)->h_proto;
 }
 
+static unsigned int macsec_msdu_len(struct sk_buff *skb)
+{
+	struct macsec_dev *macsec = macsec_priv(skb->dev);
+	struct macsec_secy *secy = &macsec->secy;
+	bool sci_present = macsec_skb_cb(skb)->has_sci;
+
+	return skb->len - macsec_hdr_len(sci_present) - secy->icv_len;
+}
+
 static void macsec_count_tx(struct sk_buff *skb, struct macsec_tx_sc *tx_sc,
 			    struct macsec_tx_sa *tx_sa)
 {
+	unsigned int msdu_len = macsec_msdu_len(skb);
 	struct pcpu_tx_sc_stats *txsc_stats = this_cpu_ptr(tx_sc->stats);
 
 	u64_stats_update_begin(&txsc_stats->syncp);
 	if (tx_sc->encrypt) {
-		txsc_stats->stats.OutOctetsEncrypted += skb->len;
+		txsc_stats->stats.OutOctetsEncrypted += msdu_len;
 		txsc_stats->stats.OutPktsEncrypted++;
 		this_cpu_inc(tx_sa->stats->OutPktsEncrypted);
 	} else {
-		txsc_stats->stats.OutOctetsProtected += skb->len;
+		txsc_stats->stats.OutOctetsProtected += msdu_len;
 		txsc_stats->stats.OutPktsProtected++;
 		this_cpu_inc(tx_sa->stats->OutPktsProtected);
 	}
@@ -538,9 +561,10 @@ static void macsec_encrypt_done(struct crypto_async_request *base, int err)
 	aead_request_free(macsec_skb_cb(skb)->req);
 
 	rcu_read_lock_bh();
-	macsec_encrypt_finish(skb, dev);
 	macsec_count_tx(skb, &macsec->secy.tx_sc, macsec_skb_cb(skb)->tx_sa);
-	len = skb->len;
+	/* packet is encrypted/protected so tx_bytes must be calculated */
+	len = macsec_msdu_len(skb) + 2 * ETH_ALEN;
+	macsec_encrypt_finish(skb, dev);
 	ret = dev_queue_xmit(skb);
 	count_tx(dev, ret, len);
 	rcu_read_unlock_bh();
@@ -699,6 +723,7 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *skb,
 
 	macsec_skb_cb(skb)->req = req;
 	macsec_skb_cb(skb)->tx_sa = tx_sa;
+	macsec_skb_cb(skb)->has_sci = sci_present;
 	aead_request_set_callback(req, 0, macsec_encrypt_done, skb);
 
 	dev_hold(skb->dev);
@@ -740,15 +765,17 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsLate++;
 		u64_stats_update_end(&rxsc_stats->syncp);
+		secy->netdev->stats.rx_dropped++;
 		return false;
 	}
 
 	if (secy->validate_frames != MACSEC_VALIDATE_DISABLED) {
+		unsigned int msdu_len = macsec_msdu_len(skb);
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		if (hdr->tci_an & MACSEC_TCI_E)
-			rxsc_stats->stats.InOctetsDecrypted += skb->len;
+			rxsc_stats->stats.InOctetsDecrypted += msdu_len;
 		else
-			rxsc_stats->stats.InOctetsValidated += skb->len;
+			rxsc_stats->stats.InOctetsValidated += msdu_len;
 		u64_stats_update_end(&rxsc_stats->syncp);
 	}
 
@@ -761,6 +788,8 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsNotValid++;
 			u64_stats_update_end(&rxsc_stats->syncp);
+			this_cpu_inc(rx_sa->stats->InPktsNotValid);
+			secy->netdev->stats.rx_errors++;
 			return false;
 		}
 
@@ -853,9 +882,9 @@ static void macsec_decrypt_done(struct crypto_async_request *base, int err)
 
 	macsec_finalize_skb(skb, macsec->secy.icv_len,
 			    macsec_extra_len(macsec_skb_cb(skb)->has_sci));
+	len = skb->len;
 	macsec_reset_skb(skb, macsec->secy.netdev);
 
-	len = skb->len;
 	if (gro_cells_receive(&macsec->gro_cells, skb) == NET_RX_SUCCESS)
 		count_rx(dev, len);
 
@@ -1046,6 +1075,7 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsNoTag++;
 			u64_stats_update_end(&secy_stats->syncp);
+			macsec->secy.netdev->stats.rx_dropped++;
 			continue;
 		}
 
@@ -1155,6 +1185,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		u64_stats_update_begin(&secy_stats->syncp);
 		secy_stats->stats.InPktsBadTag++;
 		u64_stats_update_end(&secy_stats->syncp);
+		secy->netdev->stats.rx_errors++;
 		goto drop_nosa;
 	}
 
@@ -1165,11 +1196,15 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		/* If validateFrames is Strict or the C bit in the
 		 * SecTAG is set, discard
 		 */
+		struct macsec_rx_sa *active_rx_sa = macsec_active_rxsa_get(rx_sc);
 		if (hdr->tci_an & MACSEC_TCI_C ||
 		    secy->validate_frames == MACSEC_VALIDATE_STRICT) {
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsNotUsingSA++;
 			u64_stats_update_end(&rxsc_stats->syncp);
+			secy->netdev->stats.rx_errors++;
+			if (active_rx_sa)
+				this_cpu_inc(active_rx_sa->stats->InPktsNotUsingSA);
 			goto drop_nosa;
 		}
 
@@ -1179,6 +1214,8 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsUnusedSA++;
 		u64_stats_update_end(&rxsc_stats->syncp);
+		if (active_rx_sa)
+			this_cpu_inc(active_rx_sa->stats->InPktsUnusedSA);
 		goto deliver;
 	}
 
@@ -1199,6 +1236,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsLate++;
 			u64_stats_update_end(&rxsc_stats->syncp);
+			macsec->secy.netdev->stats.rx_dropped++;
 			goto drop;
 		}
 	}
@@ -1227,6 +1265,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 deliver:
 	macsec_finalize_skb(skb, secy->icv_len,
 			    macsec_extra_len(macsec_skb_cb(skb)->has_sci));
+	len = skb->len;
 	macsec_reset_skb(skb, secy->netdev);
 
 	if (rx_sa)
@@ -1234,7 +1273,6 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	macsec_rxsc_put(rx_sc);
 
 	skb_orphan(skb);
-	len = skb->len;
 	ret = gro_cells_receive(&macsec->gro_cells, skb);
 	if (ret == NET_RX_SUCCESS)
 		count_rx(dev, len);
@@ -1276,6 +1314,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsNoSCI++;
 			u64_stats_update_end(&secy_stats->syncp);
+			macsec->secy.netdev->stats.rx_errors++;
 			continue;
 		}
 
@@ -3407,6 +3446,7 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
+	len = skb->len;
 	skb = macsec_encrypt(skb, dev);
 	if (IS_ERR(skb)) {
 		if (PTR_ERR(skb) != -EINPROGRESS)
@@ -3417,7 +3457,6 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 	macsec_count_tx(skb, &macsec->secy.tx_sc, macsec_skb_cb(skb)->tx_sa);
 
 	macsec_encrypt_finish(skb, dev);
-	len = skb->len;
 	ret = dev_queue_xmit(skb);
 	count_tx(dev, ret, len);
 	return ret;
@@ -3648,6 +3687,7 @@ static void macsec_get_stats64(struct net_device *dev,
 
 	s->rx_dropped = dev->stats.rx_dropped;
 	s->tx_dropped = dev->stats.tx_dropped;
+	s->rx_errors = dev->stats.rx_errors;
 }
 
 static int macsec_get_iflink(const struct net_device *dev)
-- 
2.40.1



