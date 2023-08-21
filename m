Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2672D7832A5
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjHUTzP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjHUTzP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:55:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE62610B
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62AF664596
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBEFC433C8;
        Mon, 21 Aug 2023 19:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647711;
        bh=baEKYuGNA04bZe8BVW2C4ZyFkyRLTl9Gqgeow+Fnk6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WCSvrldNSAgwfnOXNkUMxND4VBSl7UjsuDsDqx7p8EUPIUPWDNtNBKGzwrTeOWmyi
         RilpQU+x3RLCrkG/mxVX8uS8+MzlDEIWyIesW8bh6uRjYffBFQIwZAtAkvgDig2Jm9
         mPTnvMR/RGtSLHck3XLthyKfMTP9IzbcBX9M14bA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 112/194] virtio_net: notify MAC address change on device initialization
Date:   Mon, 21 Aug 2023 21:41:31 +0200
Message-ID: <20230821194127.627186260@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Laurent Vivier <lvivier@redhat.com>

[ Upstream commit 9f62d221a4b0aa6a8d2a18053a0ca349c025297c ]

In virtnet_probe(), if the device doesn't provide a MAC address the
driver assigns a random one.
As we modify the MAC address we need to notify the device to allow it
to update all the related information.

The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
assign a MAC address by default. The virtio_net device uses a random
MAC address (we can see it with "ip link"), but we can't ping a net
namespace from another one using the virtio-vdpa device because the
new MAC address has not been provided to the hardware:
RX packets are dropped since they don't go through the receive filters,
TX packets go through unaffected.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 51b813176f09 ("virtio-net: set queues after driver_ok")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 075d5d42f5eb6..b7a4df4bab817 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3825,6 +3825,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		eth_hw_addr_set(dev, addr);
 	} else {
 		eth_hw_addr_random(dev);
+		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
+			 dev->dev_addr);
 	}
 
 	/* Set up our device-specific information */
@@ -3954,6 +3956,24 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	/* a random MAC address has been assigned, notify the device.
+	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
+	 * because many devices work fine without getting MAC explicitly
+	 */
+	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
+	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
+		struct scatterlist sg;
+
+		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
+		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
+					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
+			pr_debug("virtio_net: setting MAC address failed\n");
+			rtnl_unlock();
+			err = -EINVAL;
+			goto free_unregister_netdev;
+		}
+	}
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
-- 
2.40.1



