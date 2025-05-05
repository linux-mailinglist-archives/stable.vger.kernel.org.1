Return-Path: <stable+bounces-140539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B94AAAE11
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28FF5A18C0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511B9370B1B;
	Mon,  5 May 2025 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwV3ah0g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A029B22B;
	Mon,  5 May 2025 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485078; cv=none; b=nLHJ9oFQ4NcvyFOq860xCOA26BCYYAMUdrATBFi4xjpXc0CEvJrdFt+dKVkaDXWpRHHibOrt/JjJP6lXm0Y36rhtOzhqxEIbh6ozZw1h8t4/XnCKikYKdmC5WQLZ8XpgWT68lCCgxPIpHrmcOQ7khjf7yjupdQiWQbUO+UZIg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485078; c=relaxed/simple;
	bh=pG9jfuldlO2800hDmNAh2x2uJRK3w7OEvUGwAG1O76k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pzoq715h5ejH5pwJnvmUab1uGV2yyOH0wCNjsd7CM7QuirBGimFkjC/+GWJNSW0/bboaCPuYwMI0rLqhnwQPSErYdAH8pioTPU+IE3C+Z1G0rDXKllmZ2oLZZLhjvz0OyesMRXaiTBrSK483NgdFmaEQduua5VIgBrvvpqG8yUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwV3ah0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99064C4CEED;
	Mon,  5 May 2025 22:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485077;
	bh=pG9jfuldlO2800hDmNAh2x2uJRK3w7OEvUGwAG1O76k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwV3ah0gm8yL4fRrYi9b8YjZALjLF4ec29m5ehs7ejuVGbJfiwZu/X8TZkcU+hIZs
	 Rl7/GyZPs8M7kZ1vzUVTEBMijiERoRPVUcO81zwB4xxWPnZGW4iyoUzEkRHbHeUntT
	 a1T1WEHjoM5t5i1caSqMCfUfvBTELgQOGPLKsYUxjBXDdrLglRqSJNsshwRrU/0yZL
	 MRNb8SLAeJOQ0PQvCLHoaY5tF8SA0PXL96+xkCl1UKWO/2whLsQwgAwBEfRwZSwz7L
	 R4vaKarxlzFw7MnmhrYF4STPWkZrR4FmjaLGWiuD7ialfhQk+fxOmdCpafrnFkeC/N
	 zVKIRjN8CyXDA==
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
Subject: [PATCH AUTOSEL 6.12 155/486] ipv6: save dontfrag in cork
Date: Mon,  5 May 2025 18:33:51 -0400
Message-Id: <20250505223922.2682012-155-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index a6e2aadbb91bd..5aeeed22f35bf 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -207,6 +207,7 @@ struct inet6_cork {
 	struct ipv6_txoptions *opt;
 	u8 hop_limit;
 	u8 tclass;
+	u8 dontfrag:1;
 };
 
 /* struct ipv6_pinfo - ipv6 private area */
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 434ddf263b88a..89a61e040e6a1 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1386,6 +1386,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	}
 	v6_cork->hop_limit = ipc6->hlimit;
 	v6_cork->tclass = ipc6->tclass;
+	v6_cork->dontfrag = ipc6->dontfrag;
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
 		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
 		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
@@ -1417,7 +1418,7 @@ static int __ip6_append_data(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
 			     void *from, size_t length, int transhdrlen,
-			     unsigned int flags, struct ipcm6_cookie *ipc6)
+			     unsigned int flags)
 {
 	struct sk_buff *skb, *skb_prev = NULL;
 	struct inet_cork *cork = &cork_full->base;
@@ -1471,7 +1472,7 @@ static int __ip6_append_data(struct sock *sk,
 	if (headersize + transhdrlen > mtu)
 		goto emsgsize;
 
-	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
+	if (cork->length + length > mtu - headersize && v6_cork->dontfrag &&
 	    (sk->sk_protocol == IPPROTO_UDP ||
 	     sk->sk_protocol == IPPROTO_ICMPV6 ||
 	     sk->sk_protocol == IPPROTO_RAW)) {
@@ -1843,7 +1844,7 @@ int ip6_append_data(struct sock *sk,
 
 	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
 				 &np->cork, sk_page_frag(sk), getfrag,
-				 from, length, transhdrlen, flags, ipc6);
+				 from, length, transhdrlen, flags);
 }
 EXPORT_SYMBOL_GPL(ip6_append_data);
 
@@ -2048,7 +2049,7 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
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


