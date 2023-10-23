Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E097D3296
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjJWLVx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJWLVw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:21:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427DC92
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:21:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8191EC433C8;
        Mon, 23 Oct 2023 11:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060109;
        bh=eP1MP/no/EukDk9EJb/c5PKWzckmiiDncWF+93Z0kJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GpVPaigCmoTgYMht+//vS4J54PC+obzPjAB+jXPqFd5tJqdBW352ODgAaZmI4gtPI
         Q7W+jGws8hLgX2QpAh5vpb6FfJ9qg6R5HcgsxBBnV1KTvRbh7FaxxgLN2UpivMuJrK
         ngDJY/Q+ps+TIWbbspyyMSSiSFFxZGjwDU1KeOec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        Simon Horman <horms@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 062/196] net: dsa: bcm_sf2: Fix possible memory leak in bcm_sf2_mdio_register()
Date:   Mon, 23 Oct 2023 12:55:27 +0200
Message-ID: <20231023104830.292770739@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit 61b40cefe51af005c72dbdcf975a3d166c6e6406 upstream.

In bcm_sf2_mdio_register(), the class_find_device() will call get_device()
to increment reference count for priv->master_mii_bus->dev if
of_mdio_find_bus() succeeds. If mdiobus_alloc() or mdiobus_register()
fails, it will call get_device() twice without decrement reference count
for the device. And it is the same if bcm_sf2_mdio_register() succeeds but
fails in bcm_sf2_sw_probe(), or if bcm_sf2_sw_probe() succeeds. If the
reference count has not decremented to zero, the dev related resource will
not be freed.

So remove the get_device() in bcm_sf2_mdio_register(), and call
put_device() if mdiobus_alloc() or mdiobus_register() fails and in
bcm_sf2_mdio_unregister() to solve the issue.

And as Simon suggested, unwind from errors for bcm_sf2_mdio_register() and
just return 0 if it succeeds to make it cleaner.

Fixes: 461cd1b03e32 ("net: dsa: bcm_sf2: Register our slave MDIO bus")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20231011032419.2423290-1-ruanjinjie@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/bcm_sf2.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -617,17 +617,16 @@ static int bcm_sf2_mdio_register(struct
 	dn = of_find_compatible_node(NULL, NULL, "brcm,unimac-mdio");
 	priv->master_mii_bus = of_mdio_find_bus(dn);
 	if (!priv->master_mii_bus) {
-		of_node_put(dn);
-		return -EPROBE_DEFER;
+		err = -EPROBE_DEFER;
+		goto err_of_node_put;
 	}
 
-	get_device(&priv->master_mii_bus->dev);
 	priv->master_mii_dn = dn;
 
 	priv->slave_mii_bus = mdiobus_alloc();
 	if (!priv->slave_mii_bus) {
-		of_node_put(dn);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_put_master_mii_bus_dev;
 	}
 
 	priv->slave_mii_bus->priv = priv;
@@ -684,11 +683,17 @@ static int bcm_sf2_mdio_register(struct
 	}
 
 	err = mdiobus_register(priv->slave_mii_bus);
-	if (err && dn) {
-		mdiobus_free(priv->slave_mii_bus);
-		of_node_put(dn);
-	}
+	if (err && dn)
+		goto err_free_slave_mii_bus;
+
+	return 0;
 
+err_free_slave_mii_bus:
+	mdiobus_free(priv->slave_mii_bus);
+err_put_master_mii_bus_dev:
+	put_device(&priv->master_mii_bus->dev);
+err_of_node_put:
+	of_node_put(dn);
 	return err;
 }
 
@@ -696,6 +701,7 @@ static void bcm_sf2_mdio_unregister(stru
 {
 	mdiobus_unregister(priv->slave_mii_bus);
 	mdiobus_free(priv->slave_mii_bus);
+	put_device(&priv->master_mii_bus->dev);
 	of_node_put(priv->master_mii_dn);
 }
 


