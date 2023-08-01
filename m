Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CE276A882
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 07:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjHAFv6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 01:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjHAFv6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 01:51:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257B0119
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 22:51:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B317561470
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 05:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E2CC433C8;
        Tue,  1 Aug 2023 05:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690869116;
        bh=tnqNq1Yt0AcIq8ORWOtdxNqhisdR8uP4C6+/p/baXb0=;
        h=Subject:To:Cc:From:Date:From;
        b=KjVOIyLG0p/ESQs47Yc0AmA7vO4iL7EsY+1JZ2TVQNalUYL3FcVKpHFL6lpGdV7QU
         HWtB4fD/VjFhX/JrbnyscCgsEvFfkqW0YlyJbWNbQ5eUhm764R+lPP1xT+sIM0J5V6
         qAN/P7K1nkuoKUdu8UDwT2vo4rVmDhKDypayQ2P4=
Subject: FAILED: patch "[PATCH] virtio-net: fix race between set queues and probe" failed to apply to 4.14-stable tree
To:     jasowang@redhat.com, kuba@kernel.org, mst@redhat.com,
        xuanzhuo@linux.alibaba.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 01 Aug 2023 07:51:53 +0200
Message-ID: <2023080152-roundish-doornail-415a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 25266128fe16d5632d43ada34c847d7b8daba539
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080152-roundish-doornail-415a@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

25266128fe16 ("virtio-net: fix race between set queues and probe")
50c0ada627f5 ("virtio-net: fix race between ndo_open() and virtio_device_ready()")
c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
0c465be183c7 ("virtio_net: ethtool tx napi configuration")
ba5e4426e80e ("virtio_net: Extend virtio to use VF datapath when available")
9805069d14c1 ("virtio_net: Introduce VIRTIO_NET_F_STANDBY feature bit")
cfc80d9a1163 ("net: Introduce net_failover driver")
f4ee703ace84 ("virtio_net: sparse annotation fix")
d7fad4c840f3 ("virtio_net: fix adding vids on big-endian")
12e571693837 ("virtio_net: split out ctrl buffer")
faa9b39f0e9d ("virtio_net: propagate linkspeed/duplex settings from the hypervisor")
754b8a21a96d ("virtio_net: setup xdp_rxq_info")
83c9e13aa39a ("netdevsim: add software driver for testing offloads")
e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
186b3c998c50 ("virtio-net: support XDP_REDIRECT")
312403453532 ("virtio-net: add packet len average only when needed during XDP")
9457642a405f ("virtio-net: remove unnecessary parameter of virtnet_xdp_xmit()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 25266128fe16d5632d43ada34c847d7b8daba539 Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jul 2023 03:20:49 -0400
Subject: [PATCH] virtio-net: fix race between set queues and probe

A race were found where set_channels could be called after registering
but before virtnet_set_queues() in virtnet_probe(). Fixing this by
moving the virtnet_set_queues() before netdevice registering. While at
it, use _virtnet_set_queues() to avoid holding rtnl as the device is
not even registered at that time.

Cc: stable@vger.kernel.org
Fixes: a220871be66f ("virtio-net: correctly enable multiqueue")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230725072049.617289-1-jasowang@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0db14f6b87d3..1270c8d23463 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4219,6 +4219,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
+	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -4257,8 +4259,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_unregister_netdev;
 	}
 
-	virtnet_set_queues(vi, vi->curr_queue_pairs);
-
 	/* Assume link up if device can't report link status,
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);

