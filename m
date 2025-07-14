Return-Path: <stable+bounces-161861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBFEB043A9
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 17:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3DF4A7E85
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8255262FD3;
	Mon, 14 Jul 2025 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU9/P+kD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE342627FC;
	Mon, 14 Jul 2025 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506475; cv=none; b=fSa5Kvq1bMZIYcXh1YG7n0z+ai0UhUDWzGBMZ3CV4yNcnLRDW89GaUbVgfFuAwVt/kgnMpzTSyrOGHjXnfVRPwFIwTeYLPRiqdTcTKihF+nKyRzKLq3DsyCivIlSLJOvBgzkTyVrP2KWq4neUrtYs7O/hQfZaL5+n7vmpGKT6nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506475; c=relaxed/simple;
	bh=iISDn9L+D3wVAHPNNIcp/TCqX/3WWeX/S60myFyZsyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fMhqXtVCahyKYTjYBtN+0DhSX/wicKEzjtNzt8CFSI/oZaJzet9mpmwvglDsFaf0/HQ0qq4fckrlR8eQN//Q2sZXgISL7y35mYsZwpAKZSXvpzfE0/tdC52Agr0rTEDyT/Ha9WAKooZaRSOgqLm2uK6iFn1YUEo16RPYd+qOYiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU9/P+kD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5BEC4CEF0;
	Mon, 14 Jul 2025 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506474;
	bh=iISDn9L+D3wVAHPNNIcp/TCqX/3WWeX/S60myFyZsyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cU9/P+kDTb3VLqs+GQ/BAkKRBw8CyTjCxzTm4rbVmE9cIWhZ4tsKrFOnsr/NQYfBB
	 ybyjk5TUFAgVXnNH5DpiiB9cB9aiXnwWWyjwksYKFN8scGaawPY3rouhHjfngKZXl+
	 xAXw9D7iQh0nCLmI/e6D3/vW0qw+E6ZFx7vLFPmiAqMZpUvF3W5Gk4vexxtA/PEJZw
	 S3/nPh1QtzuTAnr4ghzxr5/F32KE4W5EG9q5GWuJ+VArWqTPkBP/4LFSJAklps2/Fm
	 UXucZZKDy20diWMOfEexVZv+Qhp7VlnBD7gSfyrBbOH4sNzQEq8rJQIU12aQ5/Szyt
	 tJ1A+drGgRUoQ==
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
Subject: [PATCH v3 1/9] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
Date: Mon, 14 Jul 2025 16:20:55 +0100
Message-Id: <20250714152103.6949-2-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250714152103.6949-1-will@kernel.org>
References: <20250714152103.6949-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock_alloc_skb() returns NULL for packets advertising a length
larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However,
this is only checked once the SKB has been allocated and, if the length
in the packet header is zero, the SKB may not be freed immediately.

Hoist the size check before the SKB allocation so that an iovec larger
than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
outright. The subsequent check on the length field in the header can
then simply check that the allocated SKB is indeed large enough to hold
the packet.

Cc: <stable@vger.kernel.org>
Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vsock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 802153e23073..66a0f060770e 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
 	len = iov_length(vq->iov, out);
 
+	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
+		return NULL;
+
 	/* len contains both payload and hdr */
 	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
 	if (!skb)
@@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return skb;
 
 	/* The pkt is too big or the length in the header is invalid */
-	if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
-	    payload_len + sizeof(*hdr) > len) {
+	if (payload_len + sizeof(*hdr) > len) {
 		kfree_skb(skb);
 		return NULL;
 	}
-- 
2.50.0.727.gbf7dc18ff4-goog


