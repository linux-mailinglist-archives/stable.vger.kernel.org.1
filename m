Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1AF7E24A7
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjKFNX6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjKFNX5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:23:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD95D8
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:23:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1421C433C8;
        Mon,  6 Nov 2023 13:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277034;
        bh=iH3+BbNT8KUwU3ViKxuH6b8tGjZ1ltkDJ6wqUD5xQPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTuqFeD2K24eP7cK8RJch3QjBbtg9o+ze8RdIvGpHp/c/YMCF0N4R14KlB43v3SpK
         4u40vUg0ppFUFVwV49TuCjudjemoA+S+Jtt+NDZZMfDke4CYF9mIyvy+VIbqOvlozn
         Xr9Z2z3+Z5dYYNh9GHhBKx+9by+Wywk1b8M9q+Ds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 016/128] vsock/virtio: factor our the code to initialize and delete VQs
Date:   Mon,  6 Nov 2023 14:02:56 +0100
Message-ID: <20231106130309.857174143@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit a103209886264a3289f7e53e7ed389d0391fb23f ]

Add virtio_vsock_vqs_init() and virtio_vsock_vqs_del() with the code
that was in virtio_vsock_probe() and virtio_vsock_remove to initialize
and delete VQs.

These new functions will be used in the next commit to support device
suspend/resume

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 53b08c498515 ("vsock/virtio: initialize the_virtio_vsock before using VQs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport.c | 150 +++++++++++++++++--------------
 1 file changed, 84 insertions(+), 66 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index c5f936fbf876d..e4773ae6a54d6 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -566,67 +566,28 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	mutex_unlock(&vsock->rx_lock);
 }
 
-static int virtio_vsock_probe(struct virtio_device *vdev)
+static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 {
-	vq_callback_t *callbacks[] = {
-		virtio_vsock_rx_done,
-		virtio_vsock_tx_done,
-		virtio_vsock_event_done,
-	};
+	struct virtio_device *vdev = vsock->vdev;
 	static const char * const names[] = {
 		"rx",
 		"tx",
 		"event",
 	};
-	struct virtio_vsock *vsock = NULL;
+	vq_callback_t *callbacks[] = {
+		virtio_vsock_rx_done,
+		virtio_vsock_tx_done,
+		virtio_vsock_event_done,
+	};
 	int ret;
 
-	ret = mutex_lock_interruptible(&the_virtio_vsock_mutex);
-	if (ret)
-		return ret;
-
-	/* Only one virtio-vsock device per guest is supported */
-	if (rcu_dereference_protected(the_virtio_vsock,
-				lockdep_is_held(&the_virtio_vsock_mutex))) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	vsock = kzalloc(sizeof(*vsock), GFP_KERNEL);
-	if (!vsock) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	vsock->vdev = vdev;
-
-	ret = virtio_find_vqs(vsock->vdev, VSOCK_VQ_MAX,
-			      vsock->vqs, callbacks, names,
+	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, callbacks, names,
 			      NULL);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	virtio_vsock_update_guest_cid(vsock);
 
-	vsock->rx_buf_nr = 0;
-	vsock->rx_buf_max_nr = 0;
-	atomic_set(&vsock->queued_replies, 0);
-
-	mutex_init(&vsock->tx_lock);
-	mutex_init(&vsock->rx_lock);
-	mutex_init(&vsock->event_lock);
-	spin_lock_init(&vsock->send_pkt_list_lock);
-	INIT_LIST_HEAD(&vsock->send_pkt_list);
-	INIT_WORK(&vsock->rx_work, virtio_transport_rx_work);
-	INIT_WORK(&vsock->tx_work, virtio_transport_tx_work);
-	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
-	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
-
-	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
-		vsock->seqpacket_allow = true;
-
-	vdev->priv = vsock;
-
 	virtio_device_ready(vdev);
 
 	mutex_lock(&vsock->tx_lock);
@@ -643,30 +604,15 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	vsock->event_run = true;
 	mutex_unlock(&vsock->event_lock);
 
-	rcu_assign_pointer(the_virtio_vsock, vsock);
-
-	mutex_unlock(&the_virtio_vsock_mutex);
-
 	return 0;
-
-out:
-	kfree(vsock);
-	mutex_unlock(&the_virtio_vsock_mutex);
-	return ret;
 }
 
-static void virtio_vsock_remove(struct virtio_device *vdev)
+static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
 {
-	struct virtio_vsock *vsock = vdev->priv;
+	struct virtio_device *vdev = vsock->vdev;
 	struct virtio_vsock_pkt *pkt;
 
-	mutex_lock(&the_virtio_vsock_mutex);
-
-	vdev->priv = NULL;
-	rcu_assign_pointer(the_virtio_vsock, NULL);
-	synchronize_rcu();
-
-	/* Reset all connected sockets when the device disappear */
+	/* Reset all connected sockets when the VQs disappear */
 	vsock_for_each_connected_socket(&virtio_transport.transport,
 					virtio_vsock_reset_sock);
 
@@ -711,6 +657,78 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 
 	/* Delete virtqueues and flush outstanding callbacks if any */
 	vdev->config->del_vqs(vdev);
+}
+
+static int virtio_vsock_probe(struct virtio_device *vdev)
+{
+	struct virtio_vsock *vsock = NULL;
+	int ret;
+
+	ret = mutex_lock_interruptible(&the_virtio_vsock_mutex);
+	if (ret)
+		return ret;
+
+	/* Only one virtio-vsock device per guest is supported */
+	if (rcu_dereference_protected(the_virtio_vsock,
+				lockdep_is_held(&the_virtio_vsock_mutex))) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	vsock = kzalloc(sizeof(*vsock), GFP_KERNEL);
+	if (!vsock) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	vsock->vdev = vdev;
+
+	vsock->rx_buf_nr = 0;
+	vsock->rx_buf_max_nr = 0;
+	atomic_set(&vsock->queued_replies, 0);
+
+	mutex_init(&vsock->tx_lock);
+	mutex_init(&vsock->rx_lock);
+	mutex_init(&vsock->event_lock);
+	spin_lock_init(&vsock->send_pkt_list_lock);
+	INIT_LIST_HEAD(&vsock->send_pkt_list);
+	INIT_WORK(&vsock->rx_work, virtio_transport_rx_work);
+	INIT_WORK(&vsock->tx_work, virtio_transport_tx_work);
+	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
+	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
+
+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
+		vsock->seqpacket_allow = true;
+
+	vdev->priv = vsock;
+
+	ret = virtio_vsock_vqs_init(vsock);
+	if (ret < 0)
+		goto out;
+
+	rcu_assign_pointer(the_virtio_vsock, vsock);
+
+	mutex_unlock(&the_virtio_vsock_mutex);
+
+	return 0;
+
+out:
+	kfree(vsock);
+	mutex_unlock(&the_virtio_vsock_mutex);
+	return ret;
+}
+
+static void virtio_vsock_remove(struct virtio_device *vdev)
+{
+	struct virtio_vsock *vsock = vdev->priv;
+
+	mutex_lock(&the_virtio_vsock_mutex);
+
+	vdev->priv = NULL;
+	rcu_assign_pointer(the_virtio_vsock, NULL);
+	synchronize_rcu();
+
+	virtio_vsock_vqs_del(vsock);
 
 	/* Other works can be queued before 'config->del_vqs()', so we flush
 	 * all works before to free the vsock object to avoid use after free.
-- 
2.42.0



