Return-Path: <stable+bounces-43839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542818C4FDA
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E2A1F21037
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 10:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B16613048B;
	Tue, 14 May 2024 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gpkzmVH+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DB857CA1;
	Tue, 14 May 2024 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682574; cv=none; b=GDonI3IIJU437NxUiUBrBTT+Hm6e/JWrk2j6/1HnguDZCN1uABWfGS11HfvNTXYqVMgNuB9ydo7W6wQnbD3nGVYbMo6OtFOVOOsAgM8rKwxhMGYFLTtShBE70gJBcuSFi2/23jICxurmz8OEG5XGyMDgSs1Z04I7U1pebWaSsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682574; c=relaxed/simple;
	bh=fEaJ8wbkQdXubRrK4uW/YsilSiEK4MEaOcghRbl8YKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuNtaycoURIt0HXPiTf11oJchE3BjgZp7WuxI++4QZE8sgTmZZk3cwlZEkz7n0GX7QASbUe9P3sjtPuyUo0jodldx8hbiKbzikpaRPMeQvG3fzRuRr7vbmWhJd4IpVXyJl9HbFvRRJcjhpqseTwSGVskQ8tLyvvoF0+xbvcfzTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gpkzmVH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2177C32786;
	Tue, 14 May 2024 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715682574;
	bh=fEaJ8wbkQdXubRrK4uW/YsilSiEK4MEaOcghRbl8YKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gpkzmVH+DrFwCf81vBMWhef+u9+910Lk34KtLkARwlnzGU0VB5XidYhq0mP/bLmLK
	 d37YA/agxKKNwkCBKl9+F648gn/BzVxKPQsYfGjK5FdFW7EE4Hryh34jhpNOxLLRJ7
	 kHBlWTbez3vYHDH0YCBONd7bJfsMcPHXNGUYUA04=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Gobert <richardbgobert@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 084/336] net: gro: fix udp bad offset in socket lookup by adding {inner_}network_offset to napi_gro_cb
Date: Tue, 14 May 2024 12:14:48 +0200
Message-ID: <20240514101041.779010367@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Gobert <richardbgobert@gmail.com>

[ Upstream commit 5ef31ea5d053a8f493a772ebad3f3ce82c35d845 ]

Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("udp:
additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in the
complete phase of gro. The functions always return skb->network_header,
which in the case of encapsulated packets at the gro complete phase, is
always set to the innermost L3 of the packet. That means that calling
{ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
gro_list and *_gro_complete) when parsing an encapsulated packet's _outer_
L3/L4 may return an unexpected value.

This incorrect usage leads to a bug in GRO's UDP socket lookup.
udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
*_hdr functions return network_header which will point to the innermost L3,
resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
encapsulated packets.

This patch adds network_offset and inner_network_offset to napi_gro_cb, and
makes sure both are set correctly.

To fix the issue, network_offsets union is used inside napi_gro_cb, in
which both the outer and the inner network offsets are saved.

Reproduction example:

Endpoint configuration example (fou + local address bind)

    # ip fou add port 6666 ipproto 4
    # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap fou encap-dport 5555 encap-sport 6666 mode ipip
    # ip link set tun1 up
    # ip a add 1.1.1.2/24 dev tun1

Netperf TCP_STREAM result on net-next before patch is applied:

net-next main, GRO enabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.28        2.37

net-next main, GRO disabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.01     2745.06

patch applied, GRO enabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.01     2877.38

Fixes: a6024562ffd7 ("udp: Add GRO functions to UDP socket")
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/gro.h      | 9 +++++++++
 net/8021q/vlan_core.c  | 2 ++
 net/core/gro.c         | 1 +
 net/ipv4/af_inet.c     | 1 +
 net/ipv4/udp.c         | 3 ++-
 net/ipv4/udp_offload.c | 3 ++-
 net/ipv6/ip6_offload.c | 1 +
 net/ipv6/udp.c         | 3 ++-
 net/ipv6/udp_offload.c | 3 ++-
 9 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index b435f0ddbf64f..62b006f3ed184 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -86,6 +86,15 @@ struct napi_gro_cb {
 
 	/* used to support CHECKSUM_COMPLETE for tunneling protocols */
 	__wsum	csum;
+
+	/* L3 offsets */
+	union {
+		struct {
+			u16 network_offset;
+			u16 inner_network_offset;
+		};
+		u16 network_offsets[2];
+	};
 };
 
 #define NAPI_GRO_CB(skb) ((struct napi_gro_cb *)(skb)->cb)
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index f001582345052..9404dd551dfd2 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -478,6 +478,8 @@ static struct sk_buff *vlan_gro_receive(struct list_head *head,
 	if (unlikely(!vhdr))
 		goto out;
 
+	NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = hlen;
+
 	type = vhdr->h_vlan_encapsulated_proto;
 
 	ptype = gro_find_receive_by_type(type);
diff --git a/net/core/gro.c b/net/core/gro.c
index cefddf65f7db0..31e40f25fdf10 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -373,6 +373,7 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
 	const struct skb_shared_info *pinfo = skb_shinfo(skb);
 	const skb_frag_t *frag0 = &pinfo->frags[0];
 
+	NAPI_GRO_CB(skb)->network_offset = 0;
 	NAPI_GRO_CB(skb)->data_offset = 0;
 	NAPI_GRO_CB(skb)->frag0 = NULL;
 	NAPI_GRO_CB(skb)->frag0_len = 0;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index a5a820ee20266..ce5c26cf1e2e8 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1571,6 +1571,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 	/* The above will be needed by the transport layer if there is one
 	 * immediately following this IP hdr.
 	 */
+	NAPI_GRO_CB(skb)->inner_network_offset = off;
 
 	/* Note : No need to call skb_gro_postpull_rcsum() here,
 	 * as we already checked checksum over ipv4 header was 0
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 40282a34180ca..9120694359af4 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -534,7 +534,8 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
 struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct net *net = dev_net(skb->dev);
 	int iif, sdif;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index c3d67423ae189..889d4926fc0c1 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -718,7 +718,8 @@ EXPORT_SYMBOL(udp_gro_complete);
 
 INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index cca64c7809bee..19ae2d4cd2021 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -237,6 +237,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 		goto out;
 
 	skb_set_network_header(skb, off);
+	NAPI_GRO_CB(skb)->inner_network_offset = off;
 
 	flush += ntohs(iph->payload_len) != skb->len - hlen;
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8c14c4cc82ff7..785b2d076a6b3 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -275,7 +275,8 @@ static struct sock *__udp6_lib_lookup_skb(struct sk_buff *skb,
 struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport)
 {
-	const struct ipv6hdr *iph = ipv6_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + offset);
 	struct net *net = dev_net(skb->dev);
 	int iif, sdif;
 
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 626d7b362dc7b..639a4b506f9b5 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -164,7 +164,8 @@ struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 {
-	const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct ipv6hdr *ipv6h = (struct ipv6hdr *)(skb->data + offset);
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
-- 
2.43.0




