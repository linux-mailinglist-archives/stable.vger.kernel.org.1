Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8CC76AFBF
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjHAJuB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjHAJts (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A83E7B
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 037BF614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFE8C433C8;
        Tue,  1 Aug 2023 09:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883338;
        bh=LdXZtG5CZgqqB/wE1HKwrbNeSOo/3qkYx7SX1QHBTAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUz5MBd7U0RubnxMb6KkDR5WMlxrI0GmPJKYtL9DpU8j9+EFIvOTSdXnMOC+GR8Wa
         gNCaBRQW50gfSllkfK/b0Dx81bxCpA722su87p87+KXsfSOdw/zyjuUECs22XQWBH3
         FcuaTxQDCsjSxg9E4XbD3dMNuwvJcNeTQq/J5cCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 201/239] virtio-net: fix race between set queues and probe
Date:   Tue,  1 Aug 2023 11:21:05 +0200
Message-ID: <20230801091933.037763620@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
@@ -4110,6 +4110,8 @@ static int virtnet_probe(struct virtio_d
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
+	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -4148,8 +4150,6 @@ static int virtnet_probe(struct virtio_d
 		goto free_unregister_netdev;
 	}
 
-	virtnet_set_queues(vi, vi->curr_queue_pairs);
-
 	/* Assume link up if device can't report link status,
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);


