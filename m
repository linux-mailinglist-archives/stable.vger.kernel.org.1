Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCEB75BD77
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 06:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjGUEkd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 00:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGUEkB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 00:40:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480AE2D47
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 21:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4334610A0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 04:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740CFC433C8;
        Fri, 21 Jul 2023 04:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689914390;
        bh=IJ+z7abSx4RWmi6Prgi4+jYMOlajwIgTVVQOd1se560=;
        h=Subject:To:Cc:From:Date:From;
        b=2e3Q04Qc8i2gtSKCWz8NIC1BS91jTbos9MgOAK9+NMjzs/4xq84BzZa1EUpUfG/2h
         eBR1OUoH3W5mfw5u5QW6ipe8PS4waBAYG59SDZraO1pIFhJBtR9uLVOo/QXSFzo5PX
         HUhlnsaLZwu5LpOi2SYtGakUq9B5KkRcEGn1m+Ck=
Subject: FAILED: patch "[PATCH] net: bcmgenet: Ensure MDIO unregistration has clocks enabled" failed to apply to 4.14-stable tree
To:     florian.fainelli@broadcom.com, andrew@lunn.ch, kuba@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 06:39:42 +0200
Message-ID: <2023072142-canyon-unsoiled-28d5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 1b5ea7ffb7a3bdfffb4b7f40ce0d20a3372ee405
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072142-canyon-unsoiled-28d5@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

1b5ea7ffb7a3 ("net: bcmgenet: Ensure MDIO unregistration has clocks enabled")
aa7365e19f84 ("net: bcmgenet: Avoid calling platform_device_put() twice in bcmgenet_mii_exit()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b5ea7ffb7a3bdfffb4b7f40ce0d20a3372ee405 Mon Sep 17 00:00:00 2001
From: Florian Fainelli <florian.fainelli@broadcom.com>
Date: Thu, 22 Jun 2023 03:31:07 -0700
Subject: [PATCH] net: bcmgenet: Ensure MDIO unregistration has clocks enabled

With support for Ethernet PHY LEDs having been added, while
unregistering a MDIO bus and its child device liks PHYs there may be
"late" accesses to the MDIO bus. One typical use case is setting the PHY
LEDs brightness to OFF for instance.

We need to ensure that the MDIO bus controller remains entirely
functional since it runs off the main GENET adapter clock.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20230617155500.4005881-1-andrew@lunn.ch/
Fixes: 9a4e79697009 ("net: bcmgenet: utilize generic Broadcom UniMAC MDIO controller driver")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20230622103107.1760280-1-florian.fainelli@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index c15ed0acdb77..0092e46c46f8 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -673,5 +673,7 @@ void bcmgenet_mii_exit(struct net_device *dev)
 	if (of_phy_is_fixed_link(dn))
 		of_phy_deregister_fixed_link(dn);
 	of_node_put(priv->phy_dn);
+	clk_prepare_enable(priv->clk);
 	platform_device_unregister(priv->mii_pdev);
+	clk_disable_unprepare(priv->clk);
 }

