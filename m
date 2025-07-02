Return-Path: <stable+bounces-159235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664A0AF1444
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 13:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8720E4465E5
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E007D266B5D;
	Wed,  2 Jul 2025 11:42:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2B3225A31;
	Wed,  2 Jul 2025 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456548; cv=none; b=Vr+84DQYYOP7Ejtj3Qkdn6J7aCeU7qH9QrWiKtrkHjvd75zyYbqZVMEwkq91HP8G11jQbNBB8QFyetP1ve72FXO6x8h4YRHtxGGeXasyhGyYOa/ZcH9jhpQ984Mv1HyGiOlxOa5myJlzWk5PReIuogs78uNmgcvyYiRpCZg9zCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456548; c=relaxed/simple;
	bh=+c+g0hwh+gTGN67rs+cKJDOv3GKw4+E2VRFXjz9Rl0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKVXWF8pGEXCsHZaAuQpq71TMahO0CushXnfI/8g/xYBbkqCRsx+Ws8eUPyv0QaXYxSURKlTv17CUjAdAJRVEPFvQ5hh3NIMlZWFBsPRKXQRqfgQYSjN0xBRiGukCitwGnYt+AGN/xLq2YhrDD0fSfXZUcnW9u66TQn78ce89kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Received: from [2a0c:e303:0:7000:1adb:f2ff:fe4f:84eb] (port=49576 helo=karahi.gladserv.com)
	by bregans-0.gladserv.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(envelope-from <bacs@librecast.net>)
	id 1uWvr5-008bNU-2n;
	Wed, 02 Jul 2025 11:42:23 +0000
From: Brett A C Sheffield <bacs@librecast.net>
To: gregkh@linuxfoundation.org
Cc: regressions@lists.linux.dev,
	stable@vger.kernel.org,
	willemb@google.com,
	Brett A C Sheffield <bacs@librecast.net>
Subject: [PATCH 6.1.y] Revert "ipv6: save dontfrag in cork"
Date: Wed,  2 Jul 2025 13:41:51 +0200
Message-ID: <20250702114150.2590-2-bacs@librecast.net>
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

This reverts commit 4f809be95d9f3db13d31c574b8764c8d429f0c3b which is
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
index 9f27e004127b..9a44de45cc1f 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -199,7 +199,6 @@ struct inet6_cork {
 	struct ipv6_txoptions *opt;
 	u8 hop_limit;
 	u8 tclass;
-	u8 dontfrag:1;
 };
 
 /**
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index cfc276e5a249..f7a225da8525 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1450,7 +1450,6 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	}
 	v6_cork->hop_limit = ipc6->hlimit;
 	v6_cork->tclass = ipc6->tclass;
-	v6_cork->dontfrag = ipc6->dontfrag;
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
 		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
 		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
@@ -1484,7 +1483,7 @@ static int __ip6_append_data(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
 			     void *from, size_t length, int transhdrlen,
-			     unsigned int flags)
+			     unsigned int flags, struct ipcm6_cookie *ipc6)
 {
 	struct sk_buff *skb, *skb_prev = NULL;
 	struct inet_cork *cork = &cork_full->base;
@@ -1540,7 +1539,7 @@ static int __ip6_append_data(struct sock *sk,
 	if (headersize + transhdrlen > mtu)
 		goto emsgsize;
 
-	if (cork->length + length > mtu - headersize && v6_cork->dontfrag &&
+	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
 	    (sk->sk_protocol == IPPROTO_UDP ||
 	     sk->sk_protocol == IPPROTO_ICMPV6 ||
 	     sk->sk_protocol == IPPROTO_RAW)) {
@@ -1885,7 +1884,7 @@ int ip6_append_data(struct sock *sk,
 
 	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
 				 &np->cork, sk_page_frag(sk), getfrag,
-				 from, length, transhdrlen, flags);
+				 from, length, transhdrlen, flags, ipc6);
 }
 EXPORT_SYMBOL_GPL(ip6_append_data);
 
@@ -2090,7 +2089,7 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 	err = __ip6_append_data(sk, &queue, cork, &v6_cork,
 				&current->task_frag, getfrag, from,
 				length + exthdrlen, transhdrlen + exthdrlen,
-				flags);
+				flags, ipc6);
 	if (err) {
 		__ip6_flush_pending_frames(sk, &queue, cork, &v6_cork);
 		return ERR_PTR(err);

base-commit: 7e69c33e4858ea275b2e1c0bf0bea13199e7e91b
-- 
2.49.0


