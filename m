Return-Path: <stable+bounces-211685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKAqMEXMd2mxlQEAu9opvQ
	(envelope-from <stable+bounces-211685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:19:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA6A8CFB3
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F19753014109
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 20:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6534F2D4801;
	Mon, 26 Jan 2026 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XVwxOPlJ"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF72D3EC1
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458733; cv=none; b=WGXp8hDdL+oY71bihOIy1douldIx4q2MSpXkYMTXyjrKcpns8Y01FXFB93kyb+cLknXULAfsmUrcfQM7qgmb2A5ig7FQEvPx6gmLX3VzwHi8Q6VSCzbBadB6sL8OuWGBxCnm1AY8eRMS7N0sDZAcAHSq2t2RWihxwHCvSalXTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458733; c=relaxed/simple;
	bh=Zd+5SIH+4+dxQmywBFranV7CBm2epdvZBZ/WRkr/jJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Savk4SSw1tD249mHDRtR1qtQ+kXIzbY/jOYLuY73PAq3oOduv7qHnWxlb5erny3p0yggsl+NrBlk9PppTs9ZQqRmf5o59YskndHX2j8E9jK7haogsCUu2SsPYLBRlMcScBCW8WrcDX/sYpbjHJ2tL1Hx/cMHSx/vZ0/C55Q44og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XVwxOPlJ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pWshMH4R0LoLMpt+o44KoBts8CZL0ReoJwzUW4ey3O4=; b=XVwxOPlJdJsgTyrUFeOjViws+j
	4+TrNfP4UD0v35o5/NBhkjphWCILTKhNDmrmYWZH5eu1Fmxkfw2LGn9bew0sqY8FW8RU8PPdeHCvQ
	CqzQXlNnQC9/DgJUC4dp8aZeCQ123Iyg+mekZpd87ByVVMQSovpCzm3rm3VCVF/Ng4kGw2ySC0EeG
	2Xb7Mmv7/Qh6IKIYlJJzsOiX2He9L01m8e5kW+J8tgKs2gGVMD/6tddTemkbIOKkXqTGXI/wZnOOQ
	RZRR/Ag7JVSr0cJuEPA1nYaYD3gwae3QAmfuSs+B0YRNI9N3EnfctS2w2137PHFhiQ5gfO104CD14
	IlIEBb6Q==;
Received: from 189-14-88-37.vmaxnet.com.br ([189.14.88.37] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vkT2j-00ABzB-SX; Mon, 26 Jan 2026 21:18:38 +0100
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Mon, 26 Jan 2026 17:16:59 -0300
Subject: [PATCH 6.12 8/8] vsock/virtio: Fix message iterator handling on
 transmit path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-backport-vsock-nonlinear-skb-6-12-v1-8-ad5c34853a60@igalia.com>
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
Cc: kernel-dev@igalia.com, Heitor Alves de Siqueira <halves@igalia.com>, 
 syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211685-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[halves@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,b4d960daf7a3c7c2b7b1];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DA6A8CFB3
X-Rspamd-Action: no action

From: Will Deacon <will@kernel.org>

[Upstream commit 7fb1291257ea1e27dbc3f34c6a37b4d640aafdd7]

Commit 6693731487a8 ("vsock/virtio: Allocate nonlinear SKBs for handling
large transmit buffers") converted the virtio vsock transmit path to
utilise nonlinear SKBs when handling large buffers. As part of this
change, virtio_transport_fill_skb() was updated to call
skb_copy_datagram_from_iter() instead of memcpy_from_msg() as the latter
expects a single destination buffer and cannot handle nonlinear SKBs
correctly.

Unfortunately, during this conversion, I overlooked the error case when
the copying function returns -EFAULT due to a fault on the input buffer
in userspace. In this case, memcpy_from_msg() reverts the iterator to
its initial state thanks to copy_from_iter_full() whereas
skb_copy_datagram_from_iter() leaves the iterator partially advanced.
This results in a WARN_ONCE() from the vsock code, which expects the
iterator to stay in sync with the number of bytes transmitted so that
virtio_transport_send_pkt_info() can return -EFAULT when it is called
again:

  ------------[ cut here ]------------
  'send_pkt()' returns 0, but 65536 expected
  WARNING: CPU: 0 PID: 5503 at net/vmw_vsock/virtio_transport_common.c:428 virtio_transport_send_pkt_info+0xd11/0xf00 net/vmw_vsock/virtio_transport_common.c:426
  Modules linked in:
  CPU: 0 UID: 0 PID: 5503 Comm: syz.0.17 Not tainted 6.16.0-syzkaller-12063-g37816488247d #0 PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014

Call virtio_transport_fill_skb_full() to restore the previous iterator
behaviour.

Cc: Jason Wang <jasowang@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Fixes: 6693731487a8 ("vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers")
Reported-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com
Signed-off-by: Will Deacon <will@kernel.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://patch.msgid.link/20250818180355.29275-3-will@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[halves: adjust __zerocopy_sg_from_iter() parameters]
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 net/vmw_vsock/virtio_transport_common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index abfadd7e1342..535ca54652c4 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -105,13 +105,15 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
 				     size_t len,
 				     bool zcopy)
 {
+	struct msghdr *msg = info->msg;
+
 	if (zcopy)
-		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
-					       &info->msg->msg_iter,
+		return __zerocopy_sg_from_iter(msg, NULL, skb,
+					       &msg->msg_iter,
 					       len);
 
 	virtio_vsock_skb_put(skb, len);
-	return skb_copy_datagram_from_iter(skb, 0, &info->msg->msg_iter, len);
+	return skb_copy_datagram_from_iter_full(skb, 0, &msg->msg_iter, len);
 }
 
 static void virtio_transport_init_hdr(struct sk_buff *skb,

-- 
2.52.0


