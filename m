Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BDC7ECDB9
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjKOTiC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjKOTiB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C0A1A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:37:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED7BC433C9;
        Wed, 15 Nov 2023 19:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077077;
        bh=pTu4SxXQ7+i9h9yCRw8i7okjr/WwrqR/wspSWk9yI0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjazhqTCh7riqAOQZFs6B3A4s9SH49TxnChA5IMI92D4nHMd48GclwlkPoAkcuGAx
         zY55V73cZ6uM1Q/w4ahFrdXFWzqFmjoeCp/jIKADBaP8d6XU7tWBhsyei5nW7hsFk0
         +QV9MXR7ZCkiETyuHT/E52G7R4Ffec4u2lz4JWIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gavin Li <gavinl@nvidia.com>,
        Heng Qi <hengqi@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 117/603] virtio-net: fix mismatch of getting tx-frames
Date:   Wed, 15 Nov 2023 14:11:02 -0500
Message-ID: <20231115191621.341053202@linuxfoundation.org>
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

[ Upstream commit 134674c1877be5e35e35802517c67a9ecce21153 ]

Since virtio-net allows switching napi_tx for per txq, we have to
get the specific txq's result now.

Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce command")
Cc: Gavin Li <gavinl@nvidia.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d67f742fbd4c5..b218c2bafddcc 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3453,7 +3453,7 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
-		if (vi->sq[0].napi.weight)
+		if (vi->sq[queue].napi.weight)
 			ec->tx_max_coalesced_frames = 1;
 	}
 
-- 
2.42.0



