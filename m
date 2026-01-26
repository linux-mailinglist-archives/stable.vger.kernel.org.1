Return-Path: <stable+bounces-211684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF+lHCjMd2mxlQEAu9opvQ
	(envelope-from <stable+bounces-211684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:18:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EE08CF86
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE24F301752A
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0AB2D4813;
	Mon, 26 Jan 2026 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YC6QcN+O"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A502D47F1
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458725; cv=none; b=ElouPb9O0ezNR06NX1VtodNSN8XSYH/so2fRpzEkTPb0d95Ba+A/aZ2mEcajtiOsOyPiuFj28MBDor3lqVpgXzzqpWwyi6uf0khMCYJXX/7Dx38mjg5m8ygoISygxhmvduB9gZ+IVG7WOkgnREt8u/x4/8/Cc/1FvUbp5ppT30Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458725; c=relaxed/simple;
	bh=VZp7xa0mIXCmPVlS8YcaxDyDPCJ7nuQa/bF6NdBrSaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWMWUX0/kBYCIPxbOhu+h8aHrdGUo6Dd7NOkUDwfFGFiNsxgxJvOv9/oRXMlBeCv6BKEXrg0tlOFa7zmLhfOCGomaU5GfAMSdpdIZxE3GVJGFIdjNWPRPjrMi7tjcuuwFF9qxU0EvbBm1c4VyPCMLsNYr2pfnCLdyKEODNCEiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YC6QcN+O; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xVN6LEoRO8REgde0wKtQMdNkB3s1eL5lWhDxSXw/Jsk=; b=YC6QcN+OQVnvYUvL5T/m8EGN4w
	3OPphn9HDsEdUt/VOz54Br5BJlV916DHILgbLolLpqTNiduR6cMIpBDMyYRLS/8Pt3X8LbEnKvqfi
	ChsSnJTNywrcSEfpcQunRcQCzOwqpNCWBX9ApqRAVtJ5deJ4SPviMSGcpWcZMXkuqBpKi7dYowAa6
	3BYjrl8qmj567t5FoWO5Eookz87gq00bVtkd9npLKcjBJ+wwSwSWVkl5xbmpI+kS5FvV855cfhhn2
	u/791gBNTeJ76cg14ryGppVb2Rjw+ayLQ/PyKNxzyH+ISCFgIv5BFqVLz7HNYmuuHE71zuul2xogB
	b0gTcAqw==;
Received: from 189-14-88-37.vmaxnet.com.br ([189.14.88.37] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vkT2c-00ABzB-1B; Mon, 26 Jan 2026 21:18:30 +0100
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Mon, 26 Jan 2026 17:16:57 -0300
Subject: [PATCH 6.12 6/8] vsock/virtio: Allocate nonlinear SKBs for
 handling large transmit buffers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-backport-vsock-nonlinear-skb-6-12-v1-6-ad5c34853a60@igalia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211684-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[halves@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5EE08CF86
X-Rspamd-Action: no action

From: Will Deacon <will@kernel.org>

[Upstream commit 6693731487a8145a9b039bc983d77edc47693855]

When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
transmit data. Unfortunately, these are always linear allocations and
can therefore result in significant pressure on kmalloc() considering
that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
allocation for each packet.

Rework the vsock SKB allocation so that, for sizes with page order
greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
instead with the packet header in the SKB and the transmit data in the
fragments. Note that this affects both the vhost and virtio transports.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
Message-Id: <20250717090116.11987-10-will@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index bba183960e83..abfadd7e1342 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -110,7 +110,8 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
 					       &info->msg->msg_iter,
 					       len);
 
-	return memcpy_from_msg(skb_put(skb, len), info->msg, len);
+	virtio_vsock_skb_put(skb, len);
+	return skb_copy_datagram_from_iter(skb, 0, &info->msg->msg_iter, len);
 }
 
 static void virtio_transport_init_hdr(struct sk_buff *skb,
@@ -262,7 +263,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 	if (!zcopy)
 		skb_len += payload_len;
 
-	skb = virtio_vsock_alloc_linear_skb(skb_len, GFP_KERNEL);
+	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 

-- 
2.52.0


