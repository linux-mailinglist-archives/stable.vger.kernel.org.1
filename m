Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21147D974F
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 14:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbjJ0MJy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 08:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345689AbjJ0MJx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 08:09:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7618C0
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 05:09:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC67C433C8;
        Fri, 27 Oct 2023 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698408590;
        bh=RJLYf4dOx1vln4OR1BEEcq+W2FG93MlP3PE8SPNTNcI=;
        h=Subject:To:Cc:From:Date:From;
        b=dX+jXkSQWY1HQTsmkILPXZO3wg0+OJ93U+BCdSxw2T8pDHvJvjGGm6FnZg9m6t6zb
         ztAIhpxtAclbBypsy3jyEnptErbhm9NuOTA1MxGlgCZ6P9CQXZHjNp4tbIcDYmEGNX
         jYJDsd5RjXDjhKmM6yfl+Xg2zW+fyr/OEM4JFeGs=
Subject: FAILED: patch "[PATCH] vsock/virtio: initialize the_virtio_vsock before using VQs" failed to apply to 5.4-stable tree
To:     alexandru.matei@uipath.com, kuba@kernel.org, sgarzare@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 27 Oct 2023 14:09:39 +0200
Message-ID: <2023102739-channel-upstream-7bca@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 53b08c4985158430fd6d035fb49443bada535210
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102739-channel-upstream-7bca@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 53b08c4985158430fd6d035fb49443bada535210 Mon Sep 17 00:00:00 2001
From: Alexandru Matei <alexandru.matei@uipath.com>
Date: Tue, 24 Oct 2023 22:17:42 +0300
Subject: [PATCH] vsock/virtio: initialize the_virtio_vsock before using VQs

Once VQs are filled with empty buffers and we kick the host, it can send
connection requests. If the_virtio_vsock is not initialized before,
replies are silently dropped and do not reach the host.

virtio_transport_send_pkt() can queue packets once the_virtio_vsock is
set, but they won't be processed until vsock->tx_run is set to true. We
queue vsock->send_pkt_work when initialization finishes to send those
packets queued earlier.

Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/20231024191742.14259-1-alexandru.matei@uipath.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index e95df847176b..b80bf681327b 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -555,6 +555,11 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 
 	virtio_device_ready(vdev);
 
+	return 0;
+}
+
+static void virtio_vsock_vqs_start(struct virtio_vsock *vsock)
+{
 	mutex_lock(&vsock->tx_lock);
 	vsock->tx_run = true;
 	mutex_unlock(&vsock->tx_lock);
@@ -569,7 +574,16 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 	vsock->event_run = true;
 	mutex_unlock(&vsock->event_lock);
 
-	return 0;
+	/* virtio_transport_send_pkt() can queue packets once
+	 * the_virtio_vsock is set, but they won't be processed until
+	 * vsock->tx_run is set to true. We queue vsock->send_pkt_work
+	 * when initialization finishes to send those packets queued
+	 * earlier.
+	 * We don't need to queue the other workers (rx, event) because
+	 * as long as we don't fill the queues with empty buffers, the
+	 * host can't send us any notification.
+	 */
+	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
 }
 
 static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
@@ -664,6 +678,7 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 		goto out;
 
 	rcu_assign_pointer(the_virtio_vsock, vsock);
+	virtio_vsock_vqs_start(vsock);
 
 	mutex_unlock(&the_virtio_vsock_mutex);
 
@@ -736,6 +751,7 @@ static int virtio_vsock_restore(struct virtio_device *vdev)
 		goto out;
 
 	rcu_assign_pointer(the_virtio_vsock, vsock);
+	virtio_vsock_vqs_start(vsock);
 
 out:
 	mutex_unlock(&the_virtio_vsock_mutex);

