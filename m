Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDD175CD83
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjGUQM2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjGUQMH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:12:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463BA3AAE
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1839861D2B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24615C433C7;
        Fri, 21 Jul 2023 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955900;
        bh=azicUGBre4qZNswhllZo79IgZ8CE3tezHTdkpEYd+Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R/joa9XxVsENSER67FTCUPgXFsyHB3xSyJnMEX0nUF0PgOqXcK2hMcUoVk7j3t2Wk
         jZWa+y58C6+1O2Yn/XPVaySDx6AA6o285RyzxGgZW2njM7SlDvget/5KFfwVdes97K
         x7r922OZrOMYLZDvDYatY5XX2c6sIWaqIo8UtyFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 6.4 069/292] net/sched: taprio: replace tc_taprio_qopt_offload :: enable with a "cmd" enum
Date:   Fri, 21 Jul 2023 18:02:58 +0200
Message-ID: <20230721160531.763920658@linuxfoundation.org>
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 2d800bc500fb3fb07a0fb42e2d0a1356fb9e1e8f ]

Inspired from struct flow_cls_offload :: cmd, in order for taprio to be
able to report statistics (which is future work), it seems that we need
to drill one step further with the ndo_setup_tc(TC_SETUP_QDISC_TAPRIO)
multiplexing, and pass the command as part of the common portion of the
muxed structure.

Since we already have an "enable" variable in tc_taprio_qopt_offload,
refactor all drivers to check for "cmd" instead of "enable", and reject
every other command except "replace" and "destroy" - to be future proof.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com> # for lan966x
Acked-by: Kurt Kanzenbach <kurt@linutronix.de> # hellcreek
Reviewed-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 8046063df887 ("igc: Rename qbv_enable to taprio_offload_enable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/hirschmann/hellcreek.c             | 14 +++++++++-----
 drivers/net/dsa/ocelot/felix_vsc9959.c             |  4 +++-
 drivers/net/dsa/sja1105/sja1105_tas.c              |  7 +++++--
 drivers/net/ethernet/engleder/tsnep_selftests.c    | 12 ++++++------
 drivers/net/ethernet/engleder/tsnep_tc.c           |  4 +++-
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |  6 +++++-
 drivers/net/ethernet/intel/igc/igc_main.c          | 13 +++++++++++--
 .../net/ethernet/microchip/lan966x/lan966x_tc.c    | 10 ++++++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  7 +++++--
 drivers/net/ethernet/ti/am65-cpsw-qos.c            | 11 ++++++++---
 include/net/pkt_sched.h                            |  7 ++++++-
 net/sched/sch_taprio.c                             |  4 ++--
 12 files changed, 71 insertions(+), 28 deletions(-)

diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index 595a548bb0a80..af50001ccdd4e 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -1885,13 +1885,17 @@ static int hellcreek_port_setup_tc(struct dsa_switch *ds, int port,
 	case TC_SETUP_QDISC_TAPRIO: {
 		struct tc_taprio_qopt_offload *taprio = type_data;
 
-		if (!hellcreek_validate_schedule(hellcreek, taprio))
-			return -EOPNOTSUPP;
+		switch (taprio->cmd) {
+		case TAPRIO_CMD_REPLACE:
+			if (!hellcreek_validate_schedule(hellcreek, taprio))
+				return -EOPNOTSUPP;
 
-		if (taprio->enable)
 			return hellcreek_port_set_schedule(ds, port, taprio);
-
-		return hellcreek_port_del_schedule(ds, port);
+		case TAPRIO_CMD_DESTROY:
+			return hellcreek_port_del_schedule(ds, port);
+		default:
+			return -EOPNOTSUPP;
+		}
 	}
 	default:
 		return -EOPNOTSUPP;
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index bd11f9fb95e54..772f8b817390b 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1436,7 +1436,7 @@ static int vsc9959_qos_port_tas_set(struct ocelot *ocelot, int port,
 
 	mutex_lock(&ocelot->tas_lock);
 
-	if (!taprio->enable) {
+	if (taprio->cmd == TAPRIO_CMD_DESTROY) {
 		ocelot_port_mqprio(ocelot, port, &taprio->mqprio);
 		ocelot_rmw_rix(ocelot, 0, QSYS_TAG_CONFIG_ENABLE,
 			       QSYS_TAG_CONFIG, port);
@@ -1448,6 +1448,8 @@ static int vsc9959_qos_port_tas_set(struct ocelot *ocelot, int port,
 
 		mutex_unlock(&ocelot->tas_lock);
 		return 0;
+	} else if (taprio->cmd != TAPRIO_CMD_REPLACE) {
+		return -EOPNOTSUPP;
 	}
 
 	ret = ocelot_port_mqprio(ocelot, port, &taprio->mqprio);
diff --git a/drivers/net/dsa/sja1105/sja1105_tas.c b/drivers/net/dsa/sja1105/sja1105_tas.c
index e6153848a9509..d7818710bc028 100644
--- a/drivers/net/dsa/sja1105/sja1105_tas.c
+++ b/drivers/net/dsa/sja1105/sja1105_tas.c
@@ -516,10 +516,11 @@ int sja1105_setup_tc_taprio(struct dsa_switch *ds, int port,
 	/* Can't change an already configured port (must delete qdisc first).
 	 * Can't delete the qdisc from an unconfigured port.
 	 */
-	if (!!tas_data->offload[port] == admin->enable)
+	if ((!!tas_data->offload[port] && admin->cmd == TAPRIO_CMD_REPLACE) ||
+	    (!tas_data->offload[port] && admin->cmd == TAPRIO_CMD_DESTROY))
 		return -EINVAL;
 
-	if (!admin->enable) {
+	if (admin->cmd == TAPRIO_CMD_DESTROY) {
 		taprio_offload_free(tas_data->offload[port]);
 		tas_data->offload[port] = NULL;
 
@@ -528,6 +529,8 @@ int sja1105_setup_tc_taprio(struct dsa_switch *ds, int port,
 			return rc;
 
 		return sja1105_static_config_reload(priv, SJA1105_SCHEDULING);
+	} else if (admin->cmd != TAPRIO_CMD_REPLACE) {
+		return -EOPNOTSUPP;
 	}
 
 	/* The cycle time extension is the amount of time the last cycle from
diff --git a/drivers/net/ethernet/engleder/tsnep_selftests.c b/drivers/net/ethernet/engleder/tsnep_selftests.c
index 1581d6b222320..8a9145f93147c 100644
--- a/drivers/net/ethernet/engleder/tsnep_selftests.c
+++ b/drivers/net/ethernet/engleder/tsnep_selftests.c
@@ -329,7 +329,7 @@ static bool disable_taprio(struct tsnep_adapter *adapter)
 	int retval;
 
 	memset(&qopt, 0, sizeof(qopt));
-	qopt.enable = 0;
+	qopt.cmd = TAPRIO_CMD_DESTROY;
 	retval = tsnep_tc_setup(adapter->netdev, TC_SETUP_QDISC_TAPRIO, &qopt);
 	if (retval)
 		return false;
@@ -360,7 +360,7 @@ static bool tsnep_test_taprio(struct tsnep_adapter *adapter)
 	for (i = 0; i < 255; i++)
 		qopt->entries[i].command = TC_TAPRIO_CMD_SET_GATES;
 
-	qopt->enable = 1;
+	qopt->cmd = TAPRIO_CMD_REPLACE;
 	qopt->base_time = ktime_set(0, 0);
 	qopt->cycle_time = 1500000;
 	qopt->cycle_time_extension = 0;
@@ -382,7 +382,7 @@ static bool tsnep_test_taprio(struct tsnep_adapter *adapter)
 	if (!run_taprio(adapter, qopt, 100))
 		goto failed;
 
-	qopt->enable = 1;
+	qopt->cmd = TAPRIO_CMD_REPLACE;
 	qopt->base_time = ktime_set(0, 0);
 	qopt->cycle_time = 411854;
 	qopt->cycle_time_extension = 0;
@@ -406,7 +406,7 @@ static bool tsnep_test_taprio(struct tsnep_adapter *adapter)
 	if (!run_taprio(adapter, qopt, 100))
 		goto failed;
 
-	qopt->enable = 1;
+	qopt->cmd = TAPRIO_CMD_REPLACE;
 	qopt->base_time = ktime_set(0, 0);
 	delay_base_time(adapter, qopt, 12);
 	qopt->cycle_time = 125000;
@@ -457,7 +457,7 @@ static bool tsnep_test_taprio_change(struct tsnep_adapter *adapter)
 	for (i = 0; i < 255; i++)
 		qopt->entries[i].command = TC_TAPRIO_CMD_SET_GATES;
 
-	qopt->enable = 1;
+	qopt->cmd = TAPRIO_CMD_REPLACE;
 	qopt->base_time = ktime_set(0, 0);
 	qopt->cycle_time = 100000;
 	qopt->cycle_time_extension = 0;
@@ -610,7 +610,7 @@ static bool tsnep_test_taprio_extension(struct tsnep_adapter *adapter)
 	for (i = 0; i < 255; i++)
 		qopt->entries[i].command = TC_TAPRIO_CMD_SET_GATES;
 
-	qopt->enable = 1;
+	qopt->cmd = TAPRIO_CMD_REPLACE;
 	qopt->base_time = ktime_set(0, 0);
 	qopt->cycle_time = 100000;
 	qopt->cycle_time_extension = 50000;
diff --git a/drivers/net/ethernet/engleder/tsnep_tc.c b/drivers/net/ethernet/engleder/tsnep_tc.c
index d083e6684f120..745b191a55402 100644
--- a/drivers/net/ethernet/engleder/tsnep_tc.c
+++ b/drivers/net/ethernet/engleder/tsnep_tc.c
@@ -325,7 +325,7 @@ static int tsnep_taprio(struct tsnep_adapter *adapter,
 	if (!adapter->gate_control)
 		return -EOPNOTSUPP;
 
-	if (!qopt->enable) {
+	if (qopt->cmd == TAPRIO_CMD_DESTROY) {
 		/* disable gate control if active */
 		mutex_lock(&adapter->gate_control_lock);
 
@@ -337,6 +337,8 @@ static int tsnep_taprio(struct tsnep_adapter *adapter,
 		mutex_unlock(&adapter->gate_control_lock);
 
 		return 0;
+	} else if (qopt->cmd != TAPRIO_CMD_REPLACE) {
+		return -EOPNOTSUPP;
 	}
 
 	retval = tsnep_validate_gcl(qopt);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 126007ab70f61..dfec50106106f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -65,7 +65,7 @@ static int enetc_setup_taprio(struct net_device *ndev,
 	gcl_len = admin_conf->num_entries;
 
 	tge = enetc_rd(hw, ENETC_PTGCR);
-	if (!admin_conf->enable) {
+	if (admin_conf->cmd == TAPRIO_CMD_DESTROY) {
 		enetc_wr(hw, ENETC_PTGCR, tge & ~ENETC_PTGCR_TGE);
 		enetc_reset_ptcmsdur(hw);
 
@@ -138,6 +138,10 @@ int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data)
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err, i;
 
+	if (taprio->cmd != TAPRIO_CMD_REPLACE &&
+	    taprio->cmd != TAPRIO_CMD_DESTROY)
+		return -EOPNOTSUPP;
+
 	/* TSD and Qbv are mutually exclusive in hardware */
 	for (i = 0; i < priv->num_tx_rings; i++)
 		if (priv->tx_ring[i]->tsd_enable)
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e7bd2c60ee383..ae986e44a4718 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6117,9 +6117,18 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	size_t n;
 	int i;
 
-	adapter->qbv_enable = qopt->enable;
+	switch (qopt->cmd) {
+	case TAPRIO_CMD_REPLACE:
+		adapter->qbv_enable = true;
+		break;
+	case TAPRIO_CMD_DESTROY:
+		adapter->qbv_enable = false;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
 
-	if (!qopt->enable)
+	if (!adapter->qbv_enable)
 		return igc_tsn_clear_schedule(adapter);
 
 	if (qopt->base_time < 0)
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_tc.c b/drivers/net/ethernet/microchip/lan966x/lan966x_tc.c
index cf0cc7562d042..ee652f2d23595 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_tc.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_tc.c
@@ -21,8 +21,14 @@ static int lan966x_tc_setup_qdisc_mqprio(struct lan966x_port *port,
 static int lan966x_tc_setup_qdisc_taprio(struct lan966x_port *port,
 					 struct tc_taprio_qopt_offload *taprio)
 {
-	return taprio->enable ? lan966x_taprio_add(port, taprio) :
-				lan966x_taprio_del(port);
+	switch (taprio->cmd) {
+	case TAPRIO_CMD_REPLACE:
+		return lan966x_taprio_add(port, taprio);
+	case TAPRIO_CMD_DESTROY:
+		return lan966x_taprio_del(port);
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
 static int lan966x_tc_setup_qdisc_tbf(struct lan966x_port *port,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 9d55226479b4a..ac41ef4cbd2f0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -966,8 +966,11 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
-	if (!qopt->enable)
+	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		goto disable;
+	else if (qopt->cmd != TAPRIO_CMD_REPLACE)
+		return -EOPNOTSUPP;
+
 	if (qopt->num_entries >= dep)
 		return -EINVAL;
 	if (!qopt->cycle_time)
@@ -988,7 +991,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 
 	mutex_lock(&priv->plat->est->lock);
 	priv->plat->est->gcl_size = size;
-	priv->plat->est->enable = qopt->enable;
+	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
 	mutex_unlock(&priv->plat->est->lock);
 
 	for (i = 0; i < size; i++) {
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 3a908db6e5b22..eced87fa261c9 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -450,7 +450,7 @@ static int am65_cpsw_configure_taprio(struct net_device *ndev,
 
 	am65_cpsw_est_update_state(ndev);
 
-	if (!est_new->taprio.enable) {
+	if (est_new->taprio.cmd == TAPRIO_CMD_DESTROY) {
 		am65_cpsw_stop_est(ndev);
 		return ret;
 	}
@@ -476,7 +476,7 @@ static int am65_cpsw_configure_taprio(struct net_device *ndev,
 	am65_cpsw_est_set_sched_list(ndev, est_new);
 	am65_cpsw_port_est_assign_buf_num(ndev, est_new->buf);
 
-	am65_cpsw_est_set(ndev, est_new->taprio.enable);
+	am65_cpsw_est_set(ndev, est_new->taprio.cmd == TAPRIO_CMD_REPLACE);
 
 	if (tact == TACT_PROG) {
 		ret = am65_cpsw_timer_set(ndev, est_new);
@@ -520,7 +520,7 @@ static int am65_cpsw_set_taprio(struct net_device *ndev, void *type_data)
 	am65_cpsw_cp_taprio(taprio, &est_new->taprio);
 	ret = am65_cpsw_configure_taprio(ndev, est_new);
 	if (!ret) {
-		if (taprio->enable) {
+		if (taprio->cmd == TAPRIO_CMD_REPLACE) {
 			devm_kfree(&ndev->dev, port->qos.est_admin);
 
 			port->qos.est_admin = est_new;
@@ -564,8 +564,13 @@ static void am65_cpsw_est_link_up(struct net_device *ndev, int link_speed)
 static int am65_cpsw_setup_taprio(struct net_device *ndev, void *type_data)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct tc_taprio_qopt_offload *taprio = type_data;
 	struct am65_cpsw_common *common = port->common;
 
+	if (taprio->cmd != TAPRIO_CMD_REPLACE &&
+	    taprio->cmd != TAPRIO_CMD_DESTROY)
+		return -EOPNOTSUPP;
+
 	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
 		return -ENODEV;
 
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 5722931d83d43..7dba1c3a7b801 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -187,6 +187,11 @@ struct tc_taprio_caps {
 	bool broken_mqprio:1;
 };
 
+enum tc_taprio_qopt_cmd {
+	TAPRIO_CMD_REPLACE,
+	TAPRIO_CMD_DESTROY,
+};
+
 struct tc_taprio_sched_entry {
 	u8 command; /* TC_TAPRIO_CMD_* */
 
@@ -198,7 +203,7 @@ struct tc_taprio_sched_entry {
 struct tc_taprio_qopt_offload {
 	struct tc_mqprio_qopt_offload mqprio;
 	struct netlink_ext_ack *extack;
-	u8 enable;
+	enum tc_taprio_qopt_cmd cmd;
 	ktime_t base_time;
 	u64 cycle_time;
 	u64 cycle_time_extension;
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index cf0e61ed92253..4caf80ddc6721 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1527,7 +1527,7 @@ static int taprio_enable_offload(struct net_device *dev,
 			       "Not enough memory for enabling offload mode");
 		return -ENOMEM;
 	}
-	offload->enable = 1;
+	offload->cmd = TAPRIO_CMD_REPLACE;
 	offload->extack = extack;
 	mqprio_qopt_reconstruct(dev, &offload->mqprio.qopt);
 	offload->mqprio.extack = extack;
@@ -1575,7 +1575,7 @@ static int taprio_disable_offload(struct net_device *dev,
 			       "Not enough memory to disable offload mode");
 		return -ENOMEM;
 	}
-	offload->enable = 0;
+	offload->cmd = TAPRIO_CMD_DESTROY;
 
 	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
 	if (err < 0) {
-- 
2.39.2



