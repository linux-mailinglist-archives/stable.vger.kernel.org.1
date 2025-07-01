Return-Path: <stable+bounces-159159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9319AF00A7
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4821C22A09
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 16:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA34828150A;
	Tue,  1 Jul 2025 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU1oFe1E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06B28136C;
	Tue,  1 Jul 2025 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388321; cv=none; b=V1dbSFfvdu8WcicuofpxZs+/GzqzejiC3Uck79NJ6mWtevL0OQPJxaAdvFINJPVRNzTb88JlIkhMRQtrJWm/JhsYwkujM4UR/7IhLhAsahkMaV1az+tnlKcKpnq7WgqIzkHRSsiI2p0/S2DDB0Qdd9QGvZ6Fh5v9VdSWs/Y12dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388321; c=relaxed/simple;
	bh=oKf208jR2snmwBDg9o+AlVnnid4IgiStTjfyVYgKtp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HK163XWPS8LBmoanV2wZbHZEJJbOvcip1X8VIByNIjQ+EKkiYp+boZnMnBmGzl54qV59GtueEo5c9Yi0ZW+JmsiAQzkwhXpPFX3IbQbc0qGo7P9V+asQpsCNyfU22A83KwYtIydlx5/2qpe6lD0k7kLuVmyucdvp/6v9ScEFiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU1oFe1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E14C4CEEF;
	Tue,  1 Jul 2025 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751388320;
	bh=oKf208jR2snmwBDg9o+AlVnnid4IgiStTjfyVYgKtp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HU1oFe1EOSzMivrXmQKxagYBpX613BZimJ3G5eHkNnYSGERMRtBl88f1FN/dfZwzA
	 9s1O+N8wHs2DdsjNALXKVO4Wuy56r+dXj+NazqC3IdFV3ATaS5FMZzAaHRBCOuZOHs
	 mW5UvIC0DnIJCeAXV1PXhVhcE5QFfgTvLdojmwQJRjRJVXA+02tvZh6hGVkYEK1qcn
	 aRBbbGEOiA9rtDrFxnEvZbCqyb+FYpw7AYuTZtTlIbS6uj4Y+0hkoUgXYomTBO4hO5
	 WA3ng+rlqqslLovpjZtqGWc33ExxgFojUseZfYgRP6w2F1da68OzuIWql7uU2A5gFg
	 cLZS+RdLRHYjw==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 2/8] vsock/virtio: Validate length in packet header before skb_put()
Date: Tue,  1 Jul 2025 17:45:01 +0100
Message-Id: <20250701164507.14883-3-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701164507.14883-1-will@kernel.org>
References: <20250701164507.14883-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When receiving a vsock packet in the guest, only the virtqueue buffer
size is validated prior to virtio_vsock_skb_rx_put(). Unfortunately,
virtio_vsock_skb_rx_put() uses the length from the packet header as the
length argument to skb_put(), potentially resulting in SKB overflow if
the host has gone wonky.

Validate the length as advertised by the packet header before calling
virtio_vsock_skb_rx_put().

Cc: <stable@vger.kernel.org>
Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Signed-off-by: Will Deacon <will@kernel.org>
---
 net/vmw_vsock/virtio_transport.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f0e48e6911fc..bd2c6aaa1a93 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -624,8 +624,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	do {
 		virtqueue_disable_cb(vq);
 		for (;;) {
+			unsigned int len, payload_len;
+			struct virtio_vsock_hdr *hdr;
 			struct sk_buff *skb;
-			unsigned int len;
 
 			if (!virtio_transport_more_replies(vsock)) {
 				/* Stop rx until the device processes already
@@ -642,12 +643,19 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			vsock->rx_buf_nr--;
 
 			/* Drop short/long packets */
-			if (unlikely(len < sizeof(struct virtio_vsock_hdr) ||
+			if (unlikely(len < sizeof(*hdr) ||
 				     len > virtio_vsock_skb_len(skb))) {
 				kfree_skb(skb);
 				continue;
 			}
 
+			hdr = virtio_vsock_hdr(skb);
+			payload_len = le32_to_cpu(hdr->len);
+			if (payload_len > len - sizeof(*hdr)) {
+				kfree_skb(skb);
+				continue;
+			}
+
 			virtio_vsock_skb_rx_put(skb);
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
-- 
2.50.0.727.gbf7dc18ff4-goog


