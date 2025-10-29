Return-Path: <stable+bounces-191559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A541C17E55
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 02:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092FF3BF044
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 01:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706812DCBE2;
	Wed, 29 Oct 2025 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXFDOXrz"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC201C5F10
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701095; cv=none; b=kSqn0bFHTgTpvfFwVERR5cRtxH6R+8/x8rnh3glvDmiNIPZSvvUlwJYbpp4RYZkZxHJsBGGyKeg6BOpehj+Zv/DVZ5YyBTgPc3G+q0G6ZL1u4APPIsLqruntx+OdMLvpTeYmPVrzIuOKS6D698iMKzTYvOw/JA/ezm0k4141mwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701095; c=relaxed/simple;
	bh=PKRuTRimF4SYTLZRofdH+Kyncm9Idj+SwpxtXEnIAdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=nbZf2haEIGSndSIi48qzjCVwOB90zyW3YhNb+V1HreFXcRkOhHxjwTzpD6vOE4mxBYW6/RMajny02HvEj9HAUg70BF9GBbK6FIBSmHq7TG1zZsph902pOqkteciedRIA2uLufhNYhLLV93YC4BaNmTLdj6I9dKw2g6F3y/BTaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXFDOXrz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761701092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wVSi1lcrQ2LPNL0uA8+lcsf92i/aD7113jgr/Mo2pIg=;
	b=BXFDOXrzQijdYJOtBPbw0hLW8Vn7xBja+h/Ci9PoqQK8dzhEUEE0k8x//YOxmZXR9lqWXn
	3S18YriLhiipwqPkm7otw+ko4i6IiWXkBBdh8TkrxiPuWBRwbGK7K0H8x5Dvsm3hTidHUp
	Fq1BwJUwAtEK/CXIVKtqEBmX89dzXlE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-ScP-ngM9N06ur7kDs7233w-1; Tue,
 28 Oct 2025 21:24:49 -0400
X-MC-Unique: ScP-ngM9N06ur7kDs7233w-1
X-Mimecast-MFC-AGG-ID: ScP-ngM9N06ur7kDs7233w_1761701087
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4745618002C1;
	Wed, 29 Oct 2025 01:24:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.136])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F43119560B8;
	Wed, 29 Oct 2025 01:24:39 +0000 (UTC)
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
Subject: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
Date: Wed, 29 Oct 2025 09:24:34 +0800
Message-ID: <20251029012434.75576-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
 drivers/net/virtio_net.c        | 15 +++++++++++++--
 include/uapi/linux/virtio_net.h |  3 ++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..5e998d88db44 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2534,6 +2534,13 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
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
@@ -2560,7 +2567,7 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	default:
 		rss_hash_type = PKT_HASH_TYPE_NONE;
 	}
-	skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
+	skb_set_hash(skb, virtio_net_hash_value(hdr_hash), rss_hash_type);
 }
 
 static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
@@ -3306,6 +3313,10 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
 
+	/* Make sure it's safe to cast between formats */
+	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->hash_hdr));
+	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->hash_hdr.hdr));
+
 	can_push = vi->any_header_sg &&
 		!((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
 		!skb_header_cloned(skb) && skb_headroom(skb) >= hdr_len;
@@ -6745,7 +6756,7 @@ static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
 		hash_report = VIRTIO_NET_HASH_REPORT_NONE;
 
 	*rss_type = virtnet_xdp_rss_type[hash_report];
-	*hash = __le32_to_cpu(hdr_hash->hash_value);
+	*hash = virtio_net_hash_value(hdr_hash);
 	return 0;
 }
 
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
2.42.0


