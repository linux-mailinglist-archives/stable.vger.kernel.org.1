Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115A2775C1D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjHILYC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjHILYB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:24:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D451BF7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA3C36323D
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8625C433C8;
        Wed,  9 Aug 2023 11:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580240;
        bh=6fMmdnFMHW5YyS4kIZagbjZ1uqkSkifd2MOgy1vbNoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OS9RqfnCRR3GJFkf4FN+yBqmAoS97YaKVmfDr3w3PDrtTEXzHSAX/mBEE6gIaf9M2
         iVJeouCKwM40uOLl/ELkzOu4dqXoMg+GIb5G57viO6w0UKy/zKdL1sOAW2YP0hya69
         MKHWYz/ldQAJn38tPYX8CXnwO+PtndCc79M1mCIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 278/323] virtio-net: fix race between set queues and probe
Date:   Wed,  9 Aug 2023 12:41:56 +0200
Message-ID: <20230809103710.770240593@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>

commit 25266128fe16d5632d43ada34c847d7b8daba539 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3120,6 +3120,8 @@ static int virtnet_probe(struct virtio_d
 		}
 	}
 
+	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -3140,8 +3142,6 @@ static int virtnet_probe(struct virtio_d
 		goto free_unregister_netdev;
 	}
 
-	virtnet_set_queues(vi, vi->curr_queue_pairs);
-
 	/* Assume link up if device can't report link status,
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);


