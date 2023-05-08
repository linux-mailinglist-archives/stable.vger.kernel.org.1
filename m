Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252216FA5BF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjEHKMz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjEHKMn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E333A2B5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE6EE62368
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6E7C433D2;
        Mon,  8 May 2023 10:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540758;
        bh=ieUEw2QYJM2wuY4Rw1mMT0nCMkTVA4UGTsdpmV9aQGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u5miFFOTP7Njkk6GWNYzPrivYM0lXNStNJyB0B8s7FI8eTNVMyjniCbXlbdwzFusH
         njDAQ6LzOuOP531kWUsatqk8ys/lkJVZ7cV2RNg4LUFqI8jW+zZk55vBu92wOK7RSt
         RvahSUDomvEm+RUNRUrt3kAwHD6ouWcxYaQb6xwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Albert Huang <huangjie.albert@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 454/611] virtio_ring: dont update event idx on get_buf
Date:   Mon,  8 May 2023 11:44:56 +0200
Message-Id: <20230508094436.910775778@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Albert Huang <huangjie.albert@bytedance.com>

[ Upstream commit 6c0b057cec5eade4c3afec3908821176931a9997 ]

In virtio_net, if we disable napi_tx, when we trigger a tx interrupt,
the vq->event_triggered will be set to true. It is then never reset
until we explicitly call virtqueue_enable_cb_delayed or
virtqueue_enable_cb_prepare.

If we disable the napi_tx, virtqueue_enable_cb* will only be called when
the tx ring is getting relatively empty.

Since event_triggered is true, VRING_AVAIL_F_NO_INTERRUPT or
VRING_PACKED_EVENT_FLAG_DISABLE will not be set. As a result we update
vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
every time we call virtqueue_get_buf_ctx. This causes more interrupts.

To summarize:
1) event_triggered was set to true in vring_interrupt()
2) after this nothing will happen in virtqueue_disable_cb() so
   VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
   and then it will publish a new event index

To fix:
update VRING_AVAIL_F_NO_INTERRUPT or VRING_PACKED_EVENT_FLAG_DISABLE in
the vq when we call virtqueue_disable_cb even when event_triggered is
true.

Tested with iperf:
iperf3 tcp stream:
vm1 -----------------> vm2
vm2 just receives tcp data stream from vm1, and sends acks to vm1,
there are many tx interrupts in vm2.
with the patch applied there are just a few tx interrupts.

v2->v3:
-update the interrupt disable flag even with the event_triggered is set,
-instead of checking whether event_triggered is set in
-virtqueue_get_buf_ctx_{packed/split}, will cause the drivers  which have
-not called virtqueue_{enable/disable}_cb to miss notifications.

v3->v4:
-remove change for
-"if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE)"
-in virtqueue_disable_cb_packed

Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20230329102300.61000-1-huangjie.albert@bytedance.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_ring.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2e7689bb933b8..90d514c141794 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -848,6 +848,14 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 
 	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
 		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
+
+		/*
+		 * If device triggered an event already it won't trigger one again:
+		 * no need to disable.
+		 */
+		if (vq->event_triggered)
+			return;
+
 		if (vq->event)
 			/* TODO: this is a hack. Figure out a cleaner value to write. */
 			vring_used_event(&vq->split.vring) = 0x0;
@@ -1687,6 +1695,14 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
 
 	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
 		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
+
+		/*
+		 * If device triggered an event already it won't trigger one again:
+		 * no need to disable.
+		 */
+		if (vq->event_triggered)
+			return;
+
 		vq->packed.vring.driver->flags =
 			cpu_to_le16(vq->packed.event_flags_shadow);
 	}
@@ -2309,12 +2325,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	/* If device triggered an event already it won't trigger one again:
-	 * no need to disable.
-	 */
-	if (vq->event_triggered)
-		return;
-
 	if (vq->packed_ring)
 		virtqueue_disable_cb_packed(_vq);
 	else
-- 
2.39.2



