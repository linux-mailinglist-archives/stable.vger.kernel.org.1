Return-Path: <stable+bounces-170856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E40DB2A6A0
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3626F1B639E4
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D42320CC9;
	Mon, 18 Aug 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="obUw8WOD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275D78F4F;
	Mon, 18 Aug 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524020; cv=none; b=dDNCNchrxWF23CfhprZl1MK+qRPjU2li0RR5eG8c1UydiISDhmdSCaq3Evg5KAM5vFKQMXmkC/mK4tFvxllKrvgFTqZy9fOnqj6SZroPSNdMx9Uw5hv0gxFgYCZ3bTXgTnblbqDfjgWgggPoGYhp3/MMkX7DRgpzdkoJgLNuDDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524020; c=relaxed/simple;
	bh=RKHyd3OMgBLe3HIkXs2dJ2J6JCBGKaFPPk7lEgpYH5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pybzmJx5be2irLK8ZR2xB5GxydgFuxAYTAu4vGRk2Cz2/tKFBG1WyPoDq9G3ARLg0HZ/GeWbiNQ5Rehcyr2RdmkjZQBRepH4N2CzbGWFS4WnQaxko6QkG8CL4eKHaOolU4yS833AOTnNA8umdHFuRWmQm/1d1Sw7xESCpHcrHqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=obUw8WOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4B1C4CEEB;
	Mon, 18 Aug 2025 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524020;
	bh=RKHyd3OMgBLe3HIkXs2dJ2J6JCBGKaFPPk7lEgpYH5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=obUw8WOD327dgHt/31boF1hcbjjdKZgFXQbG3FcZU1EqGbtHgQXycX/kblH3roVs7
	 hvxhB1SYwyMs+lOPZrz2r7L8ChOdMApYyqGn0fFo2YeQeo0otG9gr12Ee5SHvkAkLE
	 bthAkQ0XJtPZZDqJ7bZ8WJYtZbNjUvUAD9oXigsE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 326/515] vsock/virtio: Resize receive buffers so that each SKB fits in a 4K page
Date: Mon, 18 Aug 2025 14:45:12 +0200
Message-ID: <20250818124510.985573855@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will@kernel.org>

[ Upstream commit 03a92f036a04fed2b00d69f5f46f1a486e70dc5c ]

When allocating receive buffers for the vsock virtio RX virtqueue, an
SKB is allocated with a 4140 data payload (the 44-byte packet header +
VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE). Even when factoring in the SKB
overhead, the resulting 8KiB allocation thanks to the rounding in
kmalloc_reserve() is wasteful (~3700 unusable bytes) and results in a
higher-order page allocation on systems with 4KiB pages just for the
sake of a few hundred bytes of packet data.

Limit the vsock virtio RX buffers to 4KiB per SKB, resulting in much
better memory utilisation and removing the need to allocate higher-order
pages entirely.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
Message-Id: <20250717090116.11987-5-will@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/virtio_vsock.h     | 7 ++++++-
 net/vmw_vsock/virtio_transport.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 36fb3edfa403..6c00687539cf 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -111,7 +111,12 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
 	return (size_t)(skb_end_pointer(skb) - skb->head);
 }
 
-#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
+/* Dimension the RX SKB so that the entire thing fits exactly into
+ * a single 4KiB page. This avoids wasting memory due to alloc_skb()
+ * rounding up to the next page order and also means that we
+ * don't leave higher-order pages sitting around in the RX queue.
+ */
+#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	SKB_WITH_OVERHEAD(1024 * 4)
 #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
 #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f0e48e6911fc..f01f9e878106 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -307,7 +307,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
 
 static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 {
-	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;
+	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
 	struct scatterlist pkt, *p;
 	struct virtqueue *vq;
 	struct sk_buff *skb;
-- 
2.39.5




