Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA85078EBA2
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245513AbjHaLMF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346015AbjHaLMD (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:12:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415D2E7A
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:11:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 001EC63BAC
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10664C433C8;
        Thu, 31 Aug 2023 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480296;
        bh=El4NpBEyEnXo9GGcji6CmGyaHdQH1LRS+Lp1B3oI86I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lv6mN+CZXOkhLwJy753LvA4f5iBbLaHtHo8HHlgj8DyCaPPTlzXIm19l0dEGGO9H6
         tyy4EiLSc1GQUdEqqlfDuyyaIlG1vxXFKA8+02bd6JVgteBBpPZj4xDWvEdnJVBMkA
         LCScefc5lB3NLMkTPyq5xn5IFEb1wR6P39siVolo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>,
        Coco Li <lixiaoyan@google.com>,
        YiFei Zhu <zhuyifei@google.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 6/8] ipv6: remove hard coded limitation on ipv6_pinfo
Date:   Thu, 31 Aug 2023 13:10:33 +0200
Message-ID: <20230831110831.051111512@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831110830.817738361@linuxfoundation.org>
References: <20230831110830.817738361@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit f5f80e32de12fad2813d37270e8364a03e6d3ef0 upstream.

IPv6 inet sockets are supposed to have a "struct ipv6_pinfo"
field at the end of their definition, so that inet6_sk_generic()
can derive from socket size the offset of the "struct ipv6_pinfo".

This is very fragile, and prevents adding bigger alignment
in sockets, because inet6_sk_generic() does not work
if the compiler adds padding after the ipv6_pinfo component.

We are currently working on a patch series to reorganize
TCP structures for better data locality and found issues
similar to the one fixed in commit f5d547676ca0
("tcp: fix tcp_inet6_sk() for 32bit kernels")

Alternative would be to force an alignment on "struct ipv6_pinfo",
greater or equal to __alignof__(any ipv6 sock) to ensure there is
no padding. This does not look great.

v2: fix typo in mptcp_proto_v6_init() (Paolo)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Chao Wu <wwchao@google.com>
Cc: Wei Wang <weiwan@google.com>
Cc: Coco Li <lixiaoyan@google.com>
Cc: YiFei Zhu <zhuyifei@google.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/ipv6.h |   15 ++++-----------
 include/net/sock.h   |    1 +
 net/dccp/ipv6.c      |    1 +
 net/dccp/ipv6.h      |    4 ----
 net/ipv6/af_inet6.c  |    4 ++--
 net/ipv6/ping.c      |    1 +
 net/ipv6/raw.c       |    1 +
 net/ipv6/tcp_ipv6.c  |    1 +
 net/ipv6/udp.c       |    1 +
 net/ipv6/udplite.c   |    1 +
 net/l2tp/l2tp_ip6.c  |    4 +---
 net/mptcp/protocol.c |    1 +
 net/sctp/socket.c    |    1 +
 13 files changed, 16 insertions(+), 20 deletions(-)

--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -199,14 +199,7 @@ struct inet6_cork {
 	u8 tclass;
 };
 
-/**
- * struct ipv6_pinfo - ipv6 private area
- *
- * In the struct sock hierarchy (tcp6_sock, upd6_sock, etc)
- * this _must_ be the last member, so that inet6_sk_generic
- * is able to calculate its offset from the base struct sock
- * by using the struct proto->slab_obj_size member. -acme
- */
+/* struct ipv6_pinfo - ipv6 private area */
 struct ipv6_pinfo {
 	struct in6_addr 	saddr;
 	struct in6_pktinfo	sticky_pktinfo;
@@ -306,19 +299,19 @@ struct raw6_sock {
 	__u32			offset;		/* checksum offset  */
 	struct icmp6_filter	filter;
 	__u32			ip6mr_table;
-	/* ipv6_pinfo has to be the last member of raw6_sock, see inet6_sk_generic */
+
 	struct ipv6_pinfo	inet6;
 };
 
 struct udp6_sock {
 	struct udp_sock	  udp;
-	/* ipv6_pinfo has to be the last member of udp6_sock, see inet6_sk_generic */
+
 	struct ipv6_pinfo inet6;
 };
 
 struct tcp6_sock {
 	struct tcp_sock	  tcp;
-	/* ipv6_pinfo has to be the last member of tcp6_sock, see inet6_sk_generic */
+
 	struct ipv6_pinfo inet6;
 };
 
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1340,6 +1340,7 @@ struct proto {
 
 	struct kmem_cache	*slab;
 	unsigned int		obj_size;
+	unsigned int		ipv6_pinfo_offset;
 	slab_flags_t		slab_flags;
 	unsigned int		useroffset;	/* Usercopy region offset */
 	unsigned int		usersize;	/* Usercopy region size */
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -1056,6 +1056,7 @@ static struct proto dccp_v6_prot = {
 	.orphan_count	   = &dccp_orphan_count,
 	.max_header	   = MAX_DCCP_HEADER,
 	.obj_size	   = sizeof(struct dccp6_sock),
+	.ipv6_pinfo_offset = offsetof(struct dccp6_sock, inet6),
 	.slab_flags	   = SLAB_TYPESAFE_BY_RCU,
 	.rsk_prot	   = &dccp6_request_sock_ops,
 	.twsk_prot	   = &dccp6_timewait_sock_ops,
--- a/net/dccp/ipv6.h
+++ b/net/dccp/ipv6.h
@@ -13,10 +13,6 @@
 
 struct dccp6_sock {
 	struct dccp_sock  dccp;
-	/*
-	 * ipv6_pinfo has to be the last member of dccp6_sock,
-	 * see inet6_sk_generic.
-	 */
 	struct ipv6_pinfo inet6;
 };
 
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -102,9 +102,9 @@ bool ipv6_mod_enabled(void)
 }
 EXPORT_SYMBOL_GPL(ipv6_mod_enabled);
 
-static __inline__ struct ipv6_pinfo *inet6_sk_generic(struct sock *sk)
+static struct ipv6_pinfo *inet6_sk_generic(struct sock *sk)
 {
-	const int offset = sk->sk_prot->obj_size - sizeof(struct ipv6_pinfo);
+	const int offset = sk->sk_prot->ipv6_pinfo_offset;
 
 	return (struct ipv6_pinfo *)(((u8 *)sk) + offset);
 }
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -215,6 +215,7 @@ struct proto pingv6_prot = {
 	.get_port =	ping_get_port,
 	.put_port =	ping_unhash,
 	.obj_size =	sizeof(struct raw6_sock),
+	.ipv6_pinfo_offset = offsetof(struct raw6_sock, inet6),
 };
 EXPORT_SYMBOL_GPL(pingv6_prot);
 
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -1216,6 +1216,7 @@ struct proto rawv6_prot = {
 	.hash		   = raw_hash_sk,
 	.unhash		   = raw_unhash_sk,
 	.obj_size	   = sizeof(struct raw6_sock),
+	.ipv6_pinfo_offset = offsetof(struct raw6_sock, inet6),
 	.useroffset	   = offsetof(struct raw6_sock, filter),
 	.usersize	   = sizeof_field(struct raw6_sock, filter),
 	.h.raw_hash	   = &raw_v6_hashinfo,
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2176,6 +2176,7 @@ struct proto tcpv6_prot = {
 	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_rmem),
 	.max_header		= MAX_TCP_HEADER,
 	.obj_size		= sizeof(struct tcp6_sock),
+	.ipv6_pinfo_offset = offsetof(struct tcp6_sock, inet6),
 	.slab_flags		= SLAB_TYPESAFE_BY_RCU,
 	.twsk_prot		= &tcp6_timewait_sock_ops,
 	.rsk_prot		= &tcp6_request_sock_ops,
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1802,6 +1802,7 @@ struct proto udpv6_prot = {
 	.sysctl_wmem_offset     = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
 	.sysctl_rmem_offset     = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size		= sizeof(struct udp6_sock),
+	.ipv6_pinfo_offset = offsetof(struct udp6_sock, inet6),
 	.h.udp_table		= NULL,
 	.diag_destroy		= udp_abort,
 };
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -67,6 +67,7 @@ struct proto udplitev6_prot = {
 	.sysctl_wmem_offset = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
 	.sysctl_rmem_offset = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size	   = sizeof(struct udp6_sock),
+	.ipv6_pinfo_offset = offsetof(struct udp6_sock, inet6),
 	.h.udp_table	   = &udplite_table,
 };
 
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -36,9 +36,6 @@ struct l2tp_ip6_sock {
 	u32			conn_id;
 	u32			peer_conn_id;
 
-	/* ipv6_pinfo has to be the last member of l2tp_ip6_sock, see
-	 * inet6_sk_generic
-	 */
 	struct ipv6_pinfo	inet6;
 };
 
@@ -730,6 +727,7 @@ static struct proto l2tp_ip6_prot = {
 	.hash		   = l2tp_ip6_hash,
 	.unhash		   = l2tp_ip6_unhash,
 	.obj_size	   = sizeof(struct l2tp_ip6_sock),
+	.ipv6_pinfo_offset = offsetof(struct l2tp_ip6_sock, inet6),
 };
 
 static const struct proto_ops l2tp_ip6_ops = {
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3987,6 +3987,7 @@ int __init mptcp_proto_v6_init(void)
 	strcpy(mptcp_v6_prot.name, "MPTCPv6");
 	mptcp_v6_prot.slab = NULL;
 	mptcp_v6_prot.obj_size = sizeof(struct mptcp6_sock);
+	mptcp_v6_prot.ipv6_pinfo_offset = offsetof(struct mptcp6_sock, np);
 
 	err = proto_register(&mptcp_v6_prot, 1);
 	if (err)
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9732,6 +9732,7 @@ struct proto sctpv6_prot = {
 	.unhash		= sctp_unhash,
 	.no_autobind	= true,
 	.obj_size	= sizeof(struct sctp6_sock),
+	.ipv6_pinfo_offset = offsetof(struct sctp6_sock, inet6),
 	.useroffset	= offsetof(struct sctp6_sock, sctp.subscribe),
 	.usersize	= offsetof(struct sctp6_sock, sctp.initmsg) -
 				offsetof(struct sctp6_sock, sctp.subscribe) +


