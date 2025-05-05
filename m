Return-Path: <stable+bounces-141513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA84AAB42E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7123A98C2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674F4470CEA;
	Tue,  6 May 2025 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CINAms3b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0C2DBB00;
	Mon,  5 May 2025 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486519; cv=none; b=Jg9J7AQ9db7Mati9AtKAV+z97+g7T4KGf/01FPJykSP1BeVgx0Xc+Cwp9gtaeJP7cgw/+XmAkuJwo1941KnaRokCeVXubVAL2YlSNnpMAybZTTDx8lcjyGRfQL7d7oz1/Jke1r2ePipDktnKkq3SLiTtfepqTZxW6p5bDn4aWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486519; c=relaxed/simple;
	bh=KU7blBe+4rBUD/20S9G4OioeVvD9r5+vpRbt28oYikE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cm8MWzFQmAYuMEWaX52JafADRCHHg8Jmxoeh7NU2JssYMc9n7UWdllWzmRuiZfX3JWH9M2kQQ40/86O3SSLTRwWHYtwwP+g6erJRJhgqCQEmhwyM+4HkcjHLemMFR+IVTtx+6CFTGQGSm5J31PoHeLpOj3PP/itNmZcMyOymWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CINAms3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB6DC4CEED;
	Mon,  5 May 2025 23:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486517;
	bh=KU7blBe+4rBUD/20S9G4OioeVvD9r5+vpRbt28oYikE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CINAms3bhidKMeKnt4b+hmsVc0QiWkMNS+ezudIe428TnWshN/qMi5rS4sZhIdYa1
	 BYzAB9lIMihahNVn3hM1wnRb0toneLyTaI0HPmSIJtf8QTGtixeP7hmLZ19JnW+TPC
	 XmpM15IZm/ND0ZfcvcTzFn3cPjAjFeVD5iYc35sqeN+BazgQgHq5VkQ5PWTrgzkDNc
	 qQEiNMXozdgX96UF9F1WCug7dK0WK8pg25K0HHKfG2UoQfMBs0fQaEK16tyW/j08DE
	 w+191GwUh1ows6k9S1Op6IjFfV5gJSVR0iR+FdkRwE7OgAHXrm77KUYfFK8eYeqcom
	 dEeJ4Rx4ZppEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 072/212] ipv6: save dontfrag in cork
Date: Mon,  5 May 2025 19:04:04 -0400
Message-Id: <20250505230624.2692522-72-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a ]

When spanning datagram construction over multiple send calls using
MSG_MORE, per datagram settings are configured on the first send.

That is when ip(6)_setup_cork stores these settings for subsequent use
in __ip(6)_append_data and others.

The only flag that escaped this was dontfrag. As a result, a datagram
could be constructed with df=0 on the first sendmsg, but df=1 on a
next. Which is what cmsg_ip.sh does in an upcoming MSG_MORE test in
the "diff" scenario.

Changing datagram conditions in the middle of constructing an skb
makes this already complex code path even more convoluted. It is here
unintentional. Bring this flag in line with expected sockopt/cmsg
behavior.

And stop passing ipc6 to __ip6_append_data, to avoid such issues
in the future. This is already the case for __ip_append_data.

inet6_cork had a 6 byte hole, so the 1B flag has no impact.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250307033620.411611-3-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ipv6.h  | 1 +
 net/ipv6/ip6_output.c | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 9a44de45cc1f2..9f27e004127bb 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -199,6 +199,7 @@ struct inet6_cork {
 	struct ipv6_txoptions *opt;
 	u8 hop_limit;
 	u8 tclass;
+	u8 dontfrag:1;
 };
 
 /**
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index d7f7a714bd232..5d7d99364006a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1450,6 +1450,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	}
 	v6_cork->hop_limit = ipc6->hlimit;
 	v6_cork->tclass = ipc6->tclass;
+	v6_cork->dontfrag = ipc6->dontfrag;
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
 		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
 		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
@@ -1483,7 +1484,7 @@ static int __ip6_append_data(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
 			     void *from, size_t length, int transhdrlen,
-			     unsigned int flags, struct ipcm6_cookie *ipc6)
+			     unsigned int flags)
 {
 	struct sk_buff *skb, *skb_prev = NULL;
 	struct inet_cork *cork = &cork_full->base;
@@ -1539,7 +1540,7 @@ static int __ip6_append_data(struct sock *sk,
 	if (headersize + transhdrlen > mtu)
 		goto emsgsize;
 
-	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
+	if (cork->length + length > mtu - headersize && v6_cork->dontfrag &&
 	    (sk->sk_protocol == IPPROTO_UDP ||
 	     sk->sk_protocol == IPPROTO_ICMPV6 ||
 	     sk->sk_protocol == IPPROTO_RAW)) {
@@ -1884,7 +1885,7 @@ int ip6_append_data(struct sock *sk,
 
 	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
 				 &np->cork, sk_page_frag(sk), getfrag,
-				 from, length, transhdrlen, flags, ipc6);
+				 from, length, transhdrlen, flags);
 }
 EXPORT_SYMBOL_GPL(ip6_append_data);
 
@@ -2088,7 +2089,7 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 	err = __ip6_append_data(sk, &queue, cork, &v6_cork,
 				&current->task_frag, getfrag, from,
 				length + exthdrlen, transhdrlen + exthdrlen,
-				flags, ipc6);
+				flags);
 	if (err) {
 		__ip6_flush_pending_frames(sk, &queue, cork, &v6_cork);
 		return ERR_PTR(err);
-- 
2.39.5


