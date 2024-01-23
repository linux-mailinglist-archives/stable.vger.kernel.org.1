Return-Path: <stable+bounces-14974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FA4838366
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99821C2298C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934D62807;
	Tue, 23 Jan 2024 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zjaz4Fxe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAC22060;
	Tue, 23 Jan 2024 01:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974959; cv=none; b=VsYsKTR2CWgUQDNkwvDsxWG1Dmlpj8GTLM8oHiDgKa/6rkURM4O77pFkVZDIkJ/HnnwYJyA/iB09ucpGtZrw+54g2HDRiLIDMXmjZJ/VTePLw+YYWeMWMDpwUVZHwX8KvgrrucvMLZ5Eu+61H0gseogS9U7ksFsTxgmucZl9N7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974959; c=relaxed/simple;
	bh=0QvkoIh/yJdNIk/VsVmn93hMKhpR/uKqYcA8Z2qgD0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEWxVaVm7fVVjxi74ZUHkdRZYFJOqaD/eFrwdBzJe6RCPB6kXxy+VDeN9UOcRPGIghalRxt7YZEcJCLPomvtsXUX2fGuvBFI5I74TZCo5yLKGEbDPouocvWoDuuDfuwU0iNhZgq4BCFeKXY+rAyCkbP2Oh8ZjT+GblLdv98ZCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zjaz4Fxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65438C433F1;
	Tue, 23 Jan 2024 01:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974959;
	bh=0QvkoIh/yJdNIk/VsVmn93hMKhpR/uKqYcA8Z2qgD0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zjaz4Fxeaq63nM1MxuFj23rll6lDXFeFSzPcOO11lAvOFtlHRLbgHyCm0j1kc2epq
	 XUs0qg1tjeBCjhLNNo99nLY+K4IpVtD+2SKZCrKc7x0g4RQTT84ofipuhioj9q6dLY
	 u15M+HRp1Y+LOOQcjBnBlJW5KBAtv7l2k/j4KYso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 169/583] virtio/vsock: send credit update during setting SO_RCVLOWAT
Date: Mon, 22 Jan 2024 15:53:40 -0800
Message-ID: <20240122235817.205971076@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arseniy Krasnov <avkrasnov@salutedevices.com>

[ Upstream commit 0fe1798968115488c0c02f4633032a015b1faf97 ]

Send credit update message when SO_RCVLOWAT is updated and it is bigger
than number of bytes in rx queue. It is needed, because 'poll()' will
wait until number of bytes in rx queue will be not smaller than
O_RCVLOWAT, so kick sender to send more data. Otherwise mutual hungup
for tx/rx is possible: sender waits for free space and receiver is
waiting data in 'poll()'.

Rename 'set_rcvlowat' callback to 'notify_set_rcvlowat' and set
'sk->sk_rcvlowat' only in one place (i.e. 'vsock_set_rcvlowat'), so the
transport doesn't need to do it.

Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vsock.c                   |  1 +
 include/linux/virtio_vsock.h            |  1 +
 include/net/af_vsock.h                  |  2 +-
 net/vmw_vsock/af_vsock.c                |  9 ++++++--
 net/vmw_vsock/hyperv_transport.c        |  4 ++--
 net/vmw_vsock/virtio_transport.c        |  1 +
 net/vmw_vsock/virtio_transport_common.c | 30 +++++++++++++++++++++++++
 net/vmw_vsock/vsock_loopback.c          |  1 +
 8 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 817d377a3f36..61255855d490 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -438,6 +438,7 @@ static struct virtio_transport vhost_transport = {
 		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
 		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
 
 		.read_skb = virtio_transport_read_skb,
 	},
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index c58453699ee9..fbf30721bac9 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -246,4 +246,5 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
 void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
 int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
 int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
+int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
 #endif /* _LINUX_VIRTIO_VSOCK_H */
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index b01cf9ac2437..dc3cb16835b6 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -137,7 +137,6 @@ struct vsock_transport {
 	u64 (*stream_rcvhiwat)(struct vsock_sock *);
 	bool (*stream_is_active)(struct vsock_sock *);
 	bool (*stream_allow)(u32 cid, u32 port);
-	int (*set_rcvlowat)(struct vsock_sock *vsk, int val);
 
 	/* SEQ_PACKET. */
 	ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
@@ -168,6 +167,7 @@ struct vsock_transport {
 		struct vsock_transport_send_notify_data *);
 	/* sk_lock held by the caller */
 	void (*notify_buffer_size)(struct vsock_sock *, u64 *);
+	int (*notify_set_rcvlowat)(struct vsock_sock *vsk, int val);
 
 	/* Shutdown. */
 	int (*shutdown)(struct vsock_sock *, int);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index ccd8cefeea7b..4afb6a541cf3 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2214,8 +2214,13 @@ static int vsock_set_rcvlowat(struct sock *sk, int val)
 
 	transport = vsk->transport;
 
-	if (transport && transport->set_rcvlowat)
-		return transport->set_rcvlowat(vsk, val);
+	if (transport && transport->notify_set_rcvlowat) {
+		int err;
+
+		err = transport->notify_set_rcvlowat(vsk, val);
+		if (err)
+			return err;
+	}
 
 	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
 	return 0;
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 7cb1a9d2cdb4..e2157e387217 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -816,7 +816,7 @@ int hvs_notify_send_post_enqueue(struct vsock_sock *vsk, ssize_t written,
 }
 
 static
-int hvs_set_rcvlowat(struct vsock_sock *vsk, int val)
+int hvs_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
 {
 	return -EOPNOTSUPP;
 }
@@ -856,7 +856,7 @@ static struct vsock_transport hvs_transport = {
 	.notify_send_pre_enqueue  = hvs_notify_send_pre_enqueue,
 	.notify_send_post_enqueue = hvs_notify_send_post_enqueue,
 
-	.set_rcvlowat             = hvs_set_rcvlowat
+	.notify_set_rcvlowat      = hvs_notify_set_rcvlowat
 };
 
 static bool hvs_check_transport(struct vsock_sock *vsk)
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index b80bf681327b..a64bf601b480 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -457,6 +457,7 @@ static struct virtio_transport virtio_transport = {
 		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
 		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
 
 		.read_skb = virtio_transport_read_skb,
 	},
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 34a6d5e64ff2..e87fd9480acd 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1526,6 +1526,36 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 }
 EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
 
+int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
+{
+	struct virtio_vsock_sock *vvs = vsk->trans;
+	bool send_update;
+
+	spin_lock_bh(&vvs->rx_lock);
+
+	/* If number of available bytes is less than new SO_RCVLOWAT value,
+	 * kick sender to send more data, because sender may sleep in its
+	 * 'send()' syscall waiting for enough space at our side. Also
+	 * don't send credit update when peer already knows actual value -
+	 * such transmission will be useless.
+	 */
+	send_update = (vvs->rx_bytes < val) &&
+		      (vvs->fwd_cnt != vvs->last_fwd_cnt);
+
+	spin_unlock_bh(&vvs->rx_lock);
+
+	if (send_update) {
+		int err;
+
+		err = virtio_transport_send_credit_update(vsk);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtio_transport_notify_set_rcvlowat);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Asias He");
 MODULE_DESCRIPTION("common code for virtio vsock");
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 5c6360df1f31..0ce65d0a4a44 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -90,6 +90,7 @@ static struct virtio_transport loopback_transport = {
 		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
 		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
 
 		.read_skb = virtio_transport_read_skb,
 	},
-- 
2.43.0




