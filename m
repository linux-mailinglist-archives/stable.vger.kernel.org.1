Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB91272C11A
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbjFLK4Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbjFLK4L (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:56:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244AB5262
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A390261BD9
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB57C433EF;
        Mon, 12 Jun 2023 10:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566621;
        bh=w/eDSo4yjdp+bz1ucfE9I8Lp7Y7KeJEgSWjKkl15tmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FuScsNZq4FtqJ+4HqntY1MIMo2tDU95W3piBa0ns5lKC6ukcu7OVVju3HCNDpXih3
         zTCUIX/Zq9euEH30/MpzthOIdf8iY2xP+aJEmHbVhRjpyxnyLbh0dxOVqWsNsc8vtm
         GxaU6J0eA3ZEKLPZ0WeBxKiPRs1oghenNZrNdtR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shannon Nelson <shannon.nelson@amd.com>,
        Allen Hubbe <allen.hubbe@amd.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 094/132] virtio_net: use control_buf for coalesce params
Date:   Mon, 12 Jun 2023 12:27:08 +0200
Message-ID: <20230612101714.509307698@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Brett Creeley <brett.creeley@amd.com>

commit accc1bf23068c1cdc4c2b015320ba856e210dd98 upstream.

Commit 699b045a8e43 ("net: virtio_net: notifications coalescing
support") added coalescing command support for virtio_net. However,
the coalesce commands are using buffers on the stack, which is causing
the device to see DMA errors. There should also be a complaint from
check_for_stack() in debug_dma_map_xyz(). Fix this by adding and using
coalesce params from the control_buf struct, which aligns with other
commands.

Cc: stable@vger.kernel.org
Fixes: 699b045a8e43 ("net: virtio_net: notifications coalescing support")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/r/20230605195925.51625-1-brett.creeley@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -200,6 +200,8 @@ struct control_buf {
 	__virtio16 vid;
 	__virtio64 offloads;
 	struct virtio_net_ctrl_rss rss;
+	struct virtio_net_ctrl_coal_tx coal_tx;
+	struct virtio_net_ctrl_coal_rx coal_rx;
 };
 
 struct virtnet_info {
@@ -2786,12 +2788,10 @@ static int virtnet_send_notf_coal_cmds(s
 				       struct ethtool_coalesce *ec)
 {
 	struct scatterlist sgs_tx, sgs_rx;
-	struct virtio_net_ctrl_coal_tx coal_tx;
-	struct virtio_net_ctrl_coal_rx coal_rx;
 
-	coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
-	coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
-	sg_init_one(&sgs_tx, &coal_tx, sizeof(coal_tx));
+	vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
+	vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
+	sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
@@ -2802,9 +2802,9 @@ static int virtnet_send_notf_coal_cmds(s
 	vi->tx_usecs = ec->tx_coalesce_usecs;
 	vi->tx_max_packets = ec->tx_max_coalesced_frames;
 
-	coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
-	coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
-	sg_init_one(&sgs_rx, &coal_rx, sizeof(coal_rx));
+	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
+	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
+	sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,


