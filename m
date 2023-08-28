Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006A978AC5C
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjH1Kj2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjH1KjM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2229593
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC39863F6C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDCAC433C8;
        Mon, 28 Aug 2023 10:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219149;
        bh=n2/FXkn2siPQQIOLYrPY+z0G2ombjnhj0efPOQgVq70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6AJCkLnrfzUqxOHTUaothQK3WZN/MKFBH65kXjs/eHAPeaMGXvXeo3Ynp8XKU2j/
         jqIdz+yUOLieiqxrmA3LAqQdmJvZ3Xy+EXDMdxf6Gqa/DZES6NmKVVh4hYCr8J4cLZ
         RHoK5m3LfbEevNaca3jBlkHbffWtKqqGskXY0JiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dragos Tatulea <dtatulea@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 090/158] virtio-net: set queues after driver_ok
Date:   Mon, 28 Aug 2023 12:13:07 +0200
Message-ID: <20230828101200.343026249@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

From: Jason Wang <jasowang@redhat.com>

commit 51b813176f098ff61bd2833f627f5319ead098a5 upstream.

Commit 25266128fe16 ("virtio-net: fix race between set queues and
probe") tries to fix the race between set queues and probe by calling
_virtnet_set_queues() before DRIVER_OK is set. This violates virtio
spec. Fixing this by setting queues after virtio_device_ready().

Note that rtnl needs to be held for userspace requests to change the
number of queues. So we are serialized in this way.

Fixes: 25266128fe16 ("virtio-net: fix race between set queues and probe")
Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3265,8 +3265,6 @@ static int virtnet_probe(struct virtio_d
 		}
 	}
 
-	_virtnet_set_queues(vi, vi->curr_queue_pairs);
-
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -3279,6 +3277,8 @@ static int virtnet_probe(struct virtio_d
 
 	virtio_device_ready(vdev);
 
+	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);


