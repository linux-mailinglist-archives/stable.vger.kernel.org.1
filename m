Return-Path: <stable+bounces-153576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC1FADD592
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF7E1943952
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14FA2DFF10;
	Tue, 17 Jun 2025 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gAz3enOo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1C2F2365;
	Tue, 17 Jun 2025 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176408; cv=none; b=t7R+USpFL6s8pRt8psoXTs4d3bS1FDjZh1OjmdFAg7/Rbq+AI7PJ5tzuBGb9Q8DgF05NoSAtHwX5WlsQD7dG6Dnp3cVuxSMrSn2De/5lLn9G+kN5Ry3ncCl+WbrMQbfbHh66oxdcINUvfFqBkOdhmwBE4i4NZLBzjGSuHHNOvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176408; c=relaxed/simple;
	bh=SnE8ndxDli4jpNWlUqrjzH8dks4fBKlsaDs05/g2rlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYbj1BuKD/T3L7+3CvVjuXot4Or6O83eZORnJxq4l0zCC1m4oY/97btFAXW9jUhkAKHJnntHKYRBAJMBl8RGqlucTLnsJpKWnio9zDpNGH4oQhSBOl3v3XhGJNBA39ggsWh4F/BWkn01QYBG6JCn+gRSBCxI1XELNHmA1SrP988=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gAz3enOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E39C4CEE3;
	Tue, 17 Jun 2025 16:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176408;
	bh=SnE8ndxDli4jpNWlUqrjzH8dks4fBKlsaDs05/g2rlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAz3enOoi/6l7nD3BMD3mDNX/XmTVq5c//vrQcRY3hfTlH/AYYnAp76jBVmqssEJl
	 5pa8SHUa7mqrzfe1ZZuFTaScTDx11r6YSlzAGKXIyc0CJzOBDG8JFaTYdi+E9kXd2w
	 YSOS/0tr+PirdZslKTEJPvZgiYsiqFMhvnWMCoDw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 186/780] udp_tunnel: use static call for GRO hooks when possible
Date: Tue, 17 Jun 2025 17:18:14 +0200
Message-ID: <20250617152459.054731860@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 5d7f5b2f6b935517ee5fd8058dc32342a5cba3e1 ]

It's quite common to have a single UDP tunnel type active in the
whole system. In such a case we can replace the indirect call for
the UDP tunnel GRO callback with a static call.

Add the related accounting in the control path and switch to static
call when possible. To keep the code simple use a static array for
the registered tunnel types, and size such array based on the kernel
config.

Note that there are valid kernel configurations leading to
UDP_MAX_TUNNEL_TYPES == 0 even with IS_ENABLED(CONFIG_NET_UDP_TUNNEL),
Explicitly skip the accounting in such a case, to avoid compile warning
when accessing "udp_tunnel_gro_types".

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/53d156cdfddcc9678449e873cc83e68fa1582653.1744040675.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c26c192c3d48 ("udp: properly deal with xfrm encap and ADDRFORM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/udp_tunnel.h |   4 ++
 net/ipv4/udp_offload.c   | 135 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 1bb2b852e90eb..288f06f23a804 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -193,13 +193,16 @@ static inline int udp_tunnel_handle_offloads(struct sk_buff *skb, bool udp_csum)
 
 #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
 void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add);
+void udp_tunnel_update_gro_rcv(struct sock *sk, bool add);
 #else
 static inline void udp_tunnel_update_gro_lookup(struct net *net,
 						struct sock *sk, bool add) {}
+static inline void udp_tunnel_update_gro_rcv(struct sock *sk, bool add) {}
 #endif
 
 static inline void udp_tunnel_cleanup_gro(struct sock *sk)
 {
+	udp_tunnel_update_gro_rcv(sk, false);
 	udp_tunnel_update_gro_lookup(sock_net(sk), sk, false);
 }
 
@@ -212,6 +215,7 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
 	if (READ_ONCE(sk->sk_family) == PF_INET6)
 		ipv6_stub->udpv6_encap_enable();
 #endif
+	udp_tunnel_update_gro_rcv(sk, true);
 	udp_encap_enable();
 }
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 67641945ba3a3..9c775f8aa4385 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -15,6 +15,38 @@
 #include <net/udp_tunnel.h>
 
 #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
+
+/*
+ * Dummy GRO tunnel callback, exists mainly to avoid dangling/NULL
+ * values for the udp tunnel static call.
+ */
+static struct sk_buff *dummy_gro_rcv(struct sock *sk,
+				     struct list_head *head,
+				     struct sk_buff *skb)
+{
+	NAPI_GRO_CB(skb)->flush = 1;
+	return NULL;
+}
+
+typedef struct sk_buff *(*udp_tunnel_gro_rcv_t)(struct sock *sk,
+						struct list_head *head,
+						struct sk_buff *skb);
+
+struct udp_tunnel_type_entry {
+	udp_tunnel_gro_rcv_t gro_receive;
+	refcount_t count;
+};
+
+#define UDP_MAX_TUNNEL_TYPES (IS_ENABLED(CONFIG_GENEVE) + \
+			      IS_ENABLED(CONFIG_VXLAN) * 2 + \
+			      IS_ENABLED(CONFIG_NET_FOU) * 2 + \
+			      IS_ENABLED(CONFIG_XFRM) * 2)
+
+DEFINE_STATIC_CALL(udp_tunnel_gro_rcv, dummy_gro_rcv);
+static DEFINE_STATIC_KEY_FALSE(udp_tunnel_static_call);
+static struct mutex udp_tunnel_gro_type_lock;
+static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
+static unsigned int udp_tunnel_gro_type_nr;
 static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
 
 void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
@@ -43,6 +75,105 @@ void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
 	spin_unlock(&udp_tunnel_gro_lock);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_lookup);
+
+void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
+{
+	struct udp_tunnel_type_entry *cur = NULL;
+	struct udp_sock *up = udp_sk(sk);
+	int i, old_gro_type_nr;
+
+	if (!UDP_MAX_TUNNEL_TYPES || !up->gro_receive)
+		return;
+
+	mutex_lock(&udp_tunnel_gro_type_lock);
+
+	/* Check if the static call is permanently disabled. */
+	if (udp_tunnel_gro_type_nr > UDP_MAX_TUNNEL_TYPES)
+		goto out;
+
+	for (i = 0; i < udp_tunnel_gro_type_nr; i++)
+		if (udp_tunnel_gro_types[i].gro_receive == up->gro_receive)
+			cur = &udp_tunnel_gro_types[i];
+
+	old_gro_type_nr = udp_tunnel_gro_type_nr;
+	if (add) {
+		/*
+		 * Update the matching entry, if found, or add a new one
+		 * if needed
+		 */
+		if (cur) {
+			refcount_inc(&cur->count);
+			goto out;
+		}
+
+		if (unlikely(udp_tunnel_gro_type_nr == UDP_MAX_TUNNEL_TYPES)) {
+			pr_err_once("Too many UDP tunnel types, please increase UDP_MAX_TUNNEL_TYPES\n");
+			/* Ensure static call will never be enabled */
+			udp_tunnel_gro_type_nr = UDP_MAX_TUNNEL_TYPES + 1;
+		} else {
+			cur = &udp_tunnel_gro_types[udp_tunnel_gro_type_nr++];
+			refcount_set(&cur->count, 1);
+			cur->gro_receive = up->gro_receive;
+		}
+	} else {
+		/*
+		 * The stack cleanups only successfully added tunnel, the
+		 * lookup on removal should never fail.
+		 */
+		if (WARN_ON_ONCE(!cur))
+			goto out;
+
+		if (!refcount_dec_and_test(&cur->count))
+			goto out;
+
+		/* Avoid gaps, so that the enable tunnel has always id 0 */
+		*cur = udp_tunnel_gro_types[--udp_tunnel_gro_type_nr];
+	}
+
+	if (udp_tunnel_gro_type_nr == 1) {
+		static_call_update(udp_tunnel_gro_rcv,
+				   udp_tunnel_gro_types[0].gro_receive);
+		static_branch_enable(&udp_tunnel_static_call);
+	} else if (old_gro_type_nr == 1) {
+		static_branch_disable(&udp_tunnel_static_call);
+		static_call_update(udp_tunnel_gro_rcv, dummy_gro_rcv);
+	}
+
+out:
+	mutex_unlock(&udp_tunnel_gro_type_lock);
+}
+EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_rcv);
+
+static void udp_tunnel_gro_init(void)
+{
+	mutex_init(&udp_tunnel_gro_type_lock);
+}
+
+static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
+					  struct list_head *head,
+					  struct sk_buff *skb)
+{
+	if (static_branch_likely(&udp_tunnel_static_call)) {
+		if (unlikely(gro_recursion_inc_test(skb))) {
+			NAPI_GRO_CB(skb)->flush |= 1;
+			return NULL;
+		}
+		return static_call(udp_tunnel_gro_rcv)(sk, head, skb);
+	}
+	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
+}
+
+#else
+
+static void udp_tunnel_gro_init(void) {}
+
+static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
+					  struct list_head *head,
+					  struct sk_buff *skb)
+{
+	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
+}
+
 #endif
 
 static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
@@ -713,7 +844,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 
 	skb_gro_pull(skb, sizeof(struct udphdr)); /* pull encapsulating udp header */
 	skb_gro_postpull_rcsum(skb, uh, sizeof(struct udphdr));
-	pp = call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
+	pp = udp_tunnel_gro_rcv(sk, head, skb);
 
 out:
 	skb_gro_flush_final(skb, pp, flush);
@@ -863,5 +994,7 @@ int __init udpv4_offload_init(void)
 			.gro_complete =	udp4_gro_complete,
 		},
 	};
+
+	udp_tunnel_gro_init();
 	return inet_add_offload(&net_hotdata.udpv4_offload, IPPROTO_UDP);
 }
-- 
2.39.5




