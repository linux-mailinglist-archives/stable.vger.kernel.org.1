Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1804703651
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243448AbjEORJC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243681AbjEORIn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:08:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61747A240
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C242A62A99
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCFAC433D2;
        Mon, 15 May 2023 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170391;
        bh=B1XIV5xnnTtp6YBbKhW9sCRmRzT9DbVLlipBk2+XD7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXwD0RR+edizqy7ANXLuF7bE8aN0e9EdTwj96cjo6QCX2nKOAQEbZQvkNgX/sa8WH
         0jfbVILV0V0DxZuSO1VzbuQLm1tFy3q5a+KlF6ZFPfAwcorxRSSk6g+7ou4jdynWgt
         hefNP7ZPWOtR9SSfZ+TByYcAvewOqe/nJxN7gF80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Wenliang Wang <wangwenliang.1995@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 087/239] virtio_net: suppress cpu stall when free_unused_bufs
Date:   Mon, 15 May 2023 18:25:50 +0200
Message-Id: <20230515161724.286652919@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Wenliang Wang <wangwenliang.1995@bytedance.com>

[ Upstream commit f8bb5104394560e29017c25bcade4c6b7aabd108 ]

For multi-queue and large ring-size use case, the following error
occurred when free_unused_bufs:
rcu: INFO: rcu_sched self-detected stall on CPU.

Fixes: 986a4f4d452d ("virtio_net: multiqueue support")
Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3f1883814ce21..9a612b13b4e46 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3405,12 +3405,14 @@ static void free_unused_bufs(struct virtnet_info *vi)
 		struct virtqueue *vq = vi->sq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_sq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->rq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_rq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 }
 
-- 
2.39.2



