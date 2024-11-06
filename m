Return-Path: <stable+bounces-91710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F429BF5A5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 19:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD631F22920
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45211209669;
	Wed,  6 Nov 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQVMNPP2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFA0208226;
	Wed,  6 Nov 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918995; cv=none; b=aMzPf5v5LpALxWENJJma/9XM0QnGpEJ159BJR42tKi/91w2ZZy5unZsknOfMRfygqE/srGvWwRGf9PRHDUbB8C2XqvchfcR1rXFvgQjKKG1a015hsCTNsudfTMBkv+X6wzg+IFEUW/Np7D+DkMLbFv2zIhy2C1Xgm9cMQQsbkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918995; c=relaxed/simple;
	bh=N5LhYQ8LNuTU5/eVJ0fCcC0c8UEr5xiNw6btgM649Co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ux+a8XYnFJu8Xg3vwKRtKBvhQl5h86/Bbu5R/Hq+uMtQ0M3j9ky8Y2g+Ssn4/ga66fzfLXIPR1CXGanmYmMbQrr4xHKnpwJojM56FgWEVhWEXoLqwOf8+/x7mqKD8xuQ3kBLjJQg9GGmfxfe3zN/FibRAYdDYHqclcI6MRomipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQVMNPP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BEBAC4CED0;
	Wed,  6 Nov 2024 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730918995;
	bh=N5LhYQ8LNuTU5/eVJ0fCcC0c8UEr5xiNw6btgM649Co=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bQVMNPP272pg2AuJsWmI3GTaYGSpNUHUMfQPR+1lFSkx/6dk/XYrQSRWdnJBzJH54
	 9Ip0iAtDU/fAS13yOa/WZSvjVXtonw0bZBSgd+i2knKOLdNSj+gPABfJIgeJ7lXSOY
	 GwkV4SF1xLDH0G+bpq6MNIqcgW7W4Et8Ih6R9ZTQIQglTewBF/KTrvuOvsxxwiP/7c
	 atE+IB0+Q8WsD3y/0lM1YCixHcakB9iSBpsdHTFQ15EcxsiC7uvUqV2/LBQEB0EkzP
	 E5aCh/FqxgB11UzA5/3hT/DoVIjcj9JxhOkRTL9KocBrpSIl0FnoaOxyANF+RXpVaa
	 imQtuWo8XtvWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A02ED59F60;
	Wed,  6 Nov 2024 18:49:55 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 06 Nov 2024 18:10:14 +0000
Subject: [PATCH net 1/6] net/diag: Do not race on dumping MD5 keys with
 adding new MD5 keys
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-tcp-md5-diag-prep-v1-1-d62debf3dded@gmail.com>
References: <20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com>
In-Reply-To: <20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Dmitry Safonov <0x7f454c46@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730918993; l=7958;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=k7l0ErglAWcq8Z7BhR+blvFMIj4mj3UET5TdAev1Vas=;
 b=4kkrARfKmGSYKInaqlsVGNk0snyMmMBem2SNfiGNydT3FoRdsvs0cQUXKI6dyaJsHqx3VfWo8
 37jHk+dNc8hCPzikFbm19qQsZVziJVGSjSwVFO5/cY12wXVymJ30GFk
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Inet-diag has two modes: (1) dumping information for a specific socket,
for which kernel creates one netlink message with the information and
(2) dumping information for multiple sockets (possibly with a filter),
where for the reply kernel sends many messages, one for each matched
socket.

Currently those two modes work differently as the information about
a specific socket is never split between multiple messages. For (2),
multi-socket dump for the reply kernel allocates up to 32Kb skb and
fills that with as many socket dumps as possible. For (1), one-socket
dump kernel pre-calculates the required space for the reply, allocates
a new skb and nlmsg and only then starts filling the socket's details.

Preallocating the needed size quite makes sense as most of the details
are fix-sized and provided for each socket, see inet_sk_attr_size().
But there's an exception: .idiag_get_aux_size() which is optional for
a socket. This is provided only for TCP sockets by tcp_diag.

For TCP-MD5 it calculates the memory needed to fill an array of
(struct tcp_diag_md5sig). The issue here is that the amount of keys may
change in inet_diag_dump_one_icsk() between inet_sk_attr_size() and
sk_diag_fill() calls. As the code expects fix-sized information on any
socket, it considers sk_diag_fill() failures by -EMSGSIZE reason as
a bug, resulting in such WARN_ON():

[] ------------[ cut here ]------------
[] WARNING: CPU: 7 PID: 17420 at net/ipv4/inet_diag.c:586 inet_diag_dump_one_icsk+0x3c8/0x420
[] CPU: 7 UID: 0 PID: 17420 Comm: diag_ipv4 Tainted: G        W          6.11.0-rc6-00022-gc9fd7a9f9aca-dirty #2
[] pc : inet_diag_dump_one_icsk+0x3c8/0x420
[] lr : inet_diag_dump_one_icsk+0x1d4/0x420
[] sp : ffff8000aef87460
...
[] Call trace:
[]  inet_diag_dump_one_icsk+0x3c8/0x420
[]  tcp_diag_dump_one+0xa0/0xf0
[]  inet_diag_cmd_exact+0x234/0x278
[]  inet_diag_handler_cmd+0x16c/0x288
[]  sock_diag_rcv_msg+0x1a8/0x550
[]  netlink_rcv_skb+0x198/0x378
[]  sock_diag_rcv+0x20/0x48
[]  netlink_unicast+0x400/0x6a8
[]  netlink_sendmsg+0x654/0xa58
[]  __sys_sendto+0x1ec/0x330
[]  __arm64_sys_sendto+0xc8/0x168
...
[] ---[ end trace 0000000000000000 ]---

One way to solve it would be to grab lock_sock() in
inet_diag_dump_one_icsk(), but that may be costly and bring new lock
dependencies. The alternative is to call tcp_diag_put_md5sig() as
the last attribute of the netlink message and calculate how much space
left after all previous attributes filled and translate it into
(struct tcp_diag_md5sig)-sized units. If it turns out that there's not
enough space for all TCP-MD5 keys, mark the dump as inconsistent by
setting NLM_F_DUMP_INTR flag. Userspace may figure out that dumping
raced with the socket properties change and retry again.

Currently it may be unexpected by userspace that netlink message for one
socket may be inconsistent, but I believe we're on a safe side from
breaking userspace as previously dump would fail and an ugly WARN was
produced in dmesg. IOW, it is a clear improvement.

This is not a theoretical issue: I've written a test and that reproduces
the issue I suspected (the backtrace above).

Fixes: c03fa9bcacd9 ("tcp_diag: report TCP MD5 signing keys and addresses")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 include/linux/inet_diag.h |  3 ++-
 net/ipv4/inet_diag.c      |  8 +++----
 net/ipv4/tcp_diag.c       | 55 ++++++++++++++++++++++++++++-------------------
 3 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
index a9033696b0aad36ab9abd47e4b68e272053019d7..cb2ba672eba131986d0432dd628fc42bbf800886 100644
--- a/include/linux/inet_diag.h
+++ b/include/linux/inet_diag.h
@@ -22,7 +22,8 @@ struct inet_diag_handler {
 
 	int		(*idiag_get_aux)(struct sock *sk,
 					 bool net_admin,
-					 struct sk_buff *skb);
+					 struct sk_buff *skb,
+					 struct nlmsghdr *nlh);
 
 	size_t		(*idiag_get_aux_size)(struct sock *sk,
 					      bool net_admin);
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 67639309163d05c034fad80fc9a6096c3b79d42f..67b9cc4c0e47a596a4d588e793b7f13ee040a1e3 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -350,10 +350,6 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 
 	handler->idiag_get_info(sk, r, info);
 
-	if (ext & (1 << (INET_DIAG_INFO - 1)) && handler->idiag_get_aux)
-		if (handler->idiag_get_aux(sk, net_admin, skb) < 0)
-			goto errout;
-
 	if (sk->sk_state < TCP_TIME_WAIT) {
 		union tcp_cc_info info;
 		size_t sz = 0;
@@ -368,6 +364,10 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 			goto errout;
 	}
 
+	if (ext & (1 << (INET_DIAG_INFO - 1)) && handler->idiag_get_aux)
+		if (handler->idiag_get_aux(sk, net_admin, skb, nlh) < 0)
+			goto errout;
+
 	/* Keep it at the end for potential retry with a larger skb,
 	 * or else do best-effort fitting, which is only done for the
 	 * first_nlmsg.
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index f428ecf9120f2f596e1d67db2b2a0d0d0e211905..36606a19b451f059e32c58c0d76a878dc9be5ff0 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -53,29 +53,39 @@ static void tcp_diag_md5sig_fill(struct tcp_diag_md5sig *info,
 }
 
 static int tcp_diag_put_md5sig(struct sk_buff *skb,
-			       const struct tcp_md5sig_info *md5sig)
+			       const struct tcp_md5sig_info *md5sig,
+			       struct nlmsghdr *nlh)
 {
+	size_t key_size = sizeof(struct tcp_diag_md5sig);
+	unsigned int attrlen, md5sig_count;
 	const struct tcp_md5sig_key *key;
 	struct tcp_diag_md5sig *info;
 	struct nlattr *attr;
-	int md5sig_count = 0;
 
+	/*
+	 * Userspace doesn't like to see zero-filled key-values, so
+	 * allocating too large attribute is bad.
+	 */
 	hlist_for_each_entry_rcu(key, &md5sig->head, node)
 		md5sig_count++;
 	if (md5sig_count == 0)
 		return 0;
 
-	attr = nla_reserve(skb, INET_DIAG_MD5SIG,
-			   md5sig_count * sizeof(struct tcp_diag_md5sig));
+	attrlen = skb_availroom(skb) - NLA_HDRLEN;
+	md5sig_count = min(md5sig_count, attrlen / key_size);
+	attr = nla_reserve(skb, INET_DIAG_MD5SIG, md5sig_count * key_size);
 	if (!attr)
 		return -EMSGSIZE;
 
 	info = nla_data(attr);
-	memset(info, 0, md5sig_count * sizeof(struct tcp_diag_md5sig));
+	memset(info, 0, md5sig_count * key_size);
 	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
-		tcp_diag_md5sig_fill(info++, key);
-		if (--md5sig_count == 0)
+		/* More keys on a socket than pre-allocated space available */
+		if (md5sig_count-- == 0) {
+			nlh->nlmsg_flags |= NLM_F_DUMP_INTR;
 			break;
+		}
+		tcp_diag_md5sig_fill(info++, key);
 	}
 
 	return 0;
@@ -110,25 +120,11 @@ static int tcp_diag_put_ulp(struct sk_buff *skb, struct sock *sk,
 }
 
 static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
-			    struct sk_buff *skb)
+			    struct sk_buff *skb, struct nlmsghdr *nlh)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	int err = 0;
 
-#ifdef CONFIG_TCP_MD5SIG
-	if (net_admin) {
-		struct tcp_md5sig_info *md5sig;
-
-		rcu_read_lock();
-		md5sig = rcu_dereference(tcp_sk(sk)->md5sig_info);
-		if (md5sig)
-			err = tcp_diag_put_md5sig(skb, md5sig);
-		rcu_read_unlock();
-		if (err < 0)
-			return err;
-	}
-#endif
-
 	if (net_admin) {
 		const struct tcp_ulp_ops *ulp_ops;
 
@@ -138,6 +134,21 @@ static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
 		if (err)
 			return err;
 	}
+
+#ifdef CONFIG_TCP_MD5SIG
+	if (net_admin) {
+		struct tcp_md5sig_info *md5sig;
+
+		rcu_read_lock();
+		md5sig = rcu_dereference(tcp_sk(sk)->md5sig_info);
+		if (md5sig)
+			err = tcp_diag_put_md5sig(skb, md5sig, nlh);
+		rcu_read_unlock();
+		if (err < 0)
+			return err;
+	}
+#endif
+
 	return 0;
 }
 

-- 
2.42.2



