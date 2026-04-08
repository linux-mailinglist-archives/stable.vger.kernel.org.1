Return-Path: <stable+bounces-233902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAzZHnJX1mn5DwgAu9opvQ
	(envelope-from <stable+bounces-233902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:26:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB073BCD0D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F025330AABF6
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A0B2F3614;
	Wed,  8 Apr 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8E2XfXP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03B02F39B4
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775654349; cv=none; b=tKmsOB5O31QoTWBmPopac5n5AYcuywkgr+fSknUKxBKfBdyxFK+cC6kralOO45m3ZIa/JrzaLR8E0nLMNZTRnp7ZJyxA+DDgNsOtsXKaP6glC65b2sjp8IAssg3gBXi65U1AyYn/+Ip7J4j5TjymmYwhr3RFnCkjEYr7G4o6nnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775654349; c=relaxed/simple;
	bh=HHENBX0XTdaDZkWSxFMYCNOYKV6RcGg2yxPh3geVUKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDw7tsSGVH3mYrKLBHQI7dUMHg4TYgDnx/QWL1qJAl++IYUAFPLCvlsDZ1Q/Ndfwt/04R+enXzr0P4GuwAri+TtMz9tEN2bGDiOex/8wgmvnvyf0mjsO+u+TA37j9tmuN80TzbRFLkWFeX03SYE5B1T5WYgcqUgDJA0hy9p4U/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8E2XfXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C98C19424;
	Wed,  8 Apr 2026 13:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775654349;
	bh=HHENBX0XTdaDZkWSxFMYCNOYKV6RcGg2yxPh3geVUKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8E2XfXPOot5cKsgkkKX3ouAwOp+dgAYxRAHvqBcFh8AEN1PkkmgCKhLEDYv6sx6s
	 +pZHGOHnnT2KYiVEhm4HUT46PBLGT6lfk4tXdsxOqcPpDQooT1KxNgmFHRUBlKjex2
	 NvcmgtgmqegYohel4jTMvi57VgvwpGcNJWC99Ev1UJq/9aQDXbbUBoZJ80Fd/7t3fX
	 VTcGliUJbI3dexJi0yRD1OBqBkR4SKGLk5P6GKQYD3jbxXFzprvkpxWlWifVqjI0RP
	 eRfDLtWOOZAiYPaoQOnf6t94Zegon8wsyx2Ky2lViif9d0EJi2bMk2bMWZCmz0ym2G
	 WmJxGnVrLtSCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srujana Challa <schalla@marvell.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] virtio_net: clamp rss_max_key_size to NETDEV_RSS_KEY_LEN
Date: Wed,  8 Apr 2026 09:19:06 -0400
Message-ID: <20260408131906.1087303-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040855-hatless-marbled-c4ed@gregkh>
References: <2026040855-hatless-marbled-c4ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233902-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: CEB073BCD0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Srujana Challa <schalla@marvell.com>

[ Upstream commit b4e5f04c58a29c499faa85d12952ca9a4faf1cb9 ]

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
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://patch.msgid.link/20260326142344.1171317-1-schalla@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ changed clamp target from NETDEV_RSS_KEY_LEN to VIRTIO_NET_RSS_MAX_KEY_SIZE ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5c83983f0eb3f..5a31ccdae2e22 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6502,6 +6502,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	struct virtnet_info *vi;
 	u16 max_queue_pairs;
 	int mtu = 0;
+	u16 key_sz;
 
 	/* Find if host supports multiqueue/rss virtio_net device */
 	max_queue_pairs = 1;
@@ -6624,14 +6625,13 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free;
 
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
+		vi->rss_key_size = min_t(u16, key_sz, VIRTIO_NET_RSS_MAX_KEY_SIZE);
+		if (key_sz > vi->rss_key_size)
+			dev_warn(&vdev->dev,
+				 "rss_max_key_size=%u exceeds driver limit %u, clamping\n",
+				 key_sz, vi->rss_key_size);
 
 		vi->rss_hash_types_supported =
 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
-- 
2.53.0


