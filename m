Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50BB7D1700
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 22:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjJTU2z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 16:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjJTU2y (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 16:28:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB3ED63
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 13:28:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2814C433C7;
        Fri, 20 Oct 2023 20:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697833732;
        bh=xn8bM6RwDj/Z2ywto15rFCT9Sf14YewoVuz2yzHCSHA=;
        h=Subject:To:Cc:From:Date:From;
        b=h3DMHK+couwAYKpJJoVeQ9TY7V4WJzrdjQ4p1EUdDYZcswo5kiBf09WUPPm7d7oU5
         BrLbF0cIlEp26ofqIBS5dpPWMYiHD7BaNqq5lUAMfCUY5Egon9UfbsQIUtcu66ycz0
         AaKBW8MSoh1Pd2nK/gAA6XGEy2eRuU/nfFmZwCvY=
Subject: FAILED: patch "[PATCH] net: dsa: bcm_sf2: Fix possible memory leak in" failed to apply to 4.19-stable tree
To:     ruanjinjie@huawei.com, florian.fainelli@broadcom.com,
        horms@kernel.org, kuba@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 22:28:41 +0200
Message-ID: <2023102041-speculate-spew-1d42@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 61b40cefe51af005c72dbdcf975a3d166c6e6406
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102041-speculate-spew-1d42@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 61b40cefe51af005c72dbdcf975a3d166c6e6406 Mon Sep 17 00:00:00 2001
From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Wed, 11 Oct 2023 11:24:19 +0800
Subject: [PATCH] net: dsa: bcm_sf2: Fix possible memory leak in
 bcm_sf2_mdio_register()

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

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 72374b066f64..cd1f240c90f3 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -617,17 +617,16 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
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
@@ -684,11 +683,17 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	}
 
 	err = mdiobus_register(priv->slave_mii_bus);
-	if (err && dn) {
-		mdiobus_free(priv->slave_mii_bus);
-		of_node_put(dn);
-	}
+	if (err && dn)
+		goto err_free_slave_mii_bus;
 
+	return 0;
+
+err_free_slave_mii_bus:
+	mdiobus_free(priv->slave_mii_bus);
+err_put_master_mii_bus_dev:
+	put_device(&priv->master_mii_bus->dev);
+err_of_node_put:
+	of_node_put(dn);
 	return err;
 }
 
@@ -696,6 +701,7 @@ static void bcm_sf2_mdio_unregister(struct bcm_sf2_priv *priv)
 {
 	mdiobus_unregister(priv->slave_mii_bus);
 	mdiobus_free(priv->slave_mii_bus);
+	put_device(&priv->master_mii_bus->dev);
 	of_node_put(priv->master_mii_dn);
 }
 

