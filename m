Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7F570C67D
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjEVTSi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjEVTSg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DE9CA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6236627EA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC0EC433D2;
        Mon, 22 May 2023 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783114;
        bh=bEiS2qLGDzdX9AOr+spXQHAaeXTqY21b27bkUVmwYrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gFugB6Zso7WuU16GBFqkEmg/0sxzt5Vb3H7Rt/4hjzVBFBveZ6HeeZA8Gd8hesPpF
         zQDYYiQa2Vov+k9FTHqDlKpQXU56UVXFenNPsxmMxzxLQsRfQ20gbdya/PHwgNn8On
         j0JRj9uuYzEjw3LBKk5CkWV1/vc8wijBMb7Jky4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Feng Liu <feliu@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, William Tu <witu@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 143/203] virtio_net: Fix error unwinding of XDP initialization
Date:   Mon, 22 May 2023 20:09:27 +0100
Message-Id: <20230522190358.924640411@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Feng Liu <feliu@nvidia.com>

[ Upstream commit 5306623a9826aa7d63b32c6a3803c798a765474d ]

When initializing XDP in virtnet_open(), some rq xdp initialization
may hit an error causing net device open failed. However, previous
rqs have already initialized XDP and enabled NAPI, which is not the
expected behavior. Need to roll back the previous rq initialization
to avoid leaks in error unwinding of init code.

Also extract helper functions of disable and enable queue pairs.
Use newly introduced disable helper function in error unwinding and
virtnet_close. Use enable helper function in virtnet_open.

Fixes: 754b8a21a96d ("virtio_net: setup xdp_rxq_info")
Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 61 +++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cdd28a11f5191..0351f86494f16 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1604,6 +1604,38 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	return received;
 }
 
+static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
+{
+	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
+	napi_disable(&vi->rq[qp_index].napi);
+	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
+}
+
+static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
+{
+	struct net_device *dev = vi->dev;
+	int err;
+
+	err = xdp_rxq_info_reg(&vi->rq[qp_index].xdp_rxq, dev, qp_index,
+			       vi->rq[qp_index].napi.napi_id);
+	if (err < 0)
+		return err;
+
+	err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
+					 MEM_TYPE_PAGE_SHARED, NULL);
+	if (err < 0)
+		goto err_xdp_reg_mem_model;
+
+	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
+	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
+
+	return 0;
+
+err_xdp_reg_mem_model:
+	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
+	return err;
+}
+
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -1617,22 +1649,20 @@ static int virtnet_open(struct net_device *dev)
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
 				schedule_delayed_work(&vi->refill, 0);
 
-		err = xdp_rxq_info_reg(&vi->rq[i].xdp_rxq, dev, i, vi->rq[i].napi.napi_id);
+		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
-			return err;
-
-		err = xdp_rxq_info_reg_mem_model(&vi->rq[i].xdp_rxq,
-						 MEM_TYPE_PAGE_SHARED, NULL);
-		if (err < 0) {
-			xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
-			return err;
-		}
-
-		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
-		virtnet_napi_tx_enable(vi, vi->sq[i].vq, &vi->sq[i].napi);
+			goto err_enable_qp;
 	}
 
 	return 0;
+
+err_enable_qp:
+	disable_delayed_refill(vi);
+	cancel_delayed_work_sync(&vi->refill);
+
+	for (i--; i >= 0; i--)
+		virtnet_disable_queue_pair(vi, i);
+	return err;
 }
 
 static int virtnet_poll_tx(struct napi_struct *napi, int budget)
@@ -1998,11 +2028,8 @@ static int virtnet_close(struct net_device *dev)
 	/* Make sure refill_work doesn't re-enable napi! */
 	cancel_delayed_work_sync(&vi->refill);
 
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		virtnet_napi_tx_disable(&vi->sq[i].napi);
-		napi_disable(&vi->rq[i].napi);
-		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
-	}
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		virtnet_disable_queue_pair(vi, i);
 
 	return 0;
 }
-- 
2.39.2



