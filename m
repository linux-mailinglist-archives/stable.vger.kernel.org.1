Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AAE75CD6C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjGUQLA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjGUQKw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:10:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40430F1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DE9B61D33
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC99C433C8;
        Fri, 21 Jul 2023 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955846;
        bh=yyuFDYs1JsTwP6q0nZ5Si+Ydn7Eor8DqseQU5w+MJvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EX5PtrGz5MLdTonH+G/aU3liNdRuOabq3gDwVDm2eXrGpAtYg1pBpMqEfLDIx2I3b
         lxchzqtvASGxWBA+Rt+IK4IDyxwAwaIYxI5N1Zzemkd6uslfg2xoXEeLUMHqP3Kc4/
         1Jm5c00CyQgQqMZq6g1FYKTNUBjbRSxsUryils8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 043/292] net: dsa: felix: make vsc9959_tas_guard_bands_update() visible to ocelot->ops
Date:   Fri, 21 Jul 2023 18:02:32 +0200
Message-ID: <20230721160530.654425233@linuxfoundation.org>
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

[ Upstream commit c60819149b637d0f9f7f66e110d2a0d90a3993ea ]

In a future change we will need to make
ocelot_port_update_active_preemptible_tcs() call
vsc9959_tas_guard_bands_update(), but that is currently not possible,
since the ocelot switch lib does not have access to functions private to
the DSA wrapper.

Move the pointer to vsc9959_tas_guard_bands_update() from felix->info
(which is private to the DSA driver) to ocelot->ops (which is also
visible to the ocelot switch lib).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-ID: <20230705104422.49025-3-vladimir.oltean@nxp.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c6efb4ae387c ("net: mscc: ocelot: fix oversize frame dropping for preemptible TCs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/ocelot/felix.c         | 5 ++---
 drivers/net/dsa/ocelot/felix.h         | 1 -
 drivers/net/dsa/ocelot/felix_vsc9959.c | 2 +-
 include/soc/mscc/ocelot.h              | 1 +
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 70c0e2b1936b3..8348da2b3c97a 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1786,14 +1786,13 @@ static int felix_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
 	struct ocelot *ocelot = ds->priv;
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
-	struct felix *felix = ocelot_to_felix(ocelot);
 
 	ocelot_port_set_maxlen(ocelot, port, new_mtu);
 
 	mutex_lock(&ocelot->tas_lock);
 
-	if (ocelot_port->taprio && felix->info->tas_guard_bands_update)
-		felix->info->tas_guard_bands_update(ocelot, port);
+	if (ocelot_port->taprio && ocelot->ops->tas_guard_bands_update)
+		ocelot->ops->tas_guard_bands_update(ocelot, port);
 
 	mutex_unlock(&ocelot->tas_lock);
 
diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/felix.h
index 96008c046da53..1d4befe7cfe8e 100644
--- a/drivers/net/dsa/ocelot/felix.h
+++ b/drivers/net/dsa/ocelot/felix.h
@@ -57,7 +57,6 @@ struct felix_info {
 	void	(*mdio_bus_free)(struct ocelot *ocelot);
 	int	(*port_setup_tc)(struct dsa_switch *ds, int port,
 				 enum tc_setup_type type, void *type_data);
-	void	(*tas_guard_bands_update)(struct ocelot *ocelot, int port);
 	void	(*port_sched_speed_set)(struct ocelot *ocelot, int port,
 					u32 speed);
 	void	(*phylink_mac_config)(struct ocelot *ocelot, int port,
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index d172a3e9736c4..219fb672a68d7 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -2600,6 +2600,7 @@ static const struct ocelot_ops vsc9959_ops = {
 	.cut_through_fwd	= vsc9959_cut_through_fwd,
 	.tas_clock_adjust	= vsc9959_tas_clock_adjust,
 	.update_stats		= vsc9959_update_stats,
+	.tas_guard_bands_update	= vsc9959_tas_guard_bands_update,
 };
 
 static const struct felix_info felix_info_vsc9959 = {
@@ -2625,7 +2626,6 @@ static const struct felix_info felix_info_vsc9959 = {
 	.port_modes		= vsc9959_port_modes,
 	.port_setup_tc		= vsc9959_port_setup_tc,
 	.port_sched_speed_set	= vsc9959_sched_speed_set,
-	.tas_guard_bands_update	= vsc9959_tas_guard_bands_update,
 };
 
 /* The INTB interrupt is shared between for PTP TX timestamp availability
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 22aae505c813b..85a726fb006ca 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -663,6 +663,7 @@ struct ocelot_ops {
 			      struct flow_stats *stats);
 	void (*cut_through_fwd)(struct ocelot *ocelot);
 	void (*tas_clock_adjust)(struct ocelot *ocelot);
+	void (*tas_guard_bands_update)(struct ocelot *ocelot, int port);
 	void (*update_stats)(struct ocelot *ocelot);
 };
 
-- 
2.39.2



