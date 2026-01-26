Return-Path: <stable+bounces-211682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCWJIDzMd2mxlQEAu9opvQ
	(envelope-from <stable+bounces-211682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:19:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC7C8CFA5
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F06C3018D78
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 20:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B572D4813;
	Mon, 26 Jan 2026 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZePhpPBf"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675B2D3EC1
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458722; cv=none; b=YX34We/MtPahJOhcyPRURQsm46xbgDqa1M8TEB6rCeBEH8ihKu+A9EvYHtsaugY4c9PoS5C+gONmxrnqs1T7EIDZIErG38Ve37V9asmJcHGnO8BIVz7Sw8KQkQe0SeNnu7QZrInwnL+qWmpbMaahcqNFu1uB972+SzXQfHzzbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458722; c=relaxed/simple;
	bh=fljdMUJpD+8lshPcwFa63Mky9r7CJgJEFDy6nxaFQRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jzGT3jTzcxr3ixX7Ux+DMCB7nR9ZMp6F4Bex/PydPuHz5dHyhEdAf3xozhVxsTQszrR7eJSQks+4wGw7UjRxh2NPMJkG5UgIB1Ymw64+GsiUK0rzOW50ViIv1lAaXBVnl8YGPMFxU5915rMyBFo+ndDaOUjEbIoFomWudAKHAlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZePhpPBf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zaihOV2DKJYfr8HfuwVsPhVQNhfjOXKu1YhQiRHwBps=; b=ZePhpPBfSr3rZWhhZs2I/6jpjM
	rzQckEzEdUY3XalK2cxBoruz/VHxYhUOhbRq4cR6YIhnPG7LaGTQq0ChohmJPwT/nTHMH1mmq5hf1
	FlmR+E03VVH35UIg2oPCMbIa6pC+IbroCYB9MFG97dS514qUg/hyLJ+dndbZntKyqqH+h8xibIOoT
	VMr/qj9FzNkSRvCo0Gzfv9yFtvVC1aZO0U1rqR67s+M2lURaJMNwwKZg/An6P9ubu/jhZoaf5zLcf
	zzhlObSpwjIXksEZbvFfzexc0WCFor5/Keh1M+wj3OaojylD83T7QDBm+DyWG6hchXZRtk/QpAZMj
	+ivR1xBg==;
Received: from 189-14-88-37.vmaxnet.com.br ([189.14.88.37] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vkT2Y-00ABzB-DX; Mon, 26 Jan 2026 21:18:26 +0100
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Mon, 26 Jan 2026 17:16:56 -0300
Subject: [PATCH 6.12 5/8] vhost/vsock: Allocate nonlinear SKBs for handling
 large receive buffers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-backport-vsock-nonlinear-skb-6-12-v1-5-ad5c34853a60@igalia.com>
References: <20260126-backport-vsock-nonlinear-skb-6-12-v1-0-ad5c34853a60@igalia.com>
In-Reply-To: <20260126-backport-vsock-nonlinear-skb-6-12-v1-0-ad5c34853a60@igalia.com>
To: stable@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Will Deacon <will@kernel.org>
Cc: kernel-dev@igalia.com, Heitor Alves de Siqueira <halves@igalia.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211682-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[halves@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DC7C8CFA5
X-Rspamd-Action: no action

From: Will Deacon <will@kernel.org>

[Upstream commit ab9aa2f3afc2713c14f6c4c6b90c9a0933b837f1]

When receiving a packet from a guest, vhost_vsock_handle_tx_kick()
calls vhost_vsock_alloc_linear_skb() to allocate and fill an SKB with
the receive data. Unfortunately, these are always linear allocations and
can therefore result in significant pressure on kmalloc() considering
that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
allocation for each packet.

Rework the vsock SKB allocation so that, for sizes with page order
greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
instead with the packet header in the SKB and the receive data in the
fragments. Finally, add a debug warning if virtio_vsock_skb_rx_put() is
ever called on an SKB with a non-zero length, as this would be
destructive for the nonlinear case.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
Message-Id: <20250717090116.11987-8-will@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 drivers/vhost/vsock.c        |  8 +++-----
 include/linux/virtio_vsock.h | 40 +++++++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 6373b6d6d65d..78cc66fbb3dd 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -350,7 +350,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return NULL;
 
 	/* len contains both payload and hdr */
-	skb = virtio_vsock_alloc_linear_skb(len, GFP_KERNEL);
+	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 
@@ -379,10 +379,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
 	virtio_vsock_skb_put(skb, payload_len);
 
-	nbytes = copy_from_iter(skb->data, payload_len, &iov_iter);
-	if (nbytes != payload_len) {
-		vq_err(vq, "Expected %zu byte payload, got %zu bytes\n",
-		       payload_len, nbytes);
+	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
+		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
 		kfree_skb(skb);
 		return NULL;
 	}
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 39c818b4a057..0c67543a45c8 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -49,20 +49,46 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
 
 static inline void virtio_vsock_skb_put(struct sk_buff *skb, u32 len)
 {
-	skb_put(skb, len);
+	DEBUG_NET_WARN_ON_ONCE(skb->len);
+
+	if (skb_is_nonlinear(skb))
+		skb->len = len;
+	else
+		skb_put(skb, len);
+}
+
+static inline struct sk_buff *
+__virtio_vsock_alloc_skb_with_frags(unsigned int header_len,
+				    unsigned int data_len,
+				    gfp_t mask)
+{
+	struct sk_buff *skb;
+	int err;
+
+	skb = alloc_skb_with_frags(header_len, data_len,
+				   PAGE_ALLOC_COSTLY_ORDER, &err, mask);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
+	skb->data_len = data_len;
+	return skb;
 }
 
 static inline struct sk_buff *
 virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
 {
-	struct sk_buff *skb;
+	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
+}
 
-	skb = alloc_skb(size, mask);
-	if (!skb)
-		return NULL;
+static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
+{
+	if (size <= SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
+		return virtio_vsock_alloc_linear_skb(size, mask);
 
-	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
-	return skb;
+	size -= VIRTIO_VSOCK_SKB_HEADROOM;
+	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
+						   size, mask);
 }
 
 static inline void

-- 
2.52.0


