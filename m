Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2057DD4EA
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346975AbjJaRpc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347005AbjJaRpb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:45:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E299F3
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:45:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1627C433C8;
        Tue, 31 Oct 2023 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774328;
        bh=qoXV3vJhb9V23PoIAhKdQi1cJCc63Byt/YCFUJVvM6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0PolyisCOJTZ/BGQ1pX6wht69721ea2Cu72Pogd7CYJdJsZUmxPmlBaPfCp9CS5s
         /z0BbEXpmkEY5470hcaWECQ77kwXITvjKKbF3Ds8w3XAwCYbY0/c4IfqRpy/N8eaJh
         jf7938/nHUgdZdXDSsk5G/0H9EoVCuWn+icx5iCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexandru Matei <alexandru.matei@uipath.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 013/112] vsock/virtio: initialize the_virtio_vsock before using VQs
Date:   Tue, 31 Oct 2023 18:00:14 +0100
Message-ID: <20231031165901.714757465@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandru Matei <alexandru.matei@uipath.com>

commit 53b08c4985158430fd6d035fb49443bada535210 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/virtio_transport.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -555,6 +555,11 @@ static int virtio_vsock_vqs_init(struct
 
 	virtio_device_ready(vdev);
 
+	return 0;
+}
+
+static void virtio_vsock_vqs_start(struct virtio_vsock *vsock)
+{
 	mutex_lock(&vsock->tx_lock);
 	vsock->tx_run = true;
 	mutex_unlock(&vsock->tx_lock);
@@ -569,7 +574,16 @@ static int virtio_vsock_vqs_init(struct
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
@@ -664,6 +678,7 @@ static int virtio_vsock_probe(struct vir
 		goto out;
 
 	rcu_assign_pointer(the_virtio_vsock, vsock);
+	virtio_vsock_vqs_start(vsock);
 
 	mutex_unlock(&the_virtio_vsock_mutex);
 
@@ -736,6 +751,7 @@ static int virtio_vsock_restore(struct v
 		goto out;
 
 	rcu_assign_pointer(the_virtio_vsock, vsock);
+	virtio_vsock_vqs_start(vsock);
 
 out:
 	mutex_unlock(&the_virtio_vsock_mutex);


