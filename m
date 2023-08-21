Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925EE7831CB
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHUT5V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjHUT5V (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:57:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F9ED3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E7F364659
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE15C433C7;
        Mon, 21 Aug 2023 19:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647839;
        bh=QZHtQzG5N9ZAWZJO9WZWG6oYF4ylwsYrCsCkGHCpSQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDTN1voo4I07jQUy0phRLbX29f+mqKHtzQEhoe728fXIE4nEKKO5IEpddO75O8Obn
         oebDbn7qsyk47L4u+o3DVo//KQGCoyVwpwXavLrtK5F9548CUzrSMYQGkYrHWUbreD
         573OvUPY5E1p+i2GaDaA7JMiSfW8k1oAvHniYhgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Melnychenko <andrew@daynix.com>,
        Hawkins Jiawei <yin31149@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH 6.1 155/194] virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG case
Date:   Mon, 21 Aug 2023 21:42:14 +0200
Message-ID: <20230821194129.513901395@linuxfoundation.org>
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

From: Hawkins Jiawei <yin31149@gmail.com>

commit 2c507ce90e02cd78d00fd4b0fe26c8641873c13f upstream.

Kernel uses `struct virtio_net_ctrl_rss` to save command-specific-data
for both the VIRTIO_NET_CTRL_MQ_HASH_CONFIG and
VIRTIO_NET_CTRL_MQ_RSS_CONFIG commands.

According to the VirtIO standard, "Field reserved MUST contain zeroes.
It is defined to make the structure to match the layout of
virtio_net_rss_config structure, defined in 5.1.6.5.7.".

Yet for the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command case, the `max_tx_vq`
field in struct virtio_net_ctrl_rss, which corresponds to the
`reserved` field in struct virtio_net_hash_config, is not zeroed,
thereby violating the VirtIO standard.

This patch solves this problem by zeroing this field in
virtnet_init_default_rss().

Cc: Andrew Melnychenko <andrew@daynix.com>
Cc: stable@vger.kernel.org
Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20230810110405.25558-1-yin31149@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2504,7 +2504,7 @@ static void virtnet_init_default_rss(str
 		vi->ctrl->rss.indirection_table[i] = indir_val;
 	}
 
-	vi->ctrl->rss.max_tx_vq = vi->curr_queue_pairs;
+	vi->ctrl->rss.max_tx_vq = vi->has_rss ? vi->curr_queue_pairs : 0;
 	vi->ctrl->rss.hash_key_length = vi->rss_key_size;
 
 	netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);


