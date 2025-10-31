Return-Path: <stable+bounces-191786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6BFC23519
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 07:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB76E40863A
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 06:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307EC2E7BB4;
	Fri, 31 Oct 2025 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoAGExTF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FE2E62C3
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761890776; cv=none; b=it8tQODscyxq2Od39Zc/zFk3YFgVjhdt0Thqwl77SQ6+TmW9syJ2Durr0ZMlysVVUxJhiODgdydyd+Irj2IZQkarMvJvvT3Y6cEgjHe0CKEYl5JCMjhWsXrtn9ijFPibyoOaTS9UkmmzY9tS0f/FuzLPM+dyhd3nfzM777IiNQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761890776; c=relaxed/simple;
	bh=uzKsr8p0ZgM+SLgICEjgau4Cc9/3BVPso+PqdA0y7L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+L7LospHfpa8UBIa854c9M1olJzIacEGaBMV7/hKLlsXjG4Idfqa+snX6tBfksnm3AOyml3BRn5itDEDxVL6v8q/04LNZekha9YiqLgVhOfLQLYgEEV3GBpuv8hpNOssbPBzSDZqGSV2mqu44iqMBls/rLifY+/IVdyBpqdgpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FoAGExTF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761890773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+bCrk/NYYmYlKBsMjf6Y0gKt7P2+73Hm3s9fxJ/Q+sk=;
	b=FoAGExTF79kTZ/cca5BoXsCs3OUqZD6LQQnhZL1T2yKWxhb+mboPu6R/VlG00+R4RSfDii
	unBC9PZDUMZ4Tlz0PAfyq+zSPeOc9nAi3X4pM58m4M9Ol/wz9p/jRkbXcCTgeCXVGYnXiC
	XS49UR2hEy2dBDRI3tpadUsnVzJBd8o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-7ClablYyO1OVe2uC7hp5hQ-1; Fri,
 31 Oct 2025 02:06:09 -0400
X-MC-Unique: 7ClablYyO1OVe2uC7hp5hQ-1
X-Mimecast-MFC-AGG-ID: 7ClablYyO1OVe2uC7hp5hQ_1761890768
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79D581953958;
	Fri, 31 Oct 2025 06:06:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96EE21955BE3;
	Fri, 31 Oct 2025 06:05:55 +0000 (UTC)
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
Subject: [PATCH net V2] virtio_net: fix alignment for virtio_net_hdr_v1_hash
Date: Fri, 31 Oct 2025 14:05:51 +0800
Message-ID: <20251031060551.126-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: "Michael S. Tsirkin" <mst@redhat.com>

Changing alignment of header would mean it's no longer safe to cast a
2 byte aligned pointer between formats. Use two 16 bit fields to make
it 2 byte aligned as previously.

This fixes the performance regression since
commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
virtio_net_hdr_v1_hash_tunnel which embeds
virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.

Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- Fix build issues of virtio_net_hdr_tnl_from_skb()
---
 drivers/net/virtio_net.c        | 15 +++++++++++++--
 include/linux/virtio_net.h      |  3 ++-
 include/uapi/linux/virtio_net.h |  3 ++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e8a179aaa49..e6e650bc3bc3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2539,6 +2539,13 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	return NULL;
 }
 
+static inline u32
+virtio_net_hash_value(const struct virtio_net_hdr_v1_hash *hdr_hash)
+{
+	return __le16_to_cpu(hdr_hash->hash_value_lo) |
+		(__le16_to_cpu(hdr_hash->hash_value_hi) << 16);
+}
+
 static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 				struct sk_buff *skb)
 {
@@ -2565,7 +2572,7 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	default:
 		rss_hash_type = PKT_HASH_TYPE_NONE;
 	}
-	skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
+	skb_set_hash(skb, virtio_net_hash_value(hdr_hash), rss_hash_type);
 }
 
 static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
@@ -3311,6 +3318,10 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
 
+	/* Make sure it's safe to cast between formats */
+	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->hash_hdr));
+	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->hash_hdr.hdr));
+
 	can_push = vi->any_header_sg &&
 		!((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
 		!skb_header_cloned(skb) && skb_headroom(skb) >= hdr_len;
@@ -6750,7 +6761,7 @@ static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
 		hash_report = VIRTIO_NET_HASH_REPORT_NONE;
 
 	*rss_type = virtnet_xdp_rss_type[hash_report];
-	*hash = __le32_to_cpu(hdr_hash->hash_value);
+	*hash = virtio_net_hash_value(hdr_hash);
 	return 0;
 }
 
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 4d1780848d0e..b673c31569f3 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -401,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	if (!tnl_hdr_negotiated)
 		return -EINVAL;
 
-        vhdr->hash_hdr.hash_value = 0;
+	vhdr->hash_hdr.hash_value_lo = 0;
+	vhdr->hash_hdr.hash_value_hi = 0;
         vhdr->hash_hdr.hash_report = 0;
         vhdr->hash_hdr.padding = 0;
 
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 8bf27ab8bcb4..1db45b01532b 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -193,7 +193,8 @@ struct virtio_net_hdr_v1 {
 
 struct virtio_net_hdr_v1_hash {
 	struct virtio_net_hdr_v1 hdr;
-	__le32 hash_value;
+	__le16 hash_value_lo;
+	__le16 hash_value_hi;
 #define VIRTIO_NET_HASH_REPORT_NONE            0
 #define VIRTIO_NET_HASH_REPORT_IPv4            1
 #define VIRTIO_NET_HASH_REPORT_TCPv4           2
-- 
2.31.1


