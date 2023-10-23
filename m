Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3EC7D3376
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjJWLag (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjJWLad (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:30:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC260C1
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:30:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6AAC433C7;
        Mon, 23 Oct 2023 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060629;
        bh=ZO9gz6YhaU+AfMBbWSxdNIBqIPTYfhUkAAd1KQ3ZmF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cdGu+QbMNDgoVVCyT0qPEEy1qhXB/GQmPGcjDyD8EzmfXiVPIu9r9CtZGswgG3gX/
         vD/4hjEDK6uEcV7grOkSEymXgzSmCwkN3jONwI244pbgokCGy2LZG13Jg1shrb4tt5
         9a1gUMXNtbZdDhopHVaY0fv95FjQiirDkXqUjy0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 013/123] xen-netback: use default TX queue size for vifs
Date:   Mon, 23 Oct 2023 12:56:11 +0200
Message-ID: <20231023104818.186273621@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/net/xen-netback/interface.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -41,7 +41,6 @@
 #include <asm/xen/hypercall.h>
 #include <xen/balloon.h>
 
-#define XENVIF_QUEUE_LENGTH 32
 #define XENVIF_NAPI_WEIGHT  64
 
 /* Number of bytes allowed on the internal guest Rx queue. */
@@ -526,8 +525,6 @@ struct xenvif *xenvif_alloc(struct devic
 	dev->features = dev->hw_features | NETIF_F_RXCSUM;
 	dev->ethtool_ops = &xenvif_ethtool_ops;
 
-	dev->tx_queue_len = XENVIF_QUEUE_LENGTH;
-
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = ETH_MAX_MTU - VLAN_ETH_HLEN;
 


