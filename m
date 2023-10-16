Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4747CA226
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjJPIqh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjJPIqg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:46:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4283EB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:46:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D145AC433C9;
        Mon, 16 Oct 2023 08:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445993;
        bh=+3ayDGWgNfh7tkmCietWJJgtNU7mtXMdFu7mtIhSZkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WF0vhaMkINjYGBpWeBqRdSrwYXEu3RxlPWuCevHPv3zLaDXbGVQv8Xzln1HQYxqzB
         y5Pb6UM9YRj1PjikJsPFS6o/m3HE+JMZ1JqnpTbZyXMqluZCeIj28wN4D9i4PEYczo
         Efjla/nDECcjNofP4IsiZs9Sfo4264T7OrQC8weg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 027/102] xen-netback: use default TX queue size for vifs
Date:   Mon, 16 Oct 2023 10:40:26 +0200
Message-ID: <20231016083954.428769460@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Pau Monne <roger.pau@citrix.com>

[ Upstream commit 66cf7435a26917c0c4d6245ad9137e7606e84fdf ]

Do not set netback interfaces (vifs) default TX queue size to the ring size.
The TX queue size is not related to the ring size, and using the ring size (32)
as the queue size can lead to packet drops.  Note the TX side of the vif
interface in the netback domain is the one receiving packets to be injected
to the guest.

Do not explicitly set the TX queue length to any value when creating the
interface, and instead use the system default.  Note that the queue length can
also be adjusted at runtime.

Fixes: f942dc2552b8 ('xen network backend driver')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/xen-netback/interface.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index e321669bc37af..f20ddaaa24518 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -41,8 +41,6 @@
 #include <asm/xen/hypercall.h>
 #include <xen/balloon.h>
 
-#define XENVIF_QUEUE_LENGTH 32
-
 /* Number of bytes allowed on the internal guest Rx queue. */
 #define XENVIF_RX_QUEUE_BYTES (XEN_NETIF_RX_RING_SIZE/2 * PAGE_SIZE)
 
@@ -527,8 +525,6 @@ struct xenvif *xenvif_alloc(struct device *parent, domid_t domid,
 	dev->features = dev->hw_features | NETIF_F_RXCSUM;
 	dev->ethtool_ops = &xenvif_ethtool_ops;
 
-	dev->tx_queue_len = XENVIF_QUEUE_LENGTH;
-
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = ETH_MAX_MTU - VLAN_ETH_HLEN;
 
-- 
2.40.1



