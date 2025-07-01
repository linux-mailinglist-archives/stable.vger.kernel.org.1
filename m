Return-Path: <stable+bounces-159158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00126AF007D
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 18:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DDC487265
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 16:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F08280A29;
	Tue,  1 Jul 2025 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZxKbsjn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5927FD60;
	Tue,  1 Jul 2025 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388318; cv=none; b=sC2DhRESpFQfiddQYeFimApK/PAvmcqVi2/qGtWNVuEx4pi7cPSAW9Qheym+EdAcPKDvdSLlymc6jVTGeXn+oRVRJ6ZQSy8FPWc+9/0PIJNUqUdCW1vsf8oe70y1zahazy57uW0zbyz26wn1NxJ2/bY65dRmt6FfGutMjculZxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388318; c=relaxed/simple;
	bh=iISDn9L+D3wVAHPNNIcp/TCqX/3WWeX/S60myFyZsyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MAWf8uaBb5PEWwq4/kJHuMjqeg0RBfnhuGwFvIWtHR5sCMXOEWODj774cILK4yzHJVK4TsxRc4SfY6Zf2fSTpXx/RzK8bmwFG369KkFHeYdPoCpiSU7d0SOJTrnYr+WCXf43Z+XeInC3g+d2MoYhXGIXaNB2rtFXKIzIehVh/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZxKbsjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E564C4CEEB;
	Tue,  1 Jul 2025 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751388318;
	bh=iISDn9L+D3wVAHPNNIcp/TCqX/3WWeX/S60myFyZsyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZxKbsjnxeim9dro/dDexHotSos9MPh1hZEwwprrdBVkWopSRky5SfOKmk99xuGc8
	 /EFW4YGONjdpQcXnsQaAAcAI1xDMpbxIY/o/CirhEf+z1d0iwAH92bvfrPVzrf3wS/
	 GX5JNReJYcw3N7JjTkuPpMdiAXPnH7pE1eDqteRu8YXnZl/8wNXSNzsAyHg/RI9RUj
	 YtNAhTYLqzLAzlYX9R/TgloOe/O6INgJ8oc44kVEFELJblgEOxvMqsfVxu396ITnU+
	 4HKPmSWjTb3ICsOvpjOxIDyPLdxweWKNEq1NWztMTActZYxAY8ALNLNFTPtKy+NZTq
	 UbfT6WsCvuK3g==
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
Subject: [PATCH v2 1/8] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
Date: Tue,  1 Jul 2025 17:45:00 +0100
Message-Id: <20250701164507.14883-2-will@kernel.org>
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


