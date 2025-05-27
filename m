Return-Path: <stable+bounces-147309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC99AC5726
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88983A245A
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07BB27FB02;
	Tue, 27 May 2025 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DmQq28wr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C81DB34C;
	Tue, 27 May 2025 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366945; cv=none; b=C9YRMf/FadoaotGZ/LNeuHayBsRmbPBqXNE+rfigKy9JRyOiQif03CB0Pqjepwb2PuQr/CeRPFhBwZMJi/9gxvArb+muyWuHBYE5X8lhdO/Glv8rHM1u5GmL40x79qjBezTWLRE7mXBD/u6urlonaUnnvZVf7pOltAXFk9If1Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366945; c=relaxed/simple;
	bh=A8ATE+F9ZajkWhJy/NYzpz78s2Qpubq++E5FHU6XsOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st1x5Tv7+4Sw/QnbKM/fE6y3Dxd2octezx1U9jyxk3ncW8ELptCo1T3m6eHPqW/xUjS9sek300yI26w96LTG2Sb2Y5EZj8rwSR4NXOeCZg9mK/xuY8TyG3XJuvys3OGkxqiwPkorJoDgeK+Xlza/OHTmjlQRBAfqVNSWMYum65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DmQq28wr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5923C4CEE9;
	Tue, 27 May 2025 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366945;
	bh=A8ATE+F9ZajkWhJy/NYzpz78s2Qpubq++E5FHU6XsOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmQq28wrYXJ63qJLVUjrywPGzdH9WR9eOsxZ2bzRh4VYnfknGQQiEZbJJFl+u2WEx
	 tHngeuzfKfr9dokK+H4q/XBU8CNcBV4vlJp9P7Ji4jJ4rcCuzjsSHdNZ8iyRrfbq8J
	 mK9TBLtXJ3K4tKHkOxal5iWZs4r9oX/UzKa2Xm6M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 228/783] ipv6: save dontfrag in cork
Date: Tue, 27 May 2025 18:20:25 +0200
Message-ID: <20250527162522.407689657@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d577bf2f30538..eb636bec89796 100644
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
@@ -1421,7 +1422,7 @@ static int __ip6_append_data(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
 			     void *from, size_t length, int transhdrlen,
-			     unsigned int flags, struct ipcm6_cookie *ipc6)
+			     unsigned int flags)
 {
 	struct sk_buff *skb, *skb_prev = NULL;
 	struct inet_cork *cork = &cork_full->base;
@@ -1475,7 +1476,7 @@ static int __ip6_append_data(struct sock *sk,
 	if (headersize + transhdrlen > mtu)
 		goto emsgsize;
 
-	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
+	if (cork->length + length > mtu - headersize && v6_cork->dontfrag &&
 	    (sk->sk_protocol == IPPROTO_UDP ||
 	     sk->sk_protocol == IPPROTO_ICMPV6 ||
 	     sk->sk_protocol == IPPROTO_RAW)) {
@@ -1855,7 +1856,7 @@ int ip6_append_data(struct sock *sk,
 
 	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
 				 &np->cork, sk_page_frag(sk), getfrag,
-				 from, length, transhdrlen, flags, ipc6);
+				 from, length, transhdrlen, flags);
 }
 EXPORT_SYMBOL_GPL(ip6_append_data);
 
@@ -2060,7 +2061,7 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
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




