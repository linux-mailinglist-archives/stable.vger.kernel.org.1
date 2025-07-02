Return-Path: <stable+bounces-159236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA5AAF1462
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 13:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B93B4E78FE
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC402676E6;
	Wed,  2 Jul 2025 11:45:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE841E520C;
	Wed,  2 Jul 2025 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456752; cv=none; b=DqXl94IEm6g/Yr7Uf476uVD1X3+KP1AzYRhZAUZN36IB08oa2fAXk+3dLYsriilDPmMSxIA+d2SRRMLvMfPHes08VkeQzEk8y1xMyoLs/Otb073aABaPvqtC7gkMX1ces1br3GiB30aezgsLEjA1u4gFBhlY1W0s3sZyjgMa+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456752; c=relaxed/simple;
	bh=9AuOxN1fLsFD/X58/PFQmlQF9iWSU+GWlT4u317PpB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvdRb1FEVYYuxVnEK5ctff89YQBcFFiKnfBFVBAcaNrIsNH50k8yNPQH86FUjaPFcdUwP7P3tqVyWy1FKrSk9SRu+CPIVapl6dWhwjU/l9x7FOsWUCpkWralTcKkYcbpOB5X7JtVhxJ/GDaAHXQp3DH9iZTDQJV0eiIyH7/l1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Received: from [2a0c:e303:0:7000:1adb:f2ff:fe4f:84eb] (port=48378 helo=karahi.gladserv.com)
	by bregans-0.gladserv.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(envelope-from <bacs@librecast.net>)
	id 1uWvn8-008bMu-2w;
	Wed, 02 Jul 2025 11:38:18 +0000
From: Brett A C Sheffield <bacs@librecast.net>
To: gregkh@linuxfoundation.org
Cc: regressions@lists.linux.dev,
	stable@vger.kernel.org,
	willemb@google.com,
	Brett A C Sheffield <bacs@librecast.net>
Subject: [PATCH 6.6.y] Revert "ipv6: save dontfrag in cork"
Date: Wed,  2 Jul 2025 13:37:32 +0200
Message-ID: <20250702113731.2322-2-bacs@librecast.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025070216-duplex-ecologist-20ce@gregkh>
References: <2025070216-duplex-ecologist-20ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brett A C Sheffield (Librecast) <bacs@librecast.net>

This reverts commit 8ebf2709fe4dcd0a1b7b95bf61e529ddcd3cdf51 which is
commit a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a upstream.

A regression was introduced when backporting this to the stable kernels
without applying previous commits in this series.

When sending IPv6 UDP packets larger than MTU, EMSGSIZE was returned
instead of fragmenting the packets as expected.

As there is no compelling reason for this commit to be present in the
stable kernels it should be reverted.

Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
---
 include/linux/ipv6.h  | 1 -
 net/ipv6/ip6_output.c | 9 ++++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index d79851c5fabd..af8a771a053c 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -199,7 +199,6 @@ struct inet6_cork {
 	struct ipv6_txoptions *opt;
 	u8 hop_limit;
 	u8 tclass;
-	u8 dontfrag:1;
 };
 
 /* struct ipv6_pinfo - ipv6 private area */
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 28777b142240..c86d5dca29df 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1452,7 +1452,6 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	}
 	v6_cork->hop_limit = ipc6->hlimit;
 	v6_cork->tclass = ipc6->tclass;
-	v6_cork->dontfrag = ipc6->dontfrag;
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
 		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
 		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
@@ -1486,7 +1485,7 @@ static int __ip6_append_data(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
 			     void *from, size_t length, int transhdrlen,
-			     unsigned int flags)
+			     unsigned int flags, struct ipcm6_cookie *ipc6)
 {
 	struct sk_buff *skb, *skb_prev = NULL;
 	struct inet_cork *cork = &cork_full->base;
@@ -1542,7 +1541,7 @@ static int __ip6_append_data(struct sock *sk,
 	if (headersize + transhdrlen > mtu)
 		goto emsgsize;
 
-	if (cork->length + length > mtu - headersize && v6_cork->dontfrag &&
+	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
 	    (sk->sk_protocol == IPPROTO_UDP ||
 	     sk->sk_protocol == IPPROTO_ICMPV6 ||
 	     sk->sk_protocol == IPPROTO_RAW)) {
@@ -1914,7 +1913,7 @@ int ip6_append_data(struct sock *sk,
 
 	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
 				 &np->cork, sk_page_frag(sk), getfrag,
-				 from, length, transhdrlen, flags);
+				 from, length, transhdrlen, flags, ipc6);
 }
 EXPORT_SYMBOL_GPL(ip6_append_data);
 
@@ -2119,7 +2118,7 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 	err = __ip6_append_data(sk, &queue, cork, &v6_cork,
 				&current->task_frag, getfrag, from,
 				length + exthdrlen, transhdrlen + exthdrlen,
-				flags);
+				flags, ipc6);
 	if (err) {
 		__ip6_flush_pending_frames(sk, &queue, cork, &v6_cork);
 		return ERR_PTR(err);

base-commit: 3f5b4c104b7d3267d015daf9d9681c5fe3b01224
-- 
2.49.0


