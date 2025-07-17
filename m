Return-Path: <stable+bounces-163236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1014B088C1
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 11:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39253BDC9C
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323A28B3F7;
	Thu, 17 Jul 2025 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP5E/DxQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B8828A72A;
	Thu, 17 Jul 2025 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742889; cv=none; b=tBSZP7x3UJiFQ0OQhbuTm2WjPjS29Xw+H0bfgTSDStUFs4utf/umTBVlQovrmx9LKNuqH+Q90nucd2vwq59/bKLJHFVhBVGwRcBwjQRCS0wRA9CabBHzduj4XOt28bkX+hGivwRU5usQi4O0SDmJlUx89D3I/tWVhf4MuFiqKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742889; c=relaxed/simple;
	bh=6D5cFK2vNGL2QsQ9IOnTKvvlTeWZ5xospOK0ukeQYVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q19nnP0rsiUQbyCmwq50g69PeOpXRrnIFiMlSYY7uE+QXpoReLvDzuSU6/Eeh0NW87NZn/6clYzEa2ar8/+WXFQR21VNkeGxw5uPj9ixnLKr2NzXDFHRL1cs90qKKzEQnLxVXBW+bt1h+KP7a0i8yYuhDiugCX34MBB9Oz/pHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP5E/DxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BA9C4CEE3;
	Thu, 17 Jul 2025 09:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752742888;
	bh=6D5cFK2vNGL2QsQ9IOnTKvvlTeWZ5xospOK0ukeQYVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GP5E/DxQaUSooC8bh5SMhxjNsoRAr9rMBHD3EOasY5iXkqtH1s2idUvtfEOyC0bmh
	 2sK4QuCFPg19W91sta+1nYVZEK++8vc+lm+kekSdH7XnsM469sREHcj1N1a0lJ3juT
	 o0rme5WVnSSrwwwQjFwhXWnATeJCc8OA78fX0JfwRA2OF48HFk+jib5j1KrEsJi6ii
	 W/YUIX07mLcilOUVwkjoR/mXtEi0pcH4BpXYabOBU3ypE2fcof1WocPTaRwEXKG38n
	 Zo/dYM7vq+INmEaUojmFmxLExwfPswbEpALx+RfAAaUSwgw3DCs73GbPmdg9wUfE9L
	 pLCM6heF0g+8g==
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
Subject: [PATCH v4 2/9] vsock/virtio: Validate length in packet header before skb_put()
Date: Thu, 17 Jul 2025 10:01:09 +0100
Message-Id: <20250717090116.11987-3-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717090116.11987-1-will@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
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
index f0e48e6911fc..eb08a393413d 100644
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
+			if (unlikely(payload_len > len - sizeof(*hdr))) {
+				kfree_skb(skb);
+				continue;
+			}
+
 			virtio_vsock_skb_rx_put(skb);
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
-- 
2.50.0.727.gbf7dc18ff4-goog


