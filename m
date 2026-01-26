Return-Path: <stable+bounces-211681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOHWFTnMd2mxlQEAu9opvQ
	(envelope-from <stable+bounces-211681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:19:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D929E8CF96
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFB9A3027B74
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCE82D5410;
	Mon, 26 Jan 2026 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZykBSOu7"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078AE2D5926
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458719; cv=none; b=YDfiwjEoLVWq3MYnSXUejW1i8jZ8LcLgJS/hATXWaBD6Z7dPORk3pgz51pan5mrJj9/QEZp6rQyEHmRi4QyuhvdDOlOGOL085zBSGAWqWZGYalutCOKmjExQ+rPGZsn4+L5GO6gjKXYb0cXwwcsnUH01RqK0riWUFrQBITCcR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458719; c=relaxed/simple;
	bh=fDRtHUgA1WogFs0L2DQ5EPvK18hMUjyrIfqGXtN+/fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PmqMN7HmOnNLz9YUCPpLjzvXdyoV/4nXUSPhY/bWdk/sclOP3g3PEoBxh1jjEJncaFImc8p/lexj/oTXLsbP2fG3rZmn10+0AywchgvHlOlve9GJ43U98x2HRqoEuBnRd4zn927L7Gc0ECn9TCs5q1CfcFzgnqTNLtvOVssxCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZykBSOu7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ddXbmcOLsGFI7416xxlpgvGQdhDpt9oRVmp6dAYkNEE=; b=ZykBSOu7WKcVnwP6wGGfLnrX39
	bcxdo7O6Pf89BaG3+VuwKYxfdg/9/oRQgz5SD9zLcmlCPyYpKAxVFvB7zYCMOXtJ2A3zmmdvY4wSk
	fEveRHQ5HAoUW8AJ3ajM2AF72T4G+DE/w356tfSS32AKgWkF/pMRXgoUwXP4OeOyEP5XSeJnhZhaJ
	OfhGpPJLza1SlFOeHRb281zR6HXy+FqM9G7jhj2gVsvSCgG+V21DXuoBPc8pNZ5gCQskTieyOlKdw
	G8vQSnhhjRsZXvmJ/x8Ji0+jukuAufVW6AeFn/VZ98cx09k7w/4TVJTBH0Cg5U6+kI257TnCRvApz
	zS1qDgdw==;
Received: from 189-14-88-37.vmaxnet.com.br ([189.14.88.37] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vkT2U-00ABzB-Pl; Mon, 26 Jan 2026 21:18:23 +0100
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Mon, 26 Jan 2026 17:16:55 -0300
Subject: [PATCH 6.12 4/8] vsock/virtio: Rename virtio_vsock_skb_rx_put()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-backport-vsock-nonlinear-skb-6-12-v1-4-ad5c34853a60@igalia.com>
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
	TAGGED_FROM(0.00)[bounces-211681-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: D929E8CF96
X-Rspamd-Action: no action

From: Will Deacon <will@kernel.org>

[Upstream commit 8ca76151d2c8219edea82f1925a2a25907ff6a9d]

In preparation for using virtio_vsock_skb_rx_put() when populating SKBs
on the vsock TX path, rename virtio_vsock_skb_rx_put() to
virtio_vsock_skb_put().

No functional change.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
Message-Id: <20250717090116.11987-9-will@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 drivers/vhost/vsock.c            | 2 +-
 include/linux/virtio_vsock.h     | 2 +-
 net/vmw_vsock/virtio_transport.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index d351915e1a02..6373b6d6d65d 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -377,7 +377,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return NULL;
 	}
 
-	virtio_vsock_skb_rx_put(skb, payload_len);
+	virtio_vsock_skb_put(skb, payload_len);
 
 	nbytes = copy_from_iter(skb->data, payload_len, &iov_iter);
 	if (nbytes != payload_len) {
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 36dd0cd55368..39c818b4a057 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -47,7 +47,7 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
 	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
 }
 
-static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
+static inline void virtio_vsock_skb_put(struct sk_buff *skb, u32 len)
 {
 	skb_put(skb, len);
 }
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 80dcf6ac1e72..b6569b0ca2bb 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -657,7 +657,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			}
 
 			if (payload_len)
-				virtio_vsock_skb_rx_put(skb, payload_len);
+				virtio_vsock_skb_put(skb, payload_len);
 
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);

-- 
2.52.0


