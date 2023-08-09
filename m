Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E874F775AE6
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjHILMj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjHILMj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AC9ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 295B663154
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A5EC433CB;
        Wed,  9 Aug 2023 11:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579557;
        bh=sUg5CXry5bEjhKRRgTCFUx7/5Eb63FZ+581co+x/pbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SoSFobW1TGk80P+QGKS8mhNlfNbS9cix0RCEVRbv3YAL0Sbal9boOypn0NgVy4glU
         bd7irTFQmVEhkU1Ve/L0nrrl4ext41HfLoFeTEFCg+z/r9bSeuUUpbA1wMcqo1d21I
         crO8ICP5s1l3Ve5xp0ZOzt6IUvKLygxF2UR2IrOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 033/323] net: create netdev->dev_addr assignment helpers
Date:   Wed,  9 Aug 2023 12:37:51 +0200
Message-ID: <20230809103659.627722165@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 48eab831ae8b9f7002a533fa4235eed63ea1f1a3 ]

Recent work on converting address list to a tree made it obvious
we need an abstraction around writing netdev->dev_addr. Without
such abstraction updating the main device address is invisible
to the core.

Introduce a number of helpers which for now just wrap memcpy()
but in the future can make necessary changes to the address
tree.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 391af06a02e7 ("wifi: wl3501_cs: Fix an error handling path in wl3501_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/etherdevice.h | 12 ++++++++++++
 include/linux/netdevice.h   | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index e1e9eff096d05..2932a40060c1d 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -291,6 +291,18 @@ static inline void ether_addr_copy(u8 *dst, const u8 *src)
 #endif
 }
 
+/**
+ * eth_hw_addr_set - Assign Ethernet address to a net_device
+ * @dev: pointer to net_device structure
+ * @addr: address to assign
+ *
+ * Assign given address to the net_device, addr_assign_type is not changed.
+ */
+static inline void eth_hw_addr_set(struct net_device *dev, const u8 *addr)
+{
+	ether_addr_copy(dev->dev_addr, addr);
+}
+
 /**
  * eth_hw_addr_inherit - Copy dev_addr from another net_device
  * @dst: pointer to net_device to copy dev_addr to
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 90827d85265b0..7e9df3854420a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4079,6 +4079,24 @@ void __hw_addr_unsync_dev(struct netdev_hw_addr_list *list,
 void __hw_addr_init(struct netdev_hw_addr_list *list);
 
 /* Functions used for device addresses handling */
+static inline void
+__dev_addr_set(struct net_device *dev, const u8 *addr, size_t len)
+{
+	memcpy(dev->dev_addr, addr, len);
+}
+
+static inline void dev_addr_set(struct net_device *dev, const u8 *addr)
+{
+	__dev_addr_set(dev, addr, dev->addr_len);
+}
+
+static inline void
+dev_addr_mod(struct net_device *dev, unsigned int offset,
+	     const u8 *addr, size_t len)
+{
+	memcpy(&dev->dev_addr[offset], addr, len);
+}
+
 int dev_addr_add(struct net_device *dev, const unsigned char *addr,
 		 unsigned char addr_type);
 int dev_addr_del(struct net_device *dev, const unsigned char *addr,
-- 
2.39.2



