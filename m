Return-Path: <stable+bounces-215953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DZKHa7FjWnT6gAAu9opvQ
	(envelope-from <stable+bounces-215953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:21:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E439412D632
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A90F03078605
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C63570CC;
	Thu, 12 Feb 2026 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q9KQqNFu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B9346A1F;
	Thu, 12 Feb 2026 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898838; cv=none; b=Yuddlm3QhE+on2q9IDa9b6kFidWxC6iKqx5qpsVAmj1JPnaZKwZYSllyB4aI+l4hO0J6BOprhQiLRhAlPwX5/QURseRkhUOUMJkjZaNZKeT5qFv+oZT1PKqQOpcdlzEoypoKE/XLW+BZUknxK6KVfNV5xD258DoNVmhpXcILQb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898838; c=relaxed/simple;
	bh=m2KkbH62SiGwcjALVDFRgRDqfbnGM/aINi689so7cZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKg2fVgE1zvwj0ynPYOQg4wltpPjjBo016FZUkyL6RbztHmXTXfXy2yHGjZS44D80COCtrvYYe++XetNgq1OC/WSBLR1QYBL070ciMl6LdBQTimAlCaEUunDqrMOmtMwOBp813kAbsJ4m8iJbC7xTieNLTSnSByGpAdaER7BE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q9KQqNFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E268C4CEF7;
	Thu, 12 Feb 2026 12:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770898837;
	bh=m2KkbH62SiGwcjALVDFRgRDqfbnGM/aINi689so7cZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9KQqNFuYpgilFyEJJ/GS63gRRDEbCixifYts8m5C8daEw/xdWTodQjyZNQLWnaah
	 QNWy58XRaKM9ABBr27IhXqH9xFnrR0sB9wUi6e9CI0E3Xd+HbaQ2cq2mjUYOyinj3j
	 oChU/UtNQEnT3DEGQWcw4jIIhgXHlZ6TulHTtCPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.71
Date: Thu, 12 Feb 2026 13:20:25 +0100
Message-ID: <2026021249-afternoon-risk-b79d@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026021249-prepaid-scant-755b@gregkh>
References: <2026021249-prepaid-scant-755b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215953-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E439412D632
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index 3f2328829d28..443fa095f66f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 70
+SUBLEVEL = 71
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index e057526448d7..fa2dd76ba3d9 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -317,7 +317,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be32 saddr;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
 		return -EINVAL;
 
 	if (!sock)
@@ -387,7 +387,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
 		return -EINVAL;
 
 	if (!sock)
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 963fb9261f01..eea0875e4e55 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -827,7 +827,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
+	if (skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	if (!gs4)
@@ -937,7 +937,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
+	if (skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	if (!gs6)
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index bbfa4eed1755..c78451ed06ec 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2381,7 +2381,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	__be32 vni = 0;
 
 	no_eth_encap = flags & VXLAN_F_GPE && skb->protocol != htons(ETH_P_TEB);
-	if (!skb_vlan_inet_prepare(skb, no_eth_encap))
+	if (skb_vlan_inet_prepare(skb, no_eth_encap))
 		goto drop;
 
 	old_iph = ip_hdr(skb);
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 01fcf952b05d..1f92cc7fdbd2 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -467,11 +467,12 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 
 /* Variant of pskb_inet_may_pull().
  */
-static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
-					 bool inner_proto_inherit)
+static inline enum skb_drop_reason
+skb_vlan_inet_prepare(struct sk_buff *skb, bool inner_proto_inherit)
 {
 	int nhlen = 0, maclen = inner_proto_inherit ? 0 : ETH_HLEN;
 	__be16 type = skb->protocol;
+	enum skb_drop_reason reason;
 
 	/* Essentially this is skb_protocol(skb, true)
 	 * And we get MAC len.
@@ -492,11 +493,13 @@ static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
 	/* For ETH_P_IPV6/ETH_P_IP we make sure to pull
 	 * a base network header in skb->head.
 	 */
-	if (!pskb_may_pull(skb, maclen + nhlen))
-		return false;
+	reason = pskb_may_pull_reason(skb, maclen + nhlen);
+	if (reason)
+		return reason;
 
 	skb_set_network_header(skb, maclen);
-	return true;
+
+	return SKB_NOT_DROPPED_YET;
 }
 
 static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 996cd4bec482..1a38b3578367 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -953,6 +953,8 @@ int io_read(struct io_kiocb *req, unsigned int issue_flags)
 	if (ret >= 0)
 		return kiocb_done(req, ret, issue_flags);
 
+	if (req->flags & REQ_F_BUFFERS_COMMIT)
+		io_kbuf_recycle(req, issue_flags);
 	return ret;
 }
 
diff --git a/tools/testing/vsock/control.c b/tools/testing/vsock/control.c
index d2deb4b15b94..0066e0324d35 100644
--- a/tools/testing/vsock/control.c
+++ b/tools/testing/vsock/control.c
@@ -27,6 +27,7 @@
 
 #include "timeout.h"
 #include "control.h"
+#include "util.h"
 
 static int control_fd = -1;
 
@@ -50,7 +51,6 @@ void control_init(const char *control_host,
 
 	for (ai = result; ai; ai = ai->ai_next) {
 		int fd;
-		int val = 1;
 
 		fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
 		if (fd < 0)
@@ -65,11 +65,8 @@ void control_init(const char *control_host,
 			break;
 		}
 
-		if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR,
-			       &val, sizeof(val)) < 0) {
-			perror("setsockopt");
-			exit(EXIT_FAILURE);
-		}
+		setsockopt_int_check(fd, SOL_SOCKET, SO_REUSEADDR, 1,
+				     "setsockopt SO_REUSEADDR");
 
 		if (bind(fd, ai->ai_addr, ai->ai_addrlen) < 0)
 			goto next;
diff --git a/tools/testing/vsock/msg_zerocopy_common.c b/tools/testing/vsock/msg_zerocopy_common.c
index 5a4bdf7b5132..8622e5a0f8b7 100644
--- a/tools/testing/vsock/msg_zerocopy_common.c
+++ b/tools/testing/vsock/msg_zerocopy_common.c
@@ -14,16 +14,6 @@
 
 #include "msg_zerocopy_common.h"
 
-void enable_so_zerocopy(int fd)
-{
-	int val = 1;
-
-	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
-		perror("setsockopt");
-		exit(EXIT_FAILURE);
-	}
-}
-
 void vsock_recv_completion(int fd, const bool *zerocopied)
 {
 	struct sock_extended_err *serr;
diff --git a/tools/testing/vsock/msg_zerocopy_common.h b/tools/testing/vsock/msg_zerocopy_common.h
index 3763c5ccedb9..ad14139e93ca 100644
--- a/tools/testing/vsock/msg_zerocopy_common.h
+++ b/tools/testing/vsock/msg_zerocopy_common.h
@@ -12,7 +12,6 @@
 #define VSOCK_RECVERR	1
 #endif
 
-void enable_so_zerocopy(int fd);
 void vsock_recv_completion(int fd, const bool *zerocopied);
 
 #endif /* MSG_ZEROCOPY_COMMON_H */
diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 8a899a9fc9a9..894221a1ff31 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -663,3 +663,145 @@ void free_test_iovec(const struct iovec *test_iovec,
 
 	free(iovec);
 }
+
+/* Set "unsigned long long" socket option and check that it's indeed set */
+void setsockopt_ull_check(int fd, int level, int optname,
+			  unsigned long long val, char const *errmsg)
+{
+	unsigned long long chkval;
+	socklen_t chklen;
+	int err;
+
+	err = setsockopt(fd, level, optname, &val, sizeof(val));
+	if (err) {
+		fprintf(stderr, "setsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	chkval = ~val; /* just make storage != val */
+	chklen = sizeof(chkval);
+
+	err = getsockopt(fd, level, optname, &chkval, &chklen);
+	if (err) {
+		fprintf(stderr, "getsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	if (chklen != sizeof(chkval)) {
+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
+			chklen);
+		goto fail;
+	}
+
+	if (chkval != val) {
+		fprintf(stderr, "value mismatch: set %llu got %llu\n", val,
+			chkval);
+		goto fail;
+	}
+	return;
+fail:
+	fprintf(stderr, "%s  val %llu\n", errmsg, val);
+	exit(EXIT_FAILURE);
+;
+}
+
+/* Set "int" socket option and check that it's indeed set */
+void setsockopt_int_check(int fd, int level, int optname, int val,
+			  char const *errmsg)
+{
+	int chkval;
+	socklen_t chklen;
+	int err;
+
+	err = setsockopt(fd, level, optname, &val, sizeof(val));
+	if (err) {
+		fprintf(stderr, "setsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	chkval = ~val; /* just make storage != val */
+	chklen = sizeof(chkval);
+
+	err = getsockopt(fd, level, optname, &chkval, &chklen);
+	if (err) {
+		fprintf(stderr, "getsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	if (chklen != sizeof(chkval)) {
+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
+			chklen);
+		goto fail;
+	}
+
+	if (chkval != val) {
+		fprintf(stderr, "value mismatch: set %d got %d\n", val, chkval);
+		goto fail;
+	}
+	return;
+fail:
+	fprintf(stderr, "%s val %d\n", errmsg, val);
+	exit(EXIT_FAILURE);
+}
+
+static void mem_invert(unsigned char *mem, size_t size)
+{
+	size_t i;
+
+	for (i = 0; i < size; i++)
+		mem[i] = ~mem[i];
+}
+
+/* Set "timeval" socket option and check that it's indeed set */
+void setsockopt_timeval_check(int fd, int level, int optname,
+			      struct timeval val, char const *errmsg)
+{
+	struct timeval chkval;
+	socklen_t chklen;
+	int err;
+
+	err = setsockopt(fd, level, optname, &val, sizeof(val));
+	if (err) {
+		fprintf(stderr, "setsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	 /* just make storage != val */
+	chkval = val;
+	mem_invert((unsigned char *)&chkval, sizeof(chkval));
+	chklen = sizeof(chkval);
+
+	err = getsockopt(fd, level, optname, &chkval, &chklen);
+	if (err) {
+		fprintf(stderr, "getsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	if (chklen != sizeof(chkval)) {
+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
+			chklen);
+		goto fail;
+	}
+
+	if (memcmp(&chkval, &val, sizeof(val)) != 0) {
+		fprintf(stderr, "value mismatch: set %ld:%ld got %ld:%ld\n",
+			val.tv_sec, val.tv_usec, chkval.tv_sec, chkval.tv_usec);
+		goto fail;
+	}
+	return;
+fail:
+	fprintf(stderr, "%s val %ld:%ld\n", errmsg, val.tv_sec, val.tv_usec);
+	exit(EXIT_FAILURE);
+}
+
+void enable_so_zerocopy_check(int fd)
+{
+	setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
+			     "setsockopt SO_ZEROCOPY");
+}
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index fff22d4a14c0..ba84d296d8b7 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -68,4 +68,11 @@ unsigned long iovec_hash_djb2(const struct iovec *iov, size_t iovnum);
 struct iovec *alloc_test_iovec(const struct iovec *test_iovec, int iovnum);
 void free_test_iovec(const struct iovec *test_iovec,
 		     struct iovec *iovec, int iovnum);
+void setsockopt_ull_check(int fd, int level, int optname,
+			  unsigned long long val, char const *errmsg);
+void setsockopt_int_check(int fd, int level, int optname, int val,
+			  char const *errmsg);
+void setsockopt_timeval_check(int fd, int level, int optname,
+			      struct timeval val, char const *errmsg);
+void enable_so_zerocopy_check(int fd);
 #endif /* UTIL_H */
diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
index 8e0a6c0770d3..75971ac708c9 100644
--- a/tools/testing/vsock/vsock_perf.c
+++ b/tools/testing/vsock/vsock_perf.c
@@ -251,6 +251,16 @@ static void run_receiver(int rcvlowat_bytes)
 	close(fd);
 }
 
+static void enable_so_zerocopy(int fd)
+{
+	int val = 1;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
+		perror("setsockopt");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static void run_sender(int peer_cid, unsigned long to_send_bytes)
 {
 	time_t tx_begin_ns;
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 79ef11c0ab14..8855094202d4 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -455,17 +455,13 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 
 	sock_buf_size = SOCK_BUF_SIZE;
 
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
-		       &sock_buf_size, sizeof(sock_buf_size))) {
-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
 
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
-		       &sock_buf_size, sizeof(sock_buf_size))) {
-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
 
 	/* Ready to receive data. */
 	control_writeln("SRVREADY");
@@ -597,10 +593,8 @@ static void test_seqpacket_timeout_client(const struct test_opts *opts)
 	tv.tv_sec = RCVTIMEO_TIMEOUT_SEC;
 	tv.tv_usec = 0;
 
-	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (void *)&tv, sizeof(tv)) == -1) {
-		perror("setsockopt(SO_RCVTIMEO)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_timeval_check(fd, SOL_SOCKET, SO_RCVTIMEO, tv,
+				 "setsockopt(SO_RCVTIMEO)");
 
 	read_enter_ns = current_nsec();
 
@@ -866,11 +860,8 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
-	if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
-		       &lowat_val, sizeof(lowat_val))) {
-		perror("setsockopt(SO_RCVLOWAT)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
+			     lowat_val, "setsockopt(SO_RCVLOWAT)");
 
 	control_expectln("SRVSENT");
 
@@ -1398,11 +1389,9 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 	/* size_t can be < unsigned long long */
 	sock_buf_size = buf_size;
 
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
-		       &sock_buf_size, sizeof(sock_buf_size))) {
-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
 
 	if (low_rx_bytes_test) {
 		/* Set new SO_RCVLOWAT here. This enables sending credit
@@ -1411,11 +1400,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 		 */
 		recv_buf_size = 1 + VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
 
-		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
-			       &recv_buf_size, sizeof(recv_buf_size))) {
-			perror("setsockopt(SO_RCVLOWAT)");
-			exit(EXIT_FAILURE);
-		}
+		setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
+				     recv_buf_size, "setsockopt(SO_RCVLOWAT)");
 	}
 
 	/* Send one dummy byte here, because 'setsockopt()' above also
@@ -1457,11 +1443,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 		recv_buf_size++;
 
 		/* Updating SO_RCVLOWAT will send credit update. */
-		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
-			       &recv_buf_size, sizeof(recv_buf_size))) {
-			perror("setsockopt(SO_RCVLOWAT)");
-			exit(EXIT_FAILURE);
-		}
+		setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
+				     recv_buf_size, "setsockopt(SO_RCVLOWAT)");
 	}
 
 	fds.fd = fd;
diff --git a/tools/testing/vsock/vsock_test_zerocopy.c b/tools/testing/vsock/vsock_test_zerocopy.c
index 04c376b6937f..9d9a6cb9614a 100644
--- a/tools/testing/vsock/vsock_test_zerocopy.c
+++ b/tools/testing/vsock/vsock_test_zerocopy.c
@@ -162,7 +162,7 @@ static void test_client(const struct test_opts *opts,
 	}
 
 	if (test_data->so_zerocopy)
-		enable_so_zerocopy(fd);
+		enable_so_zerocopy_check(fd);
 
 	iovec = alloc_test_iovec(test_data->vecs, test_data->vecs_cnt);
 
diff --git a/tools/testing/vsock/vsock_uring_test.c b/tools/testing/vsock/vsock_uring_test.c
index 6c3e6f70c457..5c3078969659 100644
--- a/tools/testing/vsock/vsock_uring_test.c
+++ b/tools/testing/vsock/vsock_uring_test.c
@@ -73,7 +73,7 @@ static void vsock_io_uring_client(const struct test_opts *opts,
 	}
 
 	if (msg_zerocopy)
-		enable_so_zerocopy(fd);
+		enable_so_zerocopy_check(fd);
 
 	iovec = alloc_test_iovec(test_data->vecs, test_data->vecs_cnt);
 

