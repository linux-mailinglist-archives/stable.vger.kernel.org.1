Return-Path: <stable+bounces-211677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAN1NRrMd2mxlQEAu9opvQ
	(envelope-from <stable+bounces-211677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:18:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 625388CF62
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 869BD30136B2
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 20:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4252D4801;
	Mon, 26 Jan 2026 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SQRReAaq"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1112D47F1
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458708; cv=none; b=jfDPkcypLdlSEdUjM/FwML2uRjC3BddesE6I2ZLWkHH/2maaJ92LFd+JkXE8hbRj3znKIobXYClelZmwdNJv0mDsJwIcZws2eB/+Jfju8ttHItTg3dIH80dFCxns+OY0zpE0ABIpQKlIk4ghZ32FhX4gxr35zws+WeIJqSloU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458708; c=relaxed/simple;
	bh=b8OcfD7nliKQ/Xkwr5gOLzexLU9FIXBf9qR1upf6lL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fi8/gkTAyXVW+D6etD0Ey1NwvCioUFex2zCqaMnUDZJC/PjoDC2G5Z6/khi0uoy6LIU3mqkL1HuEHeLG1PvHiS1wh2+pfINlzzHZy+XoE4R5SxsbESYbjZzapsBPRFNfMFhmvczG+0OUmQsYZeygNs5klti7g3G6zSg2btP0kMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SQRReAaq; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D6OIrubXhXdHNR1IjA6s51rb7fHOmEamw7acVPSL5pA=; b=SQRReAaqlBo1Dsm2IpnyNQEbG2
	qYkujlmsfxItjj7/EDV2ucdfDUmHrdpWJ/q6u4rQWhfUxS72qDm0CviQRCYveOLXvMxkJOAPr5ryN
	WDKZ35pIl3WI097ptAH3U+RA4kQEXLOZAPsrtaByFBrRUWdinyspJbpReJaPFYQ0Z1fsHVMB9FGJV
	3frVIYXZY4ZW25GA4dofuwH95yAriP5koG5LrupI7SGkVVjF3NkEnDF8NhaPcwSED9mI8X/9dy4y4
	JeowEhXWZXehr4cWoVnfuiF6TgvMJOpKTMJwiD88ooJGVyMEhxpoZdNUauv1n4hMEbR57RVRVYmET
	onEhnDLw==;
Received: from 189-14-88-37.vmaxnet.com.br ([189.14.88.37] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vkT2N-00ABzB-IZ; Mon, 26 Jan 2026 21:18:15 +0100
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Mon, 26 Jan 2026 17:16:53 -0300
Subject: [PATCH 6.12 2/8] vsock/virtio: Rename virtio_vsock_alloc_skb()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-backport-vsock-nonlinear-skb-6-12-v1-2-ad5c34853a60@igalia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211677-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[halves@igalia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 625388CF62
X-Rspamd-Action: no action

From: Will Deacon <will@kernel.org>

[Upstream commit 2304c64a2866c58534560c63dc6e79d09b8f8d8d]

In preparation for nonlinear allocations for large SKBs, rename
virtio_vsock_alloc_skb() to virtio_vsock_alloc_linear_skb() to indicate
that it returns linear SKBs unconditionally and switch all callers over
to this new interface for now.

No functional change.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
Message-Id: <20250717090116.11987-6-will@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 drivers/vhost/vsock.c                   | 2 +-
 include/linux/virtio_vsock.h            | 3 ++-
 net/vmw_vsock/virtio_transport.c        | 2 +-
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 2589ee1f11e4..4127c8d2b3bd 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -349,7 +349,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return NULL;
 
 	/* len contains both payload and hdr */
-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
+	skb = virtio_vsock_alloc_linear_skb(len, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 879f1dfa7d3a..4504ea29ff82 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -52,7 +52,8 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
 	skb_put(skb, len);
 }
 
-static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
+static inline struct sk_buff *
+virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
 {
 	struct sk_buff *skb;
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 39f346890f7f..80dcf6ac1e72 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -316,7 +316,7 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 	vq = vsock->vqs[VSOCK_VQ_RX];
 
 	do {
-		skb = virtio_vsock_alloc_skb(total_len, GFP_KERNEL);
+		skb = virtio_vsock_alloc_linear_skb(total_len, GFP_KERNEL);
 		if (!skb)
 			break;
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 2c9b1011cdcc..bba183960e83 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -262,7 +262,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 	if (!zcopy)
 		skb_len += payload_len;
 
-	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
+	skb = virtio_vsock_alloc_linear_skb(skb_len, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 

-- 
2.52.0


