Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C678B7D314C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjJWLHq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjJWLHp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:07:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3005410C2
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:07:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC51C433C8;
        Mon, 23 Oct 2023 11:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059262;
        bh=FkB+u9R1UTvArrdgmviYCAXTklgR8/whc3eu+W9qIzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qAb56dM/WQln2SOqL8cWYe94hA4KLWtiRJJmY8VYiZbBkHrCNuOTFENUMz1ZOGn/x
         Qz2FrvuEorzO7FYF1pNL1IKcYXiG6nYg2y5+uV7APC/4MCeCNgjzJ5Azki8SbkUR79
         c378XjapqtvvFTqgPku3rMtd3r6J4Bc9f1WsidmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 092/241] net: mdio-mux: fix C45 access returning -EIO after API change
Date:   Mon, 23 Oct 2023 12:54:38 +0200
Message-ID: <20231023104836.137484011@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

commit 1f9f2143f24e224a8582a5d54918c43b9121eccc upstream.

The mii_bus API conversion to read_c45() and write_c45() did not cover
the mdio-mux driver before read() and write() were made C22-only.

This broke arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso.
The -EOPNOTSUPP from mdiobus_c45_read() is transformed by
get_phy_c45_devs_in_pkg() into -EIO, is further propagated to
of_mdiobus_register() and this makes the mdio-mux driver fail to probe
the entire child buses, not just the PHYs that cause access errors.

Fix the regression by introducing special c45 read and write accessors
to mdio-mux which forward the operation to the parent MDIO bus.

Fixes: db1a63aed89c ("net: phy: Remove fallback to old C45 method")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://lore.kernel.org/r/20231017143144.3212657-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/mdio/mdio-mux.c | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
index a881e3523328..bef4cce71287 100644
--- a/drivers/net/mdio/mdio-mux.c
+++ b/drivers/net/mdio/mdio-mux.c
@@ -55,6 +55,27 @@ out:
 	return r;
 }
 
+static int mdio_mux_read_c45(struct mii_bus *bus, int phy_id, int dev_addr,
+			     int regnum)
+{
+	struct mdio_mux_child_bus *cb = bus->priv;
+	struct mdio_mux_parent_bus *pb = cb->parent;
+	int r;
+
+	mutex_lock_nested(&pb->mii_bus->mdio_lock, MDIO_MUTEX_MUX);
+	r = pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
+	if (r)
+		goto out;
+
+	pb->current_child = cb->bus_number;
+
+	r = pb->mii_bus->read_c45(pb->mii_bus, phy_id, dev_addr, regnum);
+out:
+	mutex_unlock(&pb->mii_bus->mdio_lock);
+
+	return r;
+}
+
 /*
  * The parent bus' lock is used to order access to the switch_fn.
  */
@@ -80,6 +101,28 @@ out:
 	return r;
 }
 
+static int mdio_mux_write_c45(struct mii_bus *bus, int phy_id, int dev_addr,
+			      int regnum, u16 val)
+{
+	struct mdio_mux_child_bus *cb = bus->priv;
+	struct mdio_mux_parent_bus *pb = cb->parent;
+
+	int r;
+
+	mutex_lock_nested(&pb->mii_bus->mdio_lock, MDIO_MUTEX_MUX);
+	r = pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
+	if (r)
+		goto out;
+
+	pb->current_child = cb->bus_number;
+
+	r = pb->mii_bus->write_c45(pb->mii_bus, phy_id, dev_addr, regnum, val);
+out:
+	mutex_unlock(&pb->mii_bus->mdio_lock);
+
+	return r;
+}
+
 static int parent_count;
 
 static void mdio_mux_uninit_children(struct mdio_mux_parent_bus *pb)
@@ -173,6 +216,10 @@ int mdio_mux_init(struct device *dev,
 		cb->mii_bus->parent = dev;
 		cb->mii_bus->read = mdio_mux_read;
 		cb->mii_bus->write = mdio_mux_write;
+		if (parent_bus->read_c45)
+			cb->mii_bus->read_c45 = mdio_mux_read_c45;
+		if (parent_bus->write_c45)
+			cb->mii_bus->write_c45 = mdio_mux_write_c45;
 		r = of_mdiobus_register(cb->mii_bus, child_bus_node);
 		if (r) {
 			mdiobus_free(cb->mii_bus);
-- 
2.42.0



