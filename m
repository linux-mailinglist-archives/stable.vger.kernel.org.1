Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E490E70C796
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbjEVTb1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbjEVTb1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:31:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373D3CF
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:31:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C85A56291B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05BEC433D2;
        Mon, 22 May 2023 19:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783885;
        bh=IFEBrqkFNligTSRN5SBcEC4iTPYK4F2E1QmG7PX9BQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tX2xY8DPIekQDziiyZSBwvwn9cbgtp8Jr1Gj0V4THxgS8p+9LRMLVXtIzpDXBBt/o
         FtdtlvUPG83+fdX80x7nhOcVHkc02lUVrK+szFV/oAxV73RA2rnX+4tyz0uDBZmkNr
         mRbsdinHt8NHaBKwzoHNvnM+adwYNqMFQfC1WyW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
        Jiri Pirko <jiri@nvidia.com>, Parav Pandit <parav@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 193/292] virtio-net: Maintain reverse cleanup order
Date:   Mon, 22 May 2023 20:09:10 +0100
Message-Id: <20230522190410.783432356@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Parav Pandit <parav@nvidia.com>

[ Upstream commit 27369c9c2b722617063d6b80c758ab153f1d95d4 ]

To easily audit the code, better to keep the device stop()
sequence to be mirror of the device open() sequence.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 5306623a9826 ("virtio_net: Fix error unwinding of XDP initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9a612b13b4e46..08a23ba3d68a2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2158,9 +2158,9 @@ static int virtnet_close(struct net_device *dev)
 	cancel_delayed_work_sync(&vi->refill);
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
+		virtnet_napi_tx_disable(&vi->sq[i].napi);
 		napi_disable(&vi->rq[i].napi);
 		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
-		virtnet_napi_tx_disable(&vi->sq[i].napi);
 	}
 
 	return 0;
-- 
2.39.2



