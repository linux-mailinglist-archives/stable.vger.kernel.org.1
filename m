Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6BC703AA3
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbjEORxo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244861AbjEORxX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:53:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD61B1D497
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E278162F2A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44B2C433D2;
        Mon, 15 May 2023 17:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173053;
        bh=nLEygKQl0REirrJB7woOk+U2N8rzSdHgK892RTHHAOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPLt6tyA58aeccJJqkLNFrG9ge4m2D/WaQzYGeQmnw7P7E8DGhL+k+IcKOX+MM4tV
         /xR6S+yCCgMsrobgw/d82HjzVasTOFGChaCxp6xPm0qHQZ1pgSmdT+8/Uc+G4GRsZB
         0NRHRzH1TnD6Q9yY2UUuEf6h7VGoWqmdWI/+cr2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 325/381] virtio_net: split free_unused_bufs()
Date:   Mon, 15 May 2023 18:29:36 +0200
Message-Id: <20230515161751.483728414@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

[ Upstream commit 6e345f8c7cd029ad3aaece15ad4425ac26e4eb63 ]

This patch separates two functions for freeing sq buf and rq buf from
free_unused_bufs().

When supporting the enable/disable tx/rq queue in the future, it is
necessary to support separate recovery of a sq buf or a rq buf.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20220801063902.129329-40-xuanzhuo@linux.alibaba.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Stable-dep-of: f8bb51043945 ("virtio_net: suppress cpu stall when free_unused_bufs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 41 ++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 47c9118cc92a3..75219c8f4a63e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2747,6 +2747,27 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 			put_page(vi->rq[i].alloc_frag.page);
 }
 
+static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
+{
+	if (!is_xdp_frame(buf))
+		dev_kfree_skb(buf);
+	else
+		xdp_return_frame(ptr_to_xdp(buf));
+}
+
+static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+	int i = vq2rxq(vq);
+
+	if (vi->mergeable_rx_bufs)
+		put_page(virt_to_head_page(buf));
+	else if (vi->big_packets)
+		give_pages(&vi->rq[i], buf);
+	else
+		put_page(virt_to_head_page(buf));
+}
+
 static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;
@@ -2754,26 +2775,14 @@ static void free_unused_bufs(struct virtnet_info *vi)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->sq[i].vq;
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
-			if (!is_xdp_frame(buf))
-				dev_kfree_skb(buf);
-			else
-				xdp_return_frame(ptr_to_xdp(buf));
-		}
+		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+			virtnet_sq_free_unused_buf(vq, buf);
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->rq[i].vq;
-
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
-			if (vi->mergeable_rx_bufs) {
-				put_page(virt_to_head_page(buf));
-			} else if (vi->big_packets) {
-				give_pages(&vi->rq[i], buf);
-			} else {
-				put_page(virt_to_head_page(buf));
-			}
-		}
+		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+			virtnet_rq_free_unused_buf(vq, buf);
 	}
 }
 
-- 
2.39.2



