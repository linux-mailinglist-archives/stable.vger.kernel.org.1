Return-Path: <stable+bounces-211683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA43ID7Md2mxlQEAu9opvQ
	(envelope-from <stable+bounces-211683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:19:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2988CFAC
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCFEE3028EF4
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 20:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A11F2D3EC1;
	Mon, 26 Jan 2026 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="F1Pndd0L"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F22D47F1
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458723; cv=none; b=o0U1Cbh+zlqxntfItuaCF7JlE7h4FMHil5p7dBVigcFwSMMyeAyBkKFr0pOmeIfpQpWEHGVew0cPcJmN+zlKBXe9nKxuA7qbe5ylG0o9N4oZEikAkgVP3O62ejsdgfQUXdC6Q1sms4lqinDGXEsiKY5+6O0OAdPQq1Vt0eUHdcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458723; c=relaxed/simple;
	bh=+kl5bo8CdJvOeYhnxhptjCD6QSocahmm7dLjZjHoqKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rFltevW/dlsgPPx+Np52lS35M3x+tdcf/KfrsLxMTYzPSecHsQsg789QN2ulRLIXdwIq/r8ob6Vqtzbj43tjJriusJXCS00aJRqcUs8E7jXuyAls+XD13Ug44s/ZLwjLTVbWja2jqIc8N4NofYDlVG63AP0T/MKmsIos6lRkynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=F1Pndd0L; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QWL9+kYdqQX+nJs4Wbr2IgaqZrbOxVfXPy6BoQEHRrA=; b=F1Pndd0Ldi4MYVcGOSgdUYvPyx
	eoIIMtzluKb1X6A2C33rajozjxqNSqJE/YDFGpp8WuEcB6wo4ebP4JL7/TYjTjC5LFLXMX1xh6ICR
	QHJ7onrAY9TMnchm4oDdCWaGJM4sLLehhoDEHGiAKFqrycjn3xuVi6IzDVOH+nbbenkfB8pW+Rm6b
	WJSKrPuqRvEt+wybTJWMlvZ4MBYZj0fEn4FYH+O+QcnhS61d43jvQXQOXgQmlRd3zRgxGJ1Endckf
	AcJ7Pdt7gQgLMo5r+OKLQtC1ylXRNMDz+C2tZRCcU7rEEcuo+aNhk8DMs77b9ObbjHn1/wt6pKRUr
	Kzj/wNMg==;
Received: from 189-14-88-37.vmaxnet.com.br ([189.14.88.37] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vkT2g-00ABzB-2H; Mon, 26 Jan 2026 21:18:34 +0100
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Mon, 26 Jan 2026 17:16:58 -0300
Subject: [PATCH 6.12 7/8] net: Introduce skb_copy_datagram_from_iter_full()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-backport-vsock-nonlinear-skb-6-12-v1-7-ad5c34853a60@igalia.com>
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
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>
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
	TAGGED_FROM(0.00)[bounces-211683-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[halves@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: AA2988CFAC
X-Rspamd-Action: no action

From: Will Deacon <will@kernel.org>

[Upstream commit b08a784a5d1495c42ff9b0c70887d49211cddfe0]

In a similar manner to copy_from_iter()/copy_from_iter_full(), introduce
skb_copy_datagram_from_iter_full() which reverts the iterator to its
initial state when returning an error.

A subsequent fix for a vsock regression will make use of this new
function.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Will Deacon <will@kernel.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://patch.msgid.link/20250818180355.29275-2-will@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 include/linux/skbuff.h |  2 ++
 net/core/datagram.c    | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 314328ab0b84..1e07a5460203 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4117,6 +4117,8 @@ int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 			   struct ahash_request *hash);
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
+int skb_copy_datagram_from_iter_full(struct sk_buff *skb, int offset,
+				     struct iov_iter *from, int len);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
 void skb_free_datagram(struct sock *sk, struct sk_buff *skb);
 int skb_kill_datagram(struct sock *sk, struct sk_buff *skb, unsigned int flags);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index f0693707aece..79b5fea329c9 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -621,6 +621,20 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 }
 EXPORT_SYMBOL(skb_copy_datagram_from_iter);
 
+int skb_copy_datagram_from_iter_full(struct sk_buff *skb, int offset,
+				     struct iov_iter *from, int len)
+{
+	struct iov_iter_state state;
+	int ret;
+
+	iov_iter_save_state(from, &state);
+	ret = skb_copy_datagram_from_iter(skb, offset, from, len);
+	if (ret)
+		iov_iter_restore(from, &state);
+	return ret;
+}
+EXPORT_SYMBOL(skb_copy_datagram_from_iter_full);
+
 int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 				struct iov_iter *from, size_t length)
 {

-- 
2.52.0


