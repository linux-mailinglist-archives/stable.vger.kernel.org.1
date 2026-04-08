Return-Path: <stable+bounces-233908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIVDM8Bb1mmNEggAu9opvQ
	(envelope-from <stable+bounces-233908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:44:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B383BD1E1
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8054A306F5E3
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD863C9EE8;
	Wed,  8 Apr 2026 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb4Ue7eg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F13AEF4D
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655564; cv=none; b=LlpR8G20vC8jTbhEVraHarzm7slu1eB+c+cjvqInpz+5oT3RJi0s7/QWjwnr3yPZJqKQiA8fU3IxO4aruPWgYCfncbb18nGm2MCO5FAGYqlRzf7cyw6eXvIwuXbr72CMxfuXHHHEAAFpmfH/qDmwmxF7ux1PFM0AxXLLD5dhsXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655564; c=relaxed/simple;
	bh=VUgmsahK51dNWv/faRJdU7qhNO1K1vnpUdnASSjVgfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLq/0+flw03XdsYIkQm2HipNw3x4KfX61nI1q15/Ccths6UKuTC2sgkudq3prYN5WGDKhAWM+a0rS/EV8A/vFsEbqhIhEHb+Zv/geLhh1dumJw71CRX+3WzIWsFazklBYkdF8/jzrj/sHGAf5GElVXBJQChwVVWvykW1ng8eZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb4Ue7eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5B1C19421;
	Wed,  8 Apr 2026 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775655564;
	bh=VUgmsahK51dNWv/faRJdU7qhNO1K1vnpUdnASSjVgfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sb4Ue7eguoJX3t2nV9WqyPM+aq4CfiWzrPJDnLqdZWFuqLYcbp+VKp+B16tfCBSr5
	 5GT1PeOaOlTGSjrikZ75z/hbox0am84t6AxI8Oo6A9N/XPNQogzTbQvzskQM1Z2dlu
	 7XQDD8yKq5ToP0S7lUk45InjQAJfchNugNS0qWK1MR5H0mdOrPvtJ2u9Obz2dLxGZl
	 FijN/dfpEd44/lSsjQ3hZFP8MT068VAIj9rEpFXkqKdr5UxUEPhecasl7RtyfCY4lD
	 AAJwlCV+A3gvG8tg+pfaHmbgi0EXsDBIiDb1hLpeLnWfRVs/2pMnMYrCl0qxGjYrev
	 VTQRuuYUQY4Rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srujana Challa <schalla@marvell.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] virtio_net: clamp rss_max_key_size to NETDEV_RSS_KEY_LEN
Date: Wed,  8 Apr 2026 09:39:21 -0400
Message-ID: <20260408133921.1094528-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040856-until-anybody-3769@gregkh>
References: <2026040856-until-anybody-3769@gregkh>
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
	TAGGED_FROM(0.00)[bounces-233908-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 58B383BD1E1
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
index b33fc94ebd772..33f61922c1399 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4465,6 +4465,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	struct virtnet_info *vi;
 	u16 max_queue_pairs;
 	int mtu = 0;
+	u16 key_sz;
 
 	/* Find if host supports multiqueue/rss virtio_net device */
 	max_queue_pairs = 1;
@@ -4589,14 +4590,13 @@ static int virtnet_probe(struct virtio_device *vdev)
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
+		vi->rss_key_size = min_t(u16, key_sz, VIRTIO_NET_RSS_MAX_KEY_SIZE);
+		if (key_sz > vi->rss_key_size)
+			dev_warn(&vdev->dev,
+				 "rss_max_key_size=%u exceeds driver limit %u, clamping\n",
+				 key_sz, vi->rss_key_size);
 
 		vi->rss_hash_types_supported =
 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
-- 
2.53.0


