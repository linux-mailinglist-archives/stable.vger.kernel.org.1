Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2056470386F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbjEORcb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbjEORcH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:32:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C587B100F3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59BC562055
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCFCC433D2;
        Mon, 15 May 2023 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171741;
        bh=6Fgw64fpYc87AhTpLHs2vEyrQdL3rfavMM6jVgfeCvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nsqHNvzk8fk5V5N/TLLDlDiyLNwwN37utzLpRKkFTiOjo50S3K8pEalQB3wfhl9e+
         2lcbGtyPmDApq9aS785IrDu6l54j5ynrp9tpfv7gEPB31JJvQ5ujWYdtInurpQqBWv
         AeOrVtQtZiizXN3mYl9E3mFY+0B6Go2zJN8DD7IE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Wenliang Wang <wangwenliang.1995@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 046/134] virtio_net: suppress cpu stall when free_unused_bufs
Date:   Mon, 15 May 2023 18:28:43 +0200
Message-Id: <20230515161704.669232348@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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
index cff3e2a7ce7fc..9f2d691908b42 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2844,12 +2844,14 @@ static void free_unused_bufs(struct virtnet_info *vi)
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



