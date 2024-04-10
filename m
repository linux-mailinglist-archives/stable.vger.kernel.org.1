Return-Path: <stable+bounces-37959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB55A89F0D6
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 13:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141121C21088
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 11:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C08115D5D8;
	Wed, 10 Apr 2024 11:28:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3062915CD57
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748497; cv=none; b=b7phej9Ifq1cUQi40yCEqPw5hbpCb6mxsD9UFeEdKYmWvDJsWpKflBlew7UkObjGASYi1jSDpAT+cAphvf5LmM7eBety6fVEgfQkxdAW/cjIuzN5PJM+R6B0+Qc6QzfAfYQg+CUMCJ7NJlSDoDJC9J2bTkKF4QhEpT92oOeOuG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748497; c=relaxed/simple;
	bh=qCOL8EJ3LpM8HxJJj6d5pZhvr/dKRCPRk7Dhd9WvNZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8VXRij1NgEUqeuPjWZTLrLy6ea3w+TGOdBMTYSE5q33P0K6JgWlX3A1q8+n0qPZ+GagdLV+gPOc2qerpKSivIPHWTNcXUlmutS6Y1weeID298gxMDFVufd3aZIFeghU9aOLInJ5qc9iD6JywgHpNj24B36YDakj4LjYIFBjeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 34FDE2F2024F; Wed, 10 Apr 2024 11:28:07 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 8259D2F20244;
	Wed, 10 Apr 2024 11:28:03 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Howells <dhowells@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org,
	Xin Long <lucien.xin@gmail.com>,
	Vadim Fedorenko <vfedorenko@novek.ru>,
	stable@vger.kernel.org
Subject: [PATCH 1/4 5.10] rxrpc: use udp tunnel APIs instead of open code in rxrpc_open_socket
Date: Wed, 10 Apr 2024 14:27:43 +0300
Message-ID: <20240410112747.2952012-2-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240410112747.2952012-1-oficerovas@altlinux.org>
References: <20240410112747.2952012-1-oficerovas@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 1a9b86c9fd9536b5c0dfbf7b4acbb7f61c820b74 ]

In rxrpc_open_socket(), now it's using sock_create_kern() and
kernel_bind() to create a udp tunnel socket, and other kernel
APIs to set up it. These code can be replaced with udp tunnel
APIs udp_sock_create() and setup_udp_tunnel_sock(), and it'll
simplify rxrpc_open_socket().

Note that with this patch, the udp tunnel socket will always
bind to a random port if transport is not provided by users,
which is suggested by David Howells, thanks!

Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Vadim Fedorenko <vfedorenko@novek.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: stable@vger.kernel.org
---
 net/rxrpc/local_object.c | 72 ++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 2c66ee981f395b..8f9c06fd37e984 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -16,6 +16,7 @@
 #include <linux/hashtable.h>
 #include <net/sock.h>
 #include <net/udp.h>
+#include <net/udp_tunnel.h>
 #include <net/af_rxrpc.h>
 #include "ar-internal.h"
 
@@ -106,58 +107,42 @@ static struct rxrpc_local *rxrpc_alloc_local(struct rxrpc_net *rxnet,
  */
 static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 {
+	struct udp_tunnel_sock_cfg tuncfg = {NULL};
+	struct sockaddr_rxrpc *srx = &local->srx;
+	struct udp_port_cfg udp_conf = {0};
 	struct sock *usk;
 	int ret;
 
 	_enter("%p{%d,%d}",
-	       local, local->srx.transport_type, local->srx.transport.family);
+	       local, srx->transport_type, srx->transport.family);
 
-	/* create a socket to represent the local endpoint */
-	ret = sock_create_kern(net, local->srx.transport.family,
-			       local->srx.transport_type, 0, &local->socket);
+	udp_conf.family = srx->transport.family;
+	if (udp_conf.family == AF_INET) {
+		udp_conf.local_ip = srx->transport.sin.sin_addr;
+		udp_conf.local_udp_port = srx->transport.sin.sin_port;
+	} else {
+		udp_conf.local_ip6 = srx->transport.sin6.sin6_addr;
+		udp_conf.local_udp_port = srx->transport.sin6.sin6_port;
+	}
+	ret = udp_sock_create(net, &udp_conf, &local->socket);
 	if (ret < 0) {
 		_leave(" = %d [socket]", ret);
 		return ret;
 	}
 
+	tuncfg.encap_type = UDP_ENCAP_RXRPC;
+	tuncfg.encap_rcv = rxrpc_input_packet;
+	tuncfg.sk_user_data = local;
+	setup_udp_tunnel_sock(net, local->socket, &tuncfg);
+
 	/* set the socket up */
 	usk = local->socket->sk;
-	inet_sk(usk)->mc_loop = 0;
-
-	/* Enable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
-	inet_inc_convert_csum(usk);
-
-	rcu_assign_sk_user_data(usk, local);
-
-	udp_sk(usk)->encap_type = UDP_ENCAP_RXRPC;
-	udp_sk(usk)->encap_rcv = rxrpc_input_packet;
-	udp_sk(usk)->encap_destroy = NULL;
-	udp_sk(usk)->gro_receive = NULL;
-	udp_sk(usk)->gro_complete = NULL;
-
-	udp_encap_enable();
-#if IS_ENABLED(CONFIG_AF_RXRPC_IPV6)
-	if (local->srx.transport.family == AF_INET6)
-		udpv6_encap_enable();
-#endif
 	usk->sk_error_report = rxrpc_error_report;
 
-	/* if a local address was supplied then bind it */
-	if (local->srx.transport_len > sizeof(sa_family_t)) {
-		_debug("bind");
-		ret = kernel_bind(local->socket,
-				  (struct sockaddr *)&local->srx.transport,
-				  local->srx.transport_len);
-		if (ret < 0) {
-			_debug("bind failed %d", ret);
-			goto error;
-		}
-	}
-
-	switch (local->srx.transport.family) {
+	switch (srx->transport.family) {
 	case AF_INET6:
 		/* we want to receive ICMPv6 errors */
-		ip6_sock_set_recverr(local->socket->sk);
+		ip6_sock_set_recverr(usk);
 
 		/* Fall through and set IPv4 options too otherwise we don't get
 		 * errors from IPv4 packets sent through the IPv6 socket.
@@ -165,13 +150,13 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 		fallthrough;
 	case AF_INET:
 		/* we want to receive ICMP errors */
-		ip_sock_set_recverr(local->socket->sk);
+		ip_sock_set_recverr(usk);
 
 		/* we want to set the don't fragment bit */
-		ip_sock_set_mtu_discover(local->socket->sk, IP_PMTUDISC_DO);
+		ip_sock_set_mtu_discover(usk, IP_PMTUDISC_DO);
 
 		/* We want receive timestamps. */
-		sock_enable_timestamps(local->socket->sk);
+		sock_enable_timestamps(usk);
 		break;
 
 	default:
@@ -180,15 +165,6 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 
 	_leave(" = 0");
 	return 0;
-
-error:
-	kernel_sock_shutdown(local->socket, SHUT_RDWR);
-	local->socket->sk->sk_user_data = NULL;
-	sock_release(local->socket);
-	local->socket = NULL;
-
-	_leave(" = %d", ret);
-	return ret;
 }
 
 /*
-- 
2.42.1


