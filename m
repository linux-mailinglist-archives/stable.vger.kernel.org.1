Return-Path: <stable+bounces-217860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEPNN48znWlINQQAu9opvQ
	(envelope-from <stable+bounces-217860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 06:13:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 179B5181D3C
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 06:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD5EB3016B38
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 05:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9846428505E;
	Tue, 24 Feb 2026 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HZfxlm7h"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E81607A4;
	Tue, 24 Feb 2026 05:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771910017; cv=none; b=dhIIetL9hL47COdjVCoo03vF+B5qkImYM3VrMjsnoRj5+sxXxxiIWCU6Y4wC2e3ERs1bRnbc94eAyvjcmYK7Sx1dYE9c+PblaQHhpwngvexlI6tWzn63H92nP8VpzvjRrRod2j/XwR5L1yUv1Oqp2zE6VLKyRqSO+qD4+FOuxk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771910017; c=relaxed/simple;
	bh=J3Z45TFc8/iUFPhe7JBqb6mewr1IvDu0lwyrWmiCk24=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MzfNCvDVP4Aut8n9p4Vdn06H07qI2eViGGyzv62W3UrARdZSwoIlgCWdUxpIbVYdw+sJXcyyD452UanG2lOM0ed4XIox25GWtFx5MJycehsP1QCm/sga3AShPaKmd23q8PqmsnoDJUTRUpNXy5f1UoeAHpHD50vxiAGNHW5tSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HZfxlm7h; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NEpT8m1503389;
	Mon, 23 Feb 2026 20:52:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=kEKfqNeAM2sDPck+EYSB9j5
	92HYqcFpZpunmGD4OmR8=; b=HZfxlm7huhTpMce6I7xxTiicNi+YeIWfUFX9++b
	NEUSv43SmWuN4knHhsnkL4uneE884Sqp0sO5D4SCnikFYWFX3QqeAHHXTU5FFhJB
	5GCh922/APuWm0K3eFyiZgp7tsZnMf19Rl9awgoi+qwwGfC7qVPS1N/0T6AENNrl
	DpL14OwmNvhV7cxB4rIKR8LyOgRD+IhHnpXGUalYIXROZ8bUfgOl4L0jo4hQt0aU
	7ZiRzXTawExPJT4ZNX1OmiYfCxw9g6JPHDnpjTZJxCmoKnsrlhhwHNCQix3gOCUE
	fDNzb/BPlMMJebQwmoWRzO5nZB8AW5MOu5bQJB4Ey0clLyg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cg1ubbtk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 20:52:55 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Feb 2026 20:52:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 23 Feb 2026 20:52:53 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 3E0273F70C4;
	Mon, 23 Feb 2026 20:52:50 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>
CC: <pabeni@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <ndabilpuram@marvell.com>, <kshankar@marvell.com>,
        <schalla@marvell.com>, <stable@vger.kernel.org>
Subject: [PATCH net,v4,1/2] virtio_net: Improve RSS key size validation and use NETDEV_RSS_KEY_LEN
Date: Tue, 24 Feb 2026 10:22:48 +0530
Message-ID: <20260224045249.933178-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=P7Y3RyAu c=1 sm=1 tr=0 ts=699d2ea7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=WvS6aQ_piSL3sVsHHQ4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: zri5ZNkkPnbjVj6E_0jTIhWJb2r3Is--
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAzOCBTYWx0ZWRfXypwqFyEcXtCI
 qImKS2tuOS1rMV/GbP7RiaDrjHuuNaxp9T0UvPBNaP2OVtlpk9KexK4A3J01pgikdLPRBJqNL6P
 xJFUkLOXHtyR5OcJt5aZjWTuVCvCHbE7vX8/iMOo5Ewc8a+kFvQu5TD2X0Z4DeYKjzYqwJ1BUbl
 KHCKUL6j8DoYRULfAoTCbP12xHawdjCLkkYMFzxHYDSR44bYGjmLPArTcWNj8+ACdUiumQh8zOx
 KY/7KE2cog5oowZM+TgG2xPNuQ5wZoFlXl/7R9B5KY+ehbo3/i8ohXy3tWIgx5VZKsguNg/QaCN
 EjYef43KKHXWaZeWT6PKyqrxRp008apMTfd3/FlUZDYT1HnYFKRbygPArOvvRbbdytwpxXOvkto
 6UquCvq4rQPWTyn6DSwRoeV/zBOCSA3YwKtu9x9MW84m1hJ0gywRc9Zyk7/JaMk00YVeBTuNnAJ
 XY+8yWUcBCAhQH/9Rng==
X-Proofpoint-GUID: zri5ZNkkPnbjVj6E_0jTIhWJb2r3Is--
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217860-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:mid,marvell.com:dkim,marvell.com:email];
	DKIM_TRACE(0.00)[marvell.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 179B5181D3C
X-Rspamd-Action: no action

Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
align with kernel's standard RSS key length. Add validation for RSS
key size against spec minimum (40 bytes) and driver maximum. When
validation fails, gracefully disable RSS features and continue
initialization rather than failing completely.

Cc: stable@vger.kernel.org
Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
Signed-off-by: Srujana Challa <schalla@marvell.com>

v3:
- Moved RSS key validation checks to virtnet_validate.
- Add fixes: tag and CC -stable
v4:
- Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key size.

---
 drivers/net/virtio_net.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..eeefe8abc122 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -381,8 +381,6 @@ struct receive_queue {
 	struct xdp_buff **xsk_buffs;
 };
 
-#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
-
 /* Control VQ buffers: protected by the rtnl lock */
 struct control_buf {
 	struct virtio_net_ctrl_hdr hdr;
@@ -486,7 +484,7 @@ struct virtnet_info {
 
 	/* Must be last as it ends in a flexible-array member. */
 	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
-		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
 	);
 };
 static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
@@ -6627,6 +6625,29 @@ static int virtnet_validate(struct virtio_device *vdev)
 		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
 	}
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS) ||
+	    virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT)) {
+		u8 key_sz = virtio_cread8(vdev,
+					  offsetof(struct virtio_net_config,
+						   rss_max_key_size));
+		/* Spec requires at least 40 bytes */
+#define VIRTIO_NET_RSS_MIN_KEY_SIZE 40
+		if (key_sz < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
+			dev_warn(&vdev->dev,
+				 "rss_max_key_size=%u is less than spec minimum %u, disabling RSS\n",
+				 key_sz, VIRTIO_NET_RSS_MIN_KEY_SIZE);
+			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
+			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
+		}
+		if (key_sz > NETDEV_RSS_KEY_LEN) {
+			dev_warn(&vdev->dev,
+				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
+				 key_sz, NETDEV_RSS_KEY_LEN);
+			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
+			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
+		}
+	}
+
 	return 0;
 }
 
@@ -6839,13 +6860,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
-		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
-			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
-				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
-			err = -EINVAL;
-			goto free;
-		}
-
 		vi->rss_hash_types_supported =
 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
 		vi->rss_hash_types_supported &=
-- 
2.25.1


