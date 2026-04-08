Return-Path: <stable+bounces-233785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA8QI/v81WkHAAgAu9opvQ
	(envelope-from <stable+bounces-233785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:00:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B83B7CF3
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73794301D09C
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCAF371884;
	Wed,  8 Apr 2026 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xerHGvCo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54630371866
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631609; cv=none; b=Voj99j8k+fI84975HThtlXdlv2nVP5LCy5qLdG2XUFm1xfVlRLJfjm0SC3zfquxQPpMgFhL2xFpJtzqi6kj4TRwlWM4xMqcDiV2pDvLdxttnlBO/825xaFs7BHmNuuyFrDWB8G/hDNoG7jOVSLZR5JQbLTy1di+6sKRTCnEBDHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631609; c=relaxed/simple;
	bh=DScemIoWksJWQlGHkO8DXbbxwisjYUqluWqI1yhCPso=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fLgdAbe3AZGDYdDjhrweyGoBA3+T42Cy3jQZdlAdc3MKuddEaV2wTU3K4BfhvOJK3pm/ChetOAU1ehRxqixD6xhkAvEsBTdUDkIXih4usxs2c8PltzoWSz4ndQjIBWhVcbwF3DMokDwm0FsqhTl6IglbDHpf6Kyk2gdCbWsNMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xerHGvCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF97C19424;
	Wed,  8 Apr 2026 07:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775631609;
	bh=DScemIoWksJWQlGHkO8DXbbxwisjYUqluWqI1yhCPso=;
	h=Subject:To:Cc:From:Date:From;
	b=xerHGvCohT79n5oZsvD3h++qDyJ1431GPNb0F6uRwF+ux1wwcp8Rn+clgw0BPfoXi
	 Fs7DR08xIYDKzzLwcYv9KnLICz66e30fIVMH5FK9jrKdS8luC+J0mAQ30yzcFoBNSo
	 YLHImnPW5cna3my3IeolXnUFxghHURp7Gh9qZUsg=
Subject: FAILED: patch "[PATCH] virtio_net: clamp rss_max_key_size to NETDEV_RSS_KEY_LEN" failed to apply to 6.6-stable tree
To: schalla@marvell.com,kuba@kernel.org,mst@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 08:59:56 +0200
Message-ID: <2026040856-until-anybody-3769@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233785-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 189B83B7CF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b4e5f04c58a29c499faa85d12952ca9a4faf1cb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040856-until-anybody-3769@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b4e5f04c58a29c499faa85d12952ca9a4faf1cb9 Mon Sep 17 00:00:00 2001
From: Srujana Challa <schalla@marvell.com>
Date: Thu, 26 Mar 2026 19:53:44 +0530
Subject: [PATCH] virtio_net: clamp rss_max_key_size to NETDEV_RSS_KEY_LEN

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

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ab2108ee206a..c0b9bc5574e2 100644
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
@@ -6708,6 +6706,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	struct virtnet_info *vi;
 	u16 max_queue_pairs;
 	int mtu = 0;
+	u16 key_sz;
 
 	/* Find if host supports multiqueue/rss virtio_net device */
 	max_queue_pairs = 1;
@@ -6842,14 +6841,13 @@ static int virtnet_probe(struct virtio_device *vdev)
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


