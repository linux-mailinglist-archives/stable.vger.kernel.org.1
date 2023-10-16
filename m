Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E857CA2F8
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjJPI73 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjJPI72 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:59:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD9EDE
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:59:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800FEC433C7;
        Mon, 16 Oct 2023 08:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446766;
        bh=EzQAFu8Q/JeKCx+gBEyz8iRlDFIW2CnuUpIA8y2NGT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQ5hDSMfxEh3ETFjqDaBge2o1zy2HMNICvyTkzyj7mjM4dOrWjf7rGffEzoErQS3S
         Dkzhmtkx8vmqm4rYbhaTFmdMPc1/CDS4sqCRZK8zbuMJKo/spdLKCuViGbWdvHUcJP
         /LXLcw5G3qRdW8IQ/3hHU1yTnufDZiWuZuGbn1wI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 041/131] phy: lynx-28g: serialize concurrent phy_set_mode_ext() calls to shared registers
Date:   Mon, 16 Oct 2023 10:40:24 +0200
Message-ID: <20231016084001.092692077@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 139ad1143151a07be93bf741d4ea7c89e59f89ce ]

The protocol converter configuration registers PCC8, PCCC, PCCD
(implemented by the driver), as well as others, control protocol
converters from multiple lanes (each represented as a different
struct phy). So, if there are simultaneous calls to phy_set_mode_ext()
to lanes sharing the same PCC register (either for the "old" or for the
"new" protocol), corruption of the values programmed to hardware is
possible, because lynx_28g_rmw() has no locking.

Add a spinlock in the struct lynx_28g_priv shared by all lanes, and take
the global spinlock from the phy_ops :: set_mode() implementation. There
are no other callers which modify PCC registers.

Fixes: 8f73b37cf3fb ("phy: add support for the Layerscape SerDes 28G")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index d49aa59c7d812..0a8b40edc3f31 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -126,6 +126,10 @@ struct lynx_28g_lane {
 struct lynx_28g_priv {
 	void __iomem *base;
 	struct device *dev;
+	/* Serialize concurrent access to registers shared between lanes,
+	 * like PCCn
+	 */
+	spinlock_t pcc_lock;
 	struct lynx_28g_pll pll[LYNX_28G_NUM_PLL];
 	struct lynx_28g_lane lane[LYNX_28G_NUM_LANE];
 
@@ -396,6 +400,8 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (powered_up)
 		lynx_28g_power_off(phy);
 
+	spin_lock(&priv->pcc_lock);
+
 	switch (submode) {
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
@@ -412,6 +418,8 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	lane->interface = submode;
 
 out:
+	spin_unlock(&priv->pcc_lock);
+
 	/* Power up the lane if necessary */
 	if (powered_up)
 		lynx_28g_power_on(phy);
@@ -595,6 +603,7 @@ static int lynx_28g_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, priv);
 
+	spin_lock_init(&priv->pcc_lock);
 	INIT_DELAYED_WORK(&priv->cdr_check, lynx_28g_cdr_lock_check);
 
 	queue_delayed_work(system_power_efficient_wq, &priv->cdr_check,
-- 
2.40.1



