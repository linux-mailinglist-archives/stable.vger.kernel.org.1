Return-Path: <stable+bounces-191381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD3C12B76
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 04:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0235E0483
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 03:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0919527E07E;
	Tue, 28 Oct 2025 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KI2aDGhJ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AD32727FD
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761620643; cv=none; b=TKM+ee+wQZu7QlpOou9/ChSsGpU+4ROs3oy59QjDVuajwGPW317QWq/uJ/006olLDYyveuU3kVlzQ0r4C6GoHpdz1ZNOJQR4mWl5dv/ceeShg4irnNoLZzPQGz1CiB70BHK+8e9YEJruUIKgT4zR7X5SwvaeJXhEF+JPJNKYG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761620643; c=relaxed/simple;
	bh=MAMBTDB5J81podhs/Vxvh8Om3RfCRucDoiCNDGV+6Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+HS7pZ+DC7MIEh4zb1rKQ43oaJDbPt8WJzf4B/l88DR/FtghwKXnAMTzhToF7IPJ2U7M5mg9TNlo6pzTNtwTr5cmGpHZhtDri6TP/jAwO73fxcNzByAS5P8M/X1c6r62MitMmG0TzH/VefJg5nMngQWbkYrNgAr5kCn0NT78KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KI2aDGhJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761620641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vfNTkoX5o8M7lD+gAK07FYlqQWjsG6C+tpRjNjLD85s=;
	b=KI2aDGhJ4pz44uMUBTz3Aor+5AXjVbUHKdQTDQC/3fp88FBMQrE0Hj3mNv/bsup4V+A0ch
	YUDcFSeGI93lIB7U/mU/Oik14i1rzavN+M2LnoQrtJ6PYAva7oBb7xbuk/7jzHOuD57pOD
	njmrSuYmT4IVxwpFVkKu/Q3uWlXfwWc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-MOErp7MUNkyaHL7YM-fbQQ-1; Mon,
 27 Oct 2025 23:03:54 -0400
X-MC-Unique: MOErp7MUNkyaHL7YM-fbQQ-1
X-Mimecast-MFC-AGG-ID: MOErp7MUNkyaHL7YM-fbQQ_1761620632
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FF84180A220;
	Tue, 28 Oct 2025 03:03:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.238])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 129E219560AD;
	Tue, 28 Oct 2025 03:03:44 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] virtio-net: calculate header alignment mask based on features
Date: Tue, 28 Oct 2025 11:03:41 +0800
Message-ID: <20251028030341.46023-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Commit 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
switches to check the alignment of the virtio_net_hdr_v1_hash_tunnel
even when doing the transmission even if the feature is not
negotiated. This will cause a series performance degradation of pktgen
as the skb->data can't satisfy the alignment requirement due to the
increase of the header size then virtio-net must prepare at least 2
sgs with indirect descriptors which will introduce overheads in the
device.

Fixing this by calculate the header alignment during probe so when
tunnel gso is not negotiated, we can less strict.

Pktgen in guest + XDP_DROP on TAP + vhost_net shows the TX PPS is
recovered from 2.4Mpps to 4.45Mpps.

Note that we still need a way to recover the performance when tunnel
gso is enabled, probably a new vnet header format.

Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 31bd32bdecaf..5b851df749c0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -441,6 +441,9 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
+	/* header alignment */
+	size_t hdr_align;
+
 	/* Work struct for delayed refilling if we run low on memory. */
 	struct delayed_work refill;
 
@@ -3308,8 +3311,9 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
 
 	can_push = vi->any_header_sg &&
-		!((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
+		!((unsigned long)skb->data & (vi->hdr_align - 1)) &&
 		!skb_header_cloned(skb) && skb_headroom(skb) >= hdr_len;
+
 	/* Even if we can, don't push here yet as this would skew
 	 * csum_start offset below. */
 	if (can_push)
@@ -6926,15 +6930,20 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
-	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
+	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)) {
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
-	else if (vi->has_rss_hash_report)
+		vi->hdr_align = __alignof__(struct virtio_net_hdr_v1_hash_tunnel);
+	} else if (vi->has_rss_hash_report) {
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
-	else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
-		 virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
+		vi->hdr_align = __alignof__(struct virtio_net_hdr_v1_hash);
+	} else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
+		virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
 		vi->hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
-	else
+		vi->hdr_align = __alignof__(struct virtio_net_hdr_mrg_rxbuf);
+	} else {
 		vi->hdr_len = sizeof(struct virtio_net_hdr);
+		vi->hdr_align = __alignof__(struct virtio_net_hdr);
+	}
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM))
 		vi->rx_tnl_csum = true;
-- 
2.31.1


