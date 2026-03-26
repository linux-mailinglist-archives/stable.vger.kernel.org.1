Return-Path: <stable+bounces-230472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OInrIKpDxWkU8wQAu9opvQ
	(envelope-from <stable+bounces-230472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:33:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BD1336D50
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DD2A31AB7E4
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333E4285C88;
	Thu, 26 Mar 2026 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="B86RCfia"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67BB1A3029;
	Thu, 26 Mar 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535048; cv=none; b=M6YQge/JUNqsWKBRWV727B/DCTdIK6Iub/0xYwG1v6zOjt/o41pFClAX5U/ql09PO1Ejpvqp34dbz8MXRAJHH1sW/akgIapR5Hhadeb+yTYXrN0dl/WgG4R6vE5SZw/R3+hJCxdJRnCNZh+sqG6UubaDW1VFbxdVKW3VnjWtIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535048; c=relaxed/simple;
	bh=1WjDEFYQ6g3yPDoaJcLh1uifQ/JIp50+93poSdvKpEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=exEgj04sbVA+0k5YkQPRsrk5kyYkfef+J3zWxrniMvO6RyEHEDJ5xoS6KBiq4ESCCWUfM251eIa+JditAbiGPVoMFZDLKlE7FfdfSdYV/htq5rF0rsI07xznAbSQk2ovHWCwITdTOHpR7wfy4OFgxVjAOQpJszIyLV+ej0Dv2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=B86RCfia; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q72wWC3460647;
	Thu, 26 Mar 2026 07:23:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=B3YvpA0Aly9tBY2HK1OtTRO
	vqY4jw+STba23l+LW2M0=; b=B86RCfiaCV1AxdWNE62pX+m+W7wudW6F2jx4Uvo
	v/IpAND6FjGJvh3eGnib4tLjkUwqhZoWY0MQjj21KYabEv9qqJF++rmW0LCULM3U
	R+BBR7DRUc8ucAvKB3mDlLK4WxNHJbQFuijocTlNrXOhWrp/Vu/jpZsWlmVBxqIy
	SiQNEWfVHldcZ5S6bmeHhPxKoRxiMlV0hwE/HeneavWQgwvxG6LJ2HpjnMIvzv84
	O917kOreCqlB8OrPiQBDfEDHcluWunKKYaKNfGzYRZZBonfRt4zXSrRZzFX2vPiN
	aLCP6MtjNx5Bn/s4JWbHnEtruP2161ZqfuklXceQ7+BueFQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d4b7hc6ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 07:23:52 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Mar 2026 07:23:51 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Mar 2026 07:23:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Mar 2026 07:23:50 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id ADFBE3F706D;
	Thu, 26 Mar 2026 07:23:45 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>
CC: <pabeni@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <ndabilpuram@marvell.com>, <kshankar@marvell.com>,
        <schalla@marvell.com>, <stable@vger.kernel.org>
Subject: [PATCH net,v5] virtio_net: clamp rss_max_key_size to NETDEV_RSS_KEY_LEN
Date: Thu, 26 Mar 2026 19:53:44 +0530
Message-ID: <20260326142344.1171317-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=b4q/I9Gx c=1 sm=1 tr=0 ts=69c54178 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=hiWoBk9w0w8mUrHqcNwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 8zcCUThkkFwxIocBPR-Vy4uLlQN38fKQ
X-Proofpoint-GUID: 8zcCUThkkFwxIocBPR-Vy4uLlQN38fKQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEwMCBTYWx0ZWRfX+4EB72cMh9Dl
 0gs0eCvqhqJf+i3NkrzfK/DU977l/sMdn6lcOb/yVHwLBjPRWzI4cy/eBbtFghSFaAz8TmP0HX+
 +dcZ2hePpBCOZMwpzGQeoQQ8S9z5OekwT0BNzo2l31Vc9zpgLfFG2JxzaUqhBrKHiDQnug2j7YL
 PKjZR168WDNuqG5hAwW07DM1fW94F2fA4DhPgJrYvPUo3H5gs9qXA2af6u6HDDD14hP9m4MKUC7
 yQstUavBVabCs0J+BR1fNtathd3gm7t0mS1lqMsSPChz9bMZ9EjOJXaB2iULkvFbI7wEpo2i0el
 kYwdh56DglFiUfQsiQ2FFGs3nMwtSQ47whS6yDg77Ug0bxtiQdTczF6wiw9ftcsFL/jfOHptzBQ
 OJjpevhhidpBdQFCCs0ov5z9iDoLLDGhEn9sxXqaThlutpKOIM5BnDvI6+ukknyGCe/Yvm0rlWL
 dd2SyR6Pe/k4Lmp747Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230472-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[marvell.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 03BD1336D50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rss_max_key_size in the virtio spec is the maximum key size supported by
the device, not a mandatory size the driver must use. Also the value 40
is a spec minimum, not a spec maximum.

The current code rejects RSS and can fail probe when the device reports a
larger rss_max_key_size than the driver buffer limit. Instead, clamp the
effective key length to min(device rss_max_key_size, NETDEV_RSS_KEY_LEN)
and keep RSS enabled.

This keeps probe working on devices that advertise larger maximum key sizes
while respecting the netdev RSS key buffer size limit.

Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
Cc: stable@vger.kernel.org
Signed-off-by: Srujana Challa <schalla@marvell.com>
---
v3:
- Moved RSS key validation checks to virtnet_validate.
- Add fixes: tag and CC -stable
v4:
- Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key size.
v5:
- Interpret rss_max_key_size as a maximum and clamp it to NETDEV_RSS_KEY_LEN.
- Do not disable RSS/HASH_REPORT when device rss_max_key_size exceeds NETDEV_RSS_KEY_LEN.
- Drop the separate patch that replaced the runtime check with BUILD_BUG_ON.

 drivers/net/virtio_net.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 022f60728721..b241c8dbb4e1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -373,8 +373,6 @@ struct receive_queue {
 	struct xdp_buff **xsk_buffs;
 };
 
-#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
-
 /* Control VQ buffers: protected by the rtnl lock */
 struct control_buf {
 	struct virtio_net_ctrl_hdr hdr;
@@ -478,7 +476,7 @@ struct virtnet_info {
 
 	/* Must be last as it ends in a flexible-array member. */
 	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
-		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
 	);
 };
 static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
@@ -6717,6 +6715,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	struct virtnet_info *vi;
 	u16 max_queue_pairs;
 	int mtu = 0;
+	u16 key_sz;
 
 	/* Find if host supports multiqueue/rss virtio_net device */
 	max_queue_pairs = 1;
@@ -6851,14 +6850,13 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 
 	if (vi->has_rss || vi->has_rss_hash_report) {
-		vi->rss_key_size =
-			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
-		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
-			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
-				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
-			err = -EINVAL;
-			goto free;
-		}
+		key_sz = virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
+
+		vi->rss_key_size = min_t(u16, key_sz, NETDEV_RSS_KEY_LEN);
+		if (key_sz > vi->rss_key_size)
+			dev_warn(&vdev->dev,
+				 "rss_max_key_size=%u exceeds driver limit %u, clamping\n",
+				 key_sz, vi->rss_key_size);
 
 		vi->rss_hash_types_supported =
 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
-- 
2.25.1


