Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1218F755407
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjGPUZu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGPUZs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8EAE40
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C42E860E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CCEC433C7;
        Sun, 16 Jul 2023 20:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539145;
        bh=+wW51ObunL97W/iEW5cHTjCZZOjeJeT8WfkZGdxDZ0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mChUJk/eBBYdeKfMqWpZRg0wOy2mI6zCiV3SAMaH9+W+dgmBAj5S8Z7XZu2YtZjKC
         IEoq3vcaHZ4AizR5SrrHPt/5I9sXf2AT1GruF5PrwJ5/O1UDBgYqFzzwOKDPlRxob6
         LD+wvQ6TYjYoBKedSM645zXcrJ1O9fbJm/YlPAiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Simon Horman <simon.horman@corigine.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 704/800] net: dsa: sja1105: always enable the send_meta options
Date:   Sun, 16 Jul 2023 21:49:17 +0200
Message-ID: <20230716195005.472332700@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit a372d66af48506d9f7aaae2a474cd18f14d98cb8 ]

incl_srcpt has the limitation, mentioned in commit b4638af8885a ("net:
dsa: sja1105: always enable the INCL_SRCPT option"), that frames with a
MAC DA of 01:80:c2:xx:yy:zz will be received as 01:80:c2:00:00:zz unless
PTP RX timestamping is enabled.

The incl_srcpt option was initially unconditionally enabled, then that
changed with commit 42824463d38d ("net: dsa: sja1105: Limit use of
incl_srcpt to bridge+vlan mode"), then again with b4638af8885a ("net:
dsa: sja1105: always enable the INCL_SRCPT option"). Bottom line is that
it now needs to be always enabled, otherwise the driver does not have a
reliable source of information regarding source_port and switch_id for
link-local traffic (tag_8021q VLANs may be imprecise since now they
identify an entire bridging domain when ports are not standalone).

If we accept that PTP RX timestamping (and therefore, meta frame
generation) is always enabled in hardware, then that limitation could be
avoided and packets with any MAC DA can be properly received, because
meta frames do contain the original bytes from the MAC DA of their
associated link-local packet.

This change enables meta frame generation unconditionally, which also
has the nice side effects of simplifying the switch control path
(a switch reset is no longer required on hwtstamping settings change)
and the tagger data path (it no longer needs to be informed whether to
expect meta frames or not - it always does).

Fixes: 227d07a07ef1 ("net: dsa: sja1105: Add support for traffic through standalone ports")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/sja1105/sja1105.h      |  2 +-
 drivers/net/dsa/sja1105/sja1105_main.c |  5 ++-
 drivers/net/dsa/sja1105/sja1105_ptp.c  | 48 +++-----------------------
 include/linux/dsa/sja1105.h            |  4 ---
 net/dsa/tag_sja1105.c                  | 45 ------------------------
 5 files changed, 7 insertions(+), 97 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index fb1549a5fe321..dee35ba924ad2 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -252,6 +252,7 @@ struct sja1105_private {
 	unsigned long ucast_egress_floods;
 	unsigned long bcast_egress_floods;
 	unsigned long hwts_tx_en;
+	unsigned long hwts_rx_en;
 	const struct sja1105_info *info;
 	size_t max_xfer_len;
 	struct spi_device *spidev;
@@ -289,7 +290,6 @@ struct sja1105_spi_message {
 /* From sja1105_main.c */
 enum sja1105_reset_reason {
 	SJA1105_VLAN_FILTERING = 0,
-	SJA1105_RX_HWTSTAMPING,
 	SJA1105_AGEING_TIME,
 	SJA1105_SCHEDULING,
 	SJA1105_BEST_EFFORT_POLICING,
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 8bd61f2ebb2ad..947e8f7c09880 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -867,11 +867,11 @@ static int sja1105_init_general_params(struct sja1105_private *priv)
 		.mac_fltres1 = SJA1105_LINKLOCAL_FILTER_A,
 		.mac_flt1    = SJA1105_LINKLOCAL_FILTER_A_MASK,
 		.incl_srcpt1 = true,
-		.send_meta1  = false,
+		.send_meta1  = true,
 		.mac_fltres0 = SJA1105_LINKLOCAL_FILTER_B,
 		.mac_flt0    = SJA1105_LINKLOCAL_FILTER_B_MASK,
 		.incl_srcpt0 = true,
-		.send_meta0  = false,
+		.send_meta0  = true,
 		/* Default to an invalid value */
 		.mirr_port = priv->ds->num_ports,
 		/* No TTEthernet */
@@ -2215,7 +2215,6 @@ static int sja1105_reload_cbs(struct sja1105_private *priv)
 
 static const char * const sja1105_reset_reasons[] = {
 	[SJA1105_VLAN_FILTERING] = "VLAN filtering",
-	[SJA1105_RX_HWTSTAMPING] = "RX timestamping",
 	[SJA1105_AGEING_TIME] = "Ageing time",
 	[SJA1105_SCHEDULING] = "Time-aware scheduling",
 	[SJA1105_BEST_EFFORT_POLICING] = "Best-effort policing",
diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.c b/drivers/net/dsa/sja1105/sja1105_ptp.c
index 30fb2cc40164b..a7d41e7813982 100644
--- a/drivers/net/dsa/sja1105/sja1105_ptp.c
+++ b/drivers/net/dsa/sja1105/sja1105_ptp.c
@@ -58,35 +58,10 @@ enum sja1105_ptp_clk_mode {
 #define ptp_data_to_sja1105(d) \
 		container_of((d), struct sja1105_private, ptp_data)
 
-/* Must be called only while the RX timestamping state of the tagger
- * is turned off
- */
-static int sja1105_change_rxtstamping(struct sja1105_private *priv,
-				      bool on)
-{
-	struct sja1105_ptp_data *ptp_data = &priv->ptp_data;
-	struct sja1105_general_params_entry *general_params;
-	struct sja1105_table *table;
-
-	table = &priv->static_config.tables[BLK_IDX_GENERAL_PARAMS];
-	general_params = table->entries;
-	general_params->send_meta1 = on;
-	general_params->send_meta0 = on;
-
-	ptp_cancel_worker_sync(ptp_data->clock);
-	skb_queue_purge(&ptp_data->skb_txtstamp_queue);
-	skb_queue_purge(&ptp_data->skb_rxtstamp_queue);
-
-	return sja1105_static_config_reload(priv, SJA1105_RX_HWTSTAMPING);
-}
-
 int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
 {
-	struct sja1105_tagger_data *tagger_data = sja1105_tagger_data(ds);
 	struct sja1105_private *priv = ds->priv;
 	struct hwtstamp_config config;
-	bool rx_on;
-	int rc;
 
 	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
 		return -EFAULT;
@@ -104,26 +79,13 @@ int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
 
 	switch (config.rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
-		rx_on = false;
+		priv->hwts_rx_en &= ~BIT(port);
 		break;
 	default:
-		rx_on = true;
+		priv->hwts_rx_en |= BIT(port);
 		break;
 	}
 
-	if (rx_on != tagger_data->rxtstamp_get_state(ds)) {
-		tagger_data->rxtstamp_set_state(ds, false);
-
-		rc = sja1105_change_rxtstamping(priv, rx_on);
-		if (rc < 0) {
-			dev_err(ds->dev,
-				"Failed to change RX timestamping: %d\n", rc);
-			return rc;
-		}
-		if (rx_on)
-			tagger_data->rxtstamp_set_state(ds, true);
-	}
-
 	if (copy_to_user(ifr->ifr_data, &config, sizeof(config)))
 		return -EFAULT;
 	return 0;
@@ -131,7 +93,6 @@ int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
 
 int sja1105_hwtstamp_get(struct dsa_switch *ds, int port, struct ifreq *ifr)
 {
-	struct sja1105_tagger_data *tagger_data = sja1105_tagger_data(ds);
 	struct sja1105_private *priv = ds->priv;
 	struct hwtstamp_config config;
 
@@ -140,7 +101,7 @@ int sja1105_hwtstamp_get(struct dsa_switch *ds, int port, struct ifreq *ifr)
 		config.tx_type = HWTSTAMP_TX_ON;
 	else
 		config.tx_type = HWTSTAMP_TX_OFF;
-	if (tagger_data->rxtstamp_get_state(ds))
+	if (priv->hwts_rx_en & BIT(port))
 		config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
 	else
 		config.rx_filter = HWTSTAMP_FILTER_NONE;
@@ -413,11 +374,10 @@ static long sja1105_rxtstamp_work(struct ptp_clock_info *ptp)
 
 bool sja1105_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 {
-	struct sja1105_tagger_data *tagger_data = sja1105_tagger_data(ds);
 	struct sja1105_private *priv = ds->priv;
 	struct sja1105_ptp_data *ptp_data = &priv->ptp_data;
 
-	if (!tagger_data->rxtstamp_get_state(ds))
+	if (!(priv->hwts_rx_en & BIT(port)))
 		return false;
 
 	/* We need to read the full PTP clock to reconstruct the Rx
diff --git a/include/linux/dsa/sja1105.h b/include/linux/dsa/sja1105.h
index 159e43171cccf..c177322f793d6 100644
--- a/include/linux/dsa/sja1105.h
+++ b/include/linux/dsa/sja1105.h
@@ -48,13 +48,9 @@ struct sja1105_deferred_xmit_work {
 
 /* Global tagger data */
 struct sja1105_tagger_data {
-	/* Tagger to switch */
 	void (*xmit_work_fn)(struct kthread_work *work);
 	void (*meta_tstamp_handler)(struct dsa_switch *ds, int port, u8 ts_id,
 				    enum sja1110_meta_tstamp dir, u64 tstamp);
-	/* Switch to tagger */
-	bool (*rxtstamp_get_state)(struct dsa_switch *ds);
-	void (*rxtstamp_set_state)(struct dsa_switch *ds, bool on);
 };
 
 struct sja1105_skb_cb {
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index ec48165673edb..ade3eeb2f3e6d 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -58,11 +58,8 @@
 #define SJA1110_TX_TRAILER_LEN			4
 #define SJA1110_MAX_PADDING_LEN			15
 
-#define SJA1105_HWTS_RX_EN			0
-
 struct sja1105_tagger_private {
 	struct sja1105_tagger_data data; /* Must be first */
-	unsigned long state;
 	/* Protects concurrent access to the meta state machine
 	 * from taggers running on multiple ports on SMP systems
 	 */
@@ -392,10 +389,6 @@ static struct sk_buff
 
 		priv = sja1105_tagger_private(ds);
 
-		if (!test_bit(SJA1105_HWTS_RX_EN, &priv->state))
-			/* Do normal processing. */
-			return skb;
-
 		spin_lock(&priv->meta_lock);
 		/* Was this a link-local frame instead of the meta
 		 * that we were expecting?
@@ -431,12 +424,6 @@ static struct sk_buff
 
 		priv = sja1105_tagger_private(ds);
 
-		/* Drop the meta frame if we're not in the right state
-		 * to process it.
-		 */
-		if (!test_bit(SJA1105_HWTS_RX_EN, &priv->state))
-			return NULL;
-
 		spin_lock(&priv->meta_lock);
 
 		stampable_skb = priv->stampable_skb;
@@ -472,30 +459,6 @@ static struct sk_buff
 	return skb;
 }
 
-static bool sja1105_rxtstamp_get_state(struct dsa_switch *ds)
-{
-	struct sja1105_tagger_private *priv = sja1105_tagger_private(ds);
-
-	return test_bit(SJA1105_HWTS_RX_EN, &priv->state);
-}
-
-static void sja1105_rxtstamp_set_state(struct dsa_switch *ds, bool on)
-{
-	struct sja1105_tagger_private *priv = sja1105_tagger_private(ds);
-
-	if (on)
-		set_bit(SJA1105_HWTS_RX_EN, &priv->state);
-	else
-		clear_bit(SJA1105_HWTS_RX_EN, &priv->state);
-
-	/* Initialize the meta state machine to a known state */
-	if (!priv->stampable_skb)
-		return;
-
-	kfree_skb(priv->stampable_skb);
-	priv->stampable_skb = NULL;
-}
-
 static bool sja1105_skb_has_tag_8021q(const struct sk_buff *skb)
 {
 	u16 tpid = ntohs(eth_hdr(skb)->h_proto);
@@ -552,9 +515,6 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 		 */
 		source_port = hdr->h_dest[3];
 		switch_id = hdr->h_dest[4];
-		/* Clear the DMAC bytes that were mangled by the switch */
-		hdr->h_dest[3] = 0;
-		hdr->h_dest[4] = 0;
 	} else if (is_meta) {
 		sja1105_meta_unpack(skb, &meta);
 		source_port = meta.source_port;
@@ -785,7 +745,6 @@ static void sja1105_disconnect(struct dsa_switch *ds)
 
 static int sja1105_connect(struct dsa_switch *ds)
 {
-	struct sja1105_tagger_data *tagger_data;
 	struct sja1105_tagger_private *priv;
 	struct kthread_worker *xmit_worker;
 	int err;
@@ -805,10 +764,6 @@ static int sja1105_connect(struct dsa_switch *ds)
 	}
 
 	priv->xmit_worker = xmit_worker;
-	/* Export functions for switch driver use */
-	tagger_data = &priv->data;
-	tagger_data->rxtstamp_get_state = sja1105_rxtstamp_get_state;
-	tagger_data->rxtstamp_set_state = sja1105_rxtstamp_set_state;
 	ds->tagger_data = priv;
 
 	return 0;
-- 
2.39.2



