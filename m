Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BE375D465
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGUTUo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjGUTUn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:20:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6A11BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:20:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F181F61B1C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFAEC433C7;
        Fri, 21 Jul 2023 19:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967241;
        bh=N0zUD4oLOWAoNoJeqv85jNsoEXADyMEc3B/d1WQ2E4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4ujdW/EvdG2Gb2+xNU9Y1lEkoxQUKuqffLfWftAoUoO9YJjKm/WC4e5y9FZcbIap
         1pUak+IZ8+G2s8OfTzpQtB7QrjAyVxTJJYannOTrRGEgMVH86uLrqnba2tbo3EAblm
         P1/tmSc/tmVjZ/mIcPUucu8pQ21Ii/IsOsHeqDvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 094/223] net: bcmgenet: Ensure MDIO unregistration has clocks enabled
Date:   Fri, 21 Jul 2023 18:05:47 +0200
Message-ID: <20230721160524.871089383@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Fainelli <florian.fainelli@broadcom.com>

commit 1b5ea7ffb7a3bdfffb4b7f40ce0d20a3372ee405 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -664,5 +664,7 @@ void bcmgenet_mii_exit(struct net_device
 	if (of_phy_is_fixed_link(dn))
 		of_phy_deregister_fixed_link(dn);
 	of_node_put(priv->phy_dn);
+	clk_prepare_enable(priv->clk);
 	platform_device_unregister(priv->mii_pdev);
+	clk_disable_unprepare(priv->clk);
 }


