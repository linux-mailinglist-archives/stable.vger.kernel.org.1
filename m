Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9E97CABE4
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjJPOqy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjJPOqx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:46:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F140D9
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:46:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38478C433C9;
        Mon, 16 Oct 2023 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467611;
        bh=VcrCE87an9juUH/J1lTRAYK6Q+TdNcCbEIQHQGqXmvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEtO40Q/LRiiQ+wjHVGXUebMYCzkFgDj/S119xlsIVzgbffR6Ylx8NxlEtgzHL/Vf
         RkFGHFoxLbjJ/eN3FpLUZBPekOynCl2B9we+6p0Ct1fC1Tb1TCfd3qEJA62FLOvv9N
         WydrDgK0NCpenXayyok7hVpDpjZjXnOs2LxDQwBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 054/191] net: dsa: qca8k: fix potential MDIO bus conflict when accessing internal PHYs via management frames
Date:   Mon, 16 Oct 2023 10:40:39 +0200
Message-ID: <20231016084016.666962132@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Behún <kabel@kernel.org>

[ Upstream commit 526c8ee04bdbd4d8d19a583b1f3b06700229a815 ]

Besides the QCA8337 switch the Turris 1.x device has on it's MDIO bus
also Micron ethernet PHY (dedicated to the WAN port).

We've been experiencing a strange behavior of the WAN ethernet
interface, wherein the WAN PHY started timing out the MDIO accesses, for
example when the interface was brought down and then back up.

Bisecting led to commit 2cd548566384 ("net: dsa: qca8k: add support for
phy read/write with mgmt Ethernet"), which added support to access the
QCA8337 switch's internal PHYs via management ethernet frames.

Connecting the MDIO bus pins onto an oscilloscope, I was able to see
that the MDIO bus was active whenever a request to read/write an
internal PHY register was done via an management ethernet frame.

My theory is that when the switch core always communicates with the
internal PHYs via the MDIO bus, even when externally we request the
access via ethernet. This MDIO bus is the same one via which the switch
and internal PHYs are accessible to the board, and the board may have
other devices connected on this bus. An ASCII illustration may give more
insight:

           +---------+
      +----|         |
      |    | WAN PHY |
      | +--|         |
      | |  +---------+
      | |
      | |  +----------------------------------+
      | |  | QCA8337                          |
MDC   | |  |                        +-------+ |
------o-+--|--------o------------o--|       | |
MDIO    |  |        |            |  | PHY 1 |-|--to RJ45
--------o--|---o----+---------o--+--|       | |
           |   |    |         |  |  +-------+ |
	   | +-------------+  |  o--|       | |
	   | | MDIO MDC    |  |  |  | PHY 2 |-|--to RJ45
eth1	   | |             |  o--+--|       | |
-----------|-|port0        |  |  |  +-------+ |
           | |             |  |  o--|       | |
	   | | switch core |  |  |  | PHY 3 |-|--to RJ45
           | +-------------+  o--+--|       | |
	   |                  |  |  +-------+ |
	   |                  |  o--|  ...  | |
	   +----------------------------------+

When we send a request to read an internal PHY register via an ethernet
management frame via eth1, the switch core receives the ethernet frame
on port 0 and then communicates with the internal PHY via MDIO. At this
time, other potential devices, such as the WAN PHY on Turris 1.x, cannot
use the MDIO bus, since it may cause a bus conflict.

Fix this issue by locking the MDIO bus even when we are accessing the
PHY registers via ethernet management frames.

Fixes: 2cd548566384 ("net: dsa: qca8k: add support for phy read/write with mgmt Ethernet")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 8e1574c63954e..252089929eb92 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -666,6 +666,15 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 		goto err_read_skb;
 	}
 
+	/* It seems that accessing the switch's internal PHYs via management
+	 * packets still uses the MDIO bus within the switch internally, and
+	 * these accesses can conflict with external MDIO accesses to other
+	 * devices on the MDIO bus.
+	 * We therefore need to lock the MDIO bus onto which the switch is
+	 * connected.
+	 */
+	mutex_lock(&priv->bus->mdio_lock);
+
 	/* Actually start the request:
 	 * 1. Send mdio master packet
 	 * 2. Busy Wait for mdio master command
@@ -678,6 +687,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	mgmt_master = priv->mgmt_master;
 	if (!mgmt_master) {
 		mutex_unlock(&mgmt_eth_data->mutex);
+		mutex_unlock(&priv->bus->mdio_lock);
 		ret = -EINVAL;
 		goto err_mgmt_master;
 	}
@@ -765,6 +775,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 				    QCA8K_ETHERNET_TIMEOUT);
 
 	mutex_unlock(&mgmt_eth_data->mutex);
+	mutex_unlock(&priv->bus->mdio_lock);
 
 	return ret;
 
-- 
2.40.1



