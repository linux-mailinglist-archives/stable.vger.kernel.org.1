Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA81270C67C
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjEVTSf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjEVTSd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CBCB0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD898627D8
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB93C433EF;
        Mon, 22 May 2023 19:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783111;
        bh=GjCxkd5fF7t1j2BmlcofA0husn8aK46X5DsisXX7BSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wtAIVNAUAxMzMl437KaQJdFFTiOD3ArTczSm3/GSaQ05QvWAhOEXef+E8LwMkTEUE
         UA64MuOvNR7E3B44RhpkjsJH8RKH8/oW8Icu2uL78Oqw6ls/vOZYajnxIp2foDdzxA
         LwMMxUXMs+i7eLX3IMwg+ATF+KHkykB3IwO3n11o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
        Jiri Pirko <jiri@nvidia.com>, Parav Pandit <parav@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 142/203] virtio-net: Maintain reverse cleanup order
Date:   Mon, 22 May 2023 20:09:26 +0100
Message-Id: <20230522190358.897544234@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 9f2d691908b42..cdd28a11f5191 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1999,9 +1999,9 @@ static int virtnet_close(struct net_device *dev)
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



