Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236297556A6
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjGPUwg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjGPUwg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12493E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B86660E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E64C433C8;
        Sun, 16 Jul 2023 20:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540754;
        bh=5xkpUM/r8vbT8mcVQYPXwGudlbYN3iTdorIMwuvPkm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sg96fMP9S8DoAJU4lgLbpFA1/Wwq3rCOrSMbAVJwg9IS+NyFV5rVc00G+qJwQ7+QD
         EL2bM9NEx/EgUpT6PnUJle2jPnaP8in3ONuoUCII77czE8GtlrcILYjfFpi47ThHld
         DTRNB5eYzE4TDrLkcdbsyqmg02Hp6/C0QUKmZPC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 476/591] net: mscc: ocelot: dont keep PTP configuration of all ports in single structure
Date:   Sun, 16 Jul 2023 21:50:15 +0200
Message-ID: <20230716194936.216308922@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 45d0fcb5bc9558d0bf3d2fa7fabc5d8a88d35439 ]

In a future change, the driver will need to determine whether PTP RX
timestamping is enabled on a port (including whether traps were set up
on that port in particular) and that is currently not possible.

The driver supports different RX filters (L2, L4) and kinds of TX
timestamping (one-step, two-step) on its ports, but it saves all
configuration in a single struct hwtstamp_config that is global to the
switch. So, the latest timestamping configuration on one port
(including a request to disable timestamping) affects what gets reported
for all ports, even though the configuration itself is still individual
to each port.

The port timestamping configurations are only coupled because of the
common structure, so replace the hwtstamp_config with a mask of trapped
protocols saved per port. We also have the ptp_cmd to distinguish
between one-step and two-step PTP timestamping, so with those 2 bits of
information we can fully reconstruct a descriptive struct
hwtstamp_config for each port, during the SIOCGHWTSTAMP ioctl.

Fixes: 4e3b0468e6d7 ("net: mscc: PTP Hardware Clock (PHC) support")
Fixes: 96ca08c05838 ("net: mscc: ocelot: set up traps for PTP packets")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mscc/ocelot.c     |  1 -
 drivers/net/ethernet/mscc/ocelot_ptp.c | 61 +++++++++++++++++---------
 include/soc/mscc/ocelot.h              | 10 +++--
 3 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 13b14110a0603..01b6e13f4692f 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -2728,7 +2728,6 @@ int ocelot_init(struct ocelot *ocelot)
 		}
 	}
 
-	mutex_init(&ocelot->ptp_lock);
 	mutex_init(&ocelot->mact_lock);
 	mutex_init(&ocelot->fwd_domain_lock);
 	mutex_init(&ocelot->tas_lock);
diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index 673bfd70867a6..cb32234a5bf1b 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -439,8 +439,12 @@ static int ocelot_ipv6_ptp_trap_del(struct ocelot *ocelot, int port)
 static int ocelot_setup_ptp_traps(struct ocelot *ocelot, int port,
 				  bool l2, bool l4)
 {
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
 	int err;
 
+	ocelot_port->trap_proto &= ~(OCELOT_PROTO_PTP_L2 |
+				     OCELOT_PROTO_PTP_L4);
+
 	if (l2)
 		err = ocelot_l2_ptp_trap_add(ocelot, port);
 	else
@@ -464,6 +468,11 @@ static int ocelot_setup_ptp_traps(struct ocelot *ocelot, int port,
 	if (err)
 		return err;
 
+	if (l2)
+		ocelot_port->trap_proto |= OCELOT_PROTO_PTP_L2;
+	if (l4)
+		ocelot_port->trap_proto |= OCELOT_PROTO_PTP_L4;
+
 	return 0;
 
 err_ipv6:
@@ -474,10 +483,38 @@ static int ocelot_setup_ptp_traps(struct ocelot *ocelot, int port,
 	return err;
 }
 
+static int ocelot_traps_to_ptp_rx_filter(unsigned int proto)
+{
+	if ((proto & OCELOT_PROTO_PTP_L2) && (proto & OCELOT_PROTO_PTP_L4))
+		return HWTSTAMP_FILTER_PTP_V2_EVENT;
+	else if (proto & OCELOT_PROTO_PTP_L2)
+		return HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+	else if (proto & OCELOT_PROTO_PTP_L4)
+		return HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+
+	return HWTSTAMP_FILTER_NONE;
+}
+
 int ocelot_hwstamp_get(struct ocelot *ocelot, int port, struct ifreq *ifr)
 {
-	return copy_to_user(ifr->ifr_data, &ocelot->hwtstamp_config,
-			    sizeof(ocelot->hwtstamp_config)) ? -EFAULT : 0;
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	struct hwtstamp_config cfg = {};
+
+	switch (ocelot_port->ptp_cmd) {
+	case IFH_REW_OP_TWO_STEP_PTP:
+		cfg.tx_type = HWTSTAMP_TX_ON;
+		break;
+	case IFH_REW_OP_ORIGIN_PTP:
+		cfg.tx_type = HWTSTAMP_TX_ONESTEP_SYNC;
+		break;
+	default:
+		cfg.tx_type = HWTSTAMP_TX_OFF;
+		break;
+	}
+
+	cfg.rx_filter = ocelot_traps_to_ptp_rx_filter(ocelot_port->trap_proto);
+
+	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
 }
 EXPORT_SYMBOL(ocelot_hwstamp_get);
 
@@ -509,8 +546,6 @@ int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	mutex_lock(&ocelot->ptp_lock);
-
 	switch (cfg.rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		break;
@@ -531,28 +566,14 @@ int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
 		l4 = true;
 		break;
 	default:
-		mutex_unlock(&ocelot->ptp_lock);
 		return -ERANGE;
 	}
 
 	err = ocelot_setup_ptp_traps(ocelot, port, l2, l4);
-	if (err) {
-		mutex_unlock(&ocelot->ptp_lock);
+	if (err)
 		return err;
-	}
-
-	if (l2 && l4)
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-	else if (l2)
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
-	else if (l4)
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
-	else
-		cfg.rx_filter = HWTSTAMP_FILTER_NONE;
 
-	/* Commit back the result & save it */
-	memcpy(&ocelot->hwtstamp_config, &cfg, sizeof(cfg));
-	mutex_unlock(&ocelot->ptp_lock);
+	cfg.rx_filter = ocelot_traps_to_ptp_rx_filter(ocelot_port->trap_proto);
 
 	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
 }
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 967ba30ea6363..195ca8f0b6f9d 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -902,6 +902,11 @@ enum macaccess_entry_type {
 	ENTRYTYPE_MACv6,
 };
 
+enum ocelot_proto {
+	OCELOT_PROTO_PTP_L2 = BIT(0),
+	OCELOT_PROTO_PTP_L4 = BIT(1),
+};
+
 #define OCELOT_QUIRK_PCS_PERFORMS_RATE_ADAPTATION	BIT(0)
 #define OCELOT_QUIRK_QSGMII_PORTS_MUST_BE_UP		BIT(1)
 
@@ -939,6 +944,8 @@ struct ocelot_port {
 	unsigned int			ptp_skbs_in_flight;
 	struct sk_buff_head		tx_skbs;
 
+	unsigned int			trap_proto;
+
 	u16				mrp_ring_id;
 
 	u8				ptp_cmd;
@@ -1032,12 +1039,9 @@ struct ocelot {
 	u8				ptp:1;
 	struct ptp_clock		*ptp_clock;
 	struct ptp_clock_info		ptp_info;
-	struct hwtstamp_config		hwtstamp_config;
 	unsigned int			ptp_skbs_in_flight;
 	/* Protects the 2-step TX timestamp ID logic */
 	spinlock_t			ts_id_lock;
-	/* Protects the PTP interface state */
-	struct mutex			ptp_lock;
 	/* Protects the PTP clock */
 	spinlock_t			ptp_clock_lock;
 	struct ptp_pin_desc		ptp_pins[OCELOT_PTP_PINS_NUM];
-- 
2.39.2



