Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A876136D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjGYLKs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjGYLKU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2046D1BE1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51A856166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9DBC433CA;
        Tue, 25 Jul 2023 11:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283352;
        bh=6lqCZikFZ4MnjExxQiL6wmOkGZmzQwWnjq6fKRuwVwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UytQ8bP6HbfxJrO6Mo4wJSvirx37biUGvGYrn3nIUvWLLJV67P5WqhNjxzu9tRBFO
         ll1MHKzEIHVRcJgkUUUi6spL5BIZQutF5UgfPUBD1qKXOnxWsXI3Xov7P61e/gTrsk
         qxYKjjXRQhdVs/0q4KJGxSIKkk5gGu4liii0T7j4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 45/78] of: net: add a helper for loading netdev->dev_addr
Date:   Tue, 25 Jul 2023 12:46:36 +0200
Message-ID: <20230725104453.037468825@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit d466effe282ddbab6acb6c3120c1de0ee1b86d57 ]

Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
of VLANs...") introduced a rbtree for faster Ethernet address look
up. To maintain netdev->dev_addr in this tree we need to make all
the writes to it got through appropriate helpers.

There are roughly 40 places where netdev->dev_addr is passed
as the destination to a of_get_mac_address() call. Add a helper
which takes a dev pointer instead, so it can call an appropriate
helper.

Note that of_get_mac_address() already assumes the address is
6 bytes long (ETH_ALEN) so use eth_hw_addr_set().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1d6d537dc55d ("net: ethernet: mtk_eth_soc: handle probe deferral")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/of_net.h |  6 ++++++
 net/core/of_net.c      | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index 55460ecfa50ad..0484b613ca647 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -14,6 +14,7 @@
 struct net_device;
 extern int of_get_phy_mode(struct device_node *np, phy_interface_t *interface);
 extern int of_get_mac_address(struct device_node *np, u8 *mac);
+int of_get_ethdev_address(struct device_node *np, struct net_device *dev);
 extern struct net_device *of_find_net_device_by_node(struct device_node *np);
 #else
 static inline int of_get_phy_mode(struct device_node *np,
@@ -27,6 +28,11 @@ static inline int of_get_mac_address(struct device_node *np, u8 *mac)
 	return -ENODEV;
 }
 
+static inline int of_get_ethdev_address(struct device_node *np, struct net_device *dev)
+{
+	return -ENODEV;
+}
+
 static inline struct net_device *of_find_net_device_by_node(struct device_node *np)
 {
 	return NULL;
diff --git a/net/core/of_net.c b/net/core/of_net.c
index dbac3a172a11e..f1a9bf7578e7a 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -143,3 +143,28 @@ int of_get_mac_address(struct device_node *np, u8 *addr)
 	return of_get_mac_addr_nvmem(np, addr);
 }
 EXPORT_SYMBOL(of_get_mac_address);
+
+/**
+ * of_get_ethdev_address()
+ * @np:		Caller's Device Node
+ * @dev:	Pointer to netdevice which address will be updated
+ *
+ * Search the device tree for the best MAC address to use.
+ * If found set @dev->dev_addr to that address.
+ *
+ * See documentation of of_get_mac_address() for more information on how
+ * the best address is determined.
+ *
+ * Return: 0 on success and errno in case of error.
+ */
+int of_get_ethdev_address(struct device_node *np, struct net_device *dev)
+{
+	u8 addr[ETH_ALEN];
+	int ret;
+
+	ret = of_get_mac_address(np, addr);
+	if (!ret)
+		eth_hw_addr_set(dev, addr);
+	return ret;
+}
+EXPORT_SYMBOL(of_get_ethdev_address);
-- 
2.39.2



