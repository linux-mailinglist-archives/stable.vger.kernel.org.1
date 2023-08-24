Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B54787288
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbjHXOyj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241894AbjHXOy1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BCE19B3
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5337066F12
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686B9C433C8;
        Thu, 24 Aug 2023 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888862;
        bh=w6Uep2PxyRoMuCEcdxXDauQzEWqusgBp5Ydl+tNOKfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krsgdj0q+uPWFI8duISnUStcgAuulmDijwRz+ouUBAVzCqPFP5dq5faqL2JBI2hPH
         OqMuvZCN9tUP5HPHj3UmSbNJBtQI/UxIVUhLj/WPdr6tNjza/R2sdu53tZ4SknJnfU
         ElsudpVBdaeKxsFDgDcvjmgyZH3/S79KHM2iHtPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, xieyongji@bytedance.com,
        Jason Wang <jasowang@redhat.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 068/139] vduse: Use proper spinlock for IRQ injection
Date:   Thu, 24 Aug 2023 16:49:51 +0200
Message-ID: <20230824145026.620397511@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Maxime Coquelin <maxime.coquelin@redhat.com>

[ Upstream commit 7ca26efb09a1543fddb29308ea3b63b66cb5d3ee ]

The IRQ injection work used spin_lock_irq() to protect the
scheduling of the softirq, but spin_lock_bh() should be
used.

With spin_lock_irq(), we noticed delay of more than 6
seconds between the time a NAPI polling work is scheduled
and the time it is executed.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Cc: xieyongji@bytedance.com

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-Id: <20230705114505.63274-1-maxime.coquelin@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 30ae4237f3dd4..564864f039d20 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -879,10 +879,10 @@ static void vduse_dev_irq_inject(struct work_struct *work)
 {
 	struct vduse_dev *dev = container_of(work, struct vduse_dev, inject);
 
-	spin_lock_irq(&dev->irq_lock);
+	spin_lock_bh(&dev->irq_lock);
 	if (dev->config_cb.callback)
 		dev->config_cb.callback(dev->config_cb.private);
-	spin_unlock_irq(&dev->irq_lock);
+	spin_unlock_bh(&dev->irq_lock);
 }
 
 static void vduse_vq_irq_inject(struct work_struct *work)
@@ -890,10 +890,10 @@ static void vduse_vq_irq_inject(struct work_struct *work)
 	struct vduse_virtqueue *vq = container_of(work,
 					struct vduse_virtqueue, inject);
 
-	spin_lock_irq(&vq->irq_lock);
+	spin_lock_bh(&vq->irq_lock);
 	if (vq->ready && vq->cb.callback)
 		vq->cb.callback(vq->cb.private);
-	spin_unlock_irq(&vq->irq_lock);
+	spin_unlock_bh(&vq->irq_lock);
 }
 
 static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
-- 
2.40.1



