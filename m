Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845BB7831D8
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjHUTz2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjHUTz1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E334116
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5B7E645BA
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E3AC433C7;
        Mon, 21 Aug 2023 19:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647723;
        bh=T5MU6jF5KOyWYO3Zt6cs03l/9+YJiYr8j27WN3QgHTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GiOg7dOKyJV2NOwHK1JMtveNBSZ5b+jOOvc25mo+qRBzJYR6Xd9mOvR8tLB7FqL/V
         UI4FaxmGuj8I7g6wco8QwEd7Nlq0G1c3s+yRfgWkvnh60tx9OSfHGHUiIE9X6m1bzz
         ZzdyhqyyrrS79DFAdil8YtTiyS3vLFNPqFIMJwtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 115/194] net: phy: fix IRQ-based wake-on-lan over hibernate / power off
Date:   Mon, 21 Aug 2023 21:41:34 +0200
Message-ID: <20230821194127.748307900@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[ Upstream commit cc941e548bffc01b5816b4edc5cb432a137a58b3 ]

Uwe reports:
"Most PHYs signal WoL using an interrupt. So disabling interrupts [at
shutdown] breaks WoL at least on PHYs covered by the marvell driver."

Discussing with Ioana, the problem which was trying to be solved was:
"The board in question is a LS1021ATSN which has two AR8031 PHYs that
share an interrupt line. In case only one of the PHYs is probed and
there are pending interrupts on the PHY#2 an IRQ storm will happen
since there is no entity to clear the interrupt from PHY#2's registers.
PHY#1's driver will get stuck in .handle_interrupt() indefinitely."

Further confirmation that "the two AR8031 PHYs are on the same MDIO
bus."

With WoL using interrupts to wake the system, in such a case, the
system will begin booting with an asserted interrupt. Thus, we need to
cope with an interrupt asserted during boot.

Solve this instead by disabling interrupts during PHY probe. This will
ensure in Ioana's situation that both PHYs of the same type sharing an
interrupt line on a common MDIO bus will have their interrupt outputs
disabled when the driver probes the device, but before we hook in any
interrupt handlers - thus avoiding the interrupt storm.

A better fix would be for platform firmware to disable the interrupting
devices at source during boot, before control is handed to the kernel.

Fixes: e2f016cf7751 ("net: phy: add a shutdown procedure")
Link: 20230804071757.383971-1-u.kleine-koenig@pengutronix.de
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 82f74f96eba29..944f76e6fc8eb 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3050,6 +3050,8 @@ static int phy_probe(struct device *dev)
 			goto out;
 	}
 
+	phy_disable_interrupts(phydev);
+
 	/* Start out supporting everything. Eventually,
 	 * a controller will attach, and may modify one
 	 * or both of these values
@@ -3137,16 +3139,6 @@ static int phy_remove(struct device *dev)
 	return 0;
 }
 
-static void phy_shutdown(struct device *dev)
-{
-	struct phy_device *phydev = to_phy_device(dev);
-
-	if (phydev->state == PHY_READY || !phydev->attached_dev)
-		return;
-
-	phy_disable_interrupts(phydev);
-}
-
 /**
  * phy_driver_register - register a phy_driver with the PHY layer
  * @new_driver: new phy_driver to register
@@ -3180,7 +3172,6 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
 	new_driver->mdiodrv.driver.probe = phy_probe;
 	new_driver->mdiodrv.driver.remove = phy_remove;
-	new_driver->mdiodrv.driver.shutdown = phy_shutdown;
 	new_driver->mdiodrv.driver.owner = owner;
 	new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
 
-- 
2.40.1



