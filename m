Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419FC7ECDBB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjKOTiF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjKOTiE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC789E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:38:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74DCC433CA;
        Wed, 15 Nov 2023 19:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077081;
        bh=EXifiSZNtICbUqTh1YWnjsyN8ND3Zbu3NCQn76ehdTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQArH6qWUDlmOxvH59vqycaqTLaOBzy9DFI7f5qWd54oL646YtjbPXv7VUk2dQsKo
         BWGY5ocIuXtlaZY8DiCGh7pC2PrkFBQhYj/0dNcNateYn+pCdr/1Dp3yNb+ow/Dv8v
         JyyQtGU+7LIGXGGWpZQXioBtv/P2hSq2Sifef5a4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gavin Li <gavinl@nvidia.com>,
        Heng Qi <hengqi@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 118/603] virtio-net: consistently save parameters for per-queue
Date:   Wed, 15 Nov 2023 14:11:03 -0500
Message-ID: <20231115191621.406475835@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heng Qi <hengqi@linux.alibaba.com>

[ Upstream commit e9420838ab4ffb82850095549e94dcee3f7fe0cb ]

When using .set_coalesce interface to set all queue coalescing
parameters, we need to update both per-queue and global save values.

Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce command")
Cc: Gavin Li <gavinl@nvidia.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b218c2bafddcc..d3b976a591c84 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3233,6 +3233,7 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 				       struct ethtool_coalesce *ec)
 {
 	struct scatterlist sgs_tx, sgs_rx;
+	int i;
 
 	vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
 	vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
@@ -3246,6 +3247,10 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 	/* Save parameters */
 	vi->intr_coal_tx.max_usecs = ec->tx_coalesce_usecs;
 	vi->intr_coal_tx.max_packets = ec->tx_max_coalesced_frames;
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		vi->sq[i].intr_coal.max_usecs = ec->tx_coalesce_usecs;
+		vi->sq[i].intr_coal.max_packets = ec->tx_max_coalesced_frames;
+	}
 
 	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
 	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
@@ -3259,6 +3264,10 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 	/* Save parameters */
 	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
 	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
+		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
+	}
 
 	return 0;
 }
-- 
2.42.0



