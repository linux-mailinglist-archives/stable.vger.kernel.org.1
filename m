Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC9576133A
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjGYLJA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjGYLIq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:08:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E2D1FF3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2D4A6166F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE5EC433C8;
        Tue, 25 Jul 2023 11:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283239;
        bh=sgiXb5rYqzt7/yH49o/1J+SEM7p0rmUfJ5BbMBXIZzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+c1gDJPkv9cYaJ/8+3gBMZrs7BkPthUPelwJmPa6+Sw8H+kcoWZ1SOtMcumQmIiS
         aWITbbRgs5ciu76+0JnIgPVvdsHqWOFODKGGZ2hGn4vVZi3gKlFI6l9kqB+x5c/cJF
         ZVqx4YJE/LS1zbC57aSE+G+ReTzwSOzab2xb5zJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 163/183] net: phy: prevent stale pointer dereference in phy_init()
Date:   Tue, 25 Jul 2023 12:46:31 +0200
Message-ID: <20230725104513.669513303@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 1c613beaf877c0c0d755853dc62687e2013e55c4 ]

mdio_bus_init() and phy_driver_register() both have error paths, and if
those are ever hit, ethtool will have a stale pointer to the
phy_ethtool_phy_ops stub structure, which references memory from a
module that failed to load (phylib).

It is probably hard to force an error in this code path even manually,
but the error teardown path of phy_init() should be the same as
phy_exit(), which is now simply not the case.

Fixes: 55d8f053ce1b ("net: phy: Register ethtool PHY operations")
Link: https://lore.kernel.org/netdev/ZLaiJ4G6TaJYGJyU@shell.armlinux.org.uk/
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20230720000231.1939689-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7fbb0904b3c0f..82f74f96eba29 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3252,23 +3252,30 @@ static int __init phy_init(void)
 {
 	int rc;
 
+	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
+
 	rc = mdio_bus_init();
 	if (rc)
-		return rc;
+		goto err_ethtool_phy_ops;
 
-	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
 	features_init();
 
 	rc = phy_driver_register(&genphy_c45_driver, THIS_MODULE);
 	if (rc)
-		goto err_c45;
+		goto err_mdio_bus;
 
 	rc = phy_driver_register(&genphy_driver, THIS_MODULE);
-	if (rc) {
-		phy_driver_unregister(&genphy_c45_driver);
+	if (rc)
+		goto err_c45;
+
+	return 0;
+
 err_c45:
-		mdio_bus_exit();
-	}
+	phy_driver_unregister(&genphy_c45_driver);
+err_mdio_bus:
+	mdio_bus_exit();
+err_ethtool_phy_ops:
+	ethtool_set_ethtool_phy_ops(NULL);
 
 	return rc;
 }
-- 
2.39.2



