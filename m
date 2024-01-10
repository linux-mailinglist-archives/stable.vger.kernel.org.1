Return-Path: <stable+bounces-10232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E442B8273DC
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C651F225AA
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700FE51C2B;
	Mon,  8 Jan 2024 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0nWSlmfO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8F51C5C;
	Mon,  8 Jan 2024 15:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8ABC433C9;
	Mon,  8 Jan 2024 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728403;
	bh=xBVbc0PYaokWRE1tN0zMfi/mF/aWkz7C/XIRMUVM/Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0nWSlmfO1mQWACCLNcHqNlKrfpg6ZF0msNBUWorBLKHjxVcg6LdpiNu3k7+KWX307
	 CGceyngZaJZ4657e7/BSfSjhnrt8GzNtMGolNhEmzITenSoNDS4qicuY+eKqNnNxA9
	 M2N82E53k0EBfpaAWt0deFg2mN+hR+UYaTrovUXA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 066/150] ipv4, ipv6: Use splice_eof() to flush
Date: Mon,  8 Jan 2024 16:35:17 +0100
Message-ID: <20240108153514.272821966@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 1d7e4538a5463faa0b0e26a7a7b6bd68c7dfdd78 ]

Allow splice to undo the effects of MSG_MORE after prematurely ending a
splice/sendfile due to getting an EOF condition (->splice_read() returned
0) after splice had called sendmsg() with MSG_MORE set when the user didn't
set MSG_MORE.

For UDP, a pending packet will not be emitted if the socket is closed
before it is flushed; with this change, it be flushed by ->splice_eof().

For TCP, it's not clear that MSG_MORE is actually effective.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/CAHk-=wh=V579PDYvkpnTobCLGczbgxpMgGmmhqiTyE34Cpi5Gg@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Kuniyuki Iwashima <kuniyu@amazon.com>
cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: David Ahern <dsahern@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: a0002127cd74 ("udp: move udp->no_check6_tx to udp->udp_flags")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_common.h |  1 +
 include/net/tcp.h         |  1 +
 include/net/udp.h         |  1 +
 net/ipv4/af_inet.c        | 18 ++++++++++++++++++
 net/ipv4/tcp.c            | 16 ++++++++++++++++
 net/ipv4/tcp_ipv4.c       |  1 +
 net/ipv4/udp.c            | 16 ++++++++++++++++
 net/ipv6/af_inet6.c       |  1 +
 net/ipv6/tcp_ipv6.c       |  1 +
 net/ipv6/udp.c            | 15 +++++++++++++++
 10 files changed, 71 insertions(+)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index cec453c18f1d6..4673bbfd2811f 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -33,6 +33,7 @@ int inet_accept(struct socket *sock, struct socket *newsock, int flags,
 		bool kern);
 int inet_send_prepare(struct sock *sk);
 int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size);
+void inet_splice_eof(struct socket *sock);
 ssize_t inet_sendpage(struct socket *sock, struct page *page, int offset,
 		      size_t size, int flags);
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index c3d56b337f358..4c838f7290dd9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -332,6 +332,7 @@ int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size);
 int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 			 size_t size, struct ubuf_info *uarg);
+void tcp_splice_eof(struct socket *sock);
 int tcp_sendpage(struct sock *sk, struct page *page, int offset, size_t size,
 		 int flags);
 int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
diff --git a/include/net/udp.h b/include/net/udp.h
index fee053bcd17c6..fa4cdbe55552c 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -269,6 +269,7 @@ int udp_get_port(struct sock *sk, unsigned short snum,
 int udp_err(struct sk_buff *, u32);
 int udp_abort(struct sock *sk, int err);
 int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
+void udp_splice_eof(struct socket *sock);
 int udp_push_pending_frames(struct sock *sk);
 void udp_flush_pending_frames(struct sock *sk);
 int udp_cmsg_send(struct sock *sk, struct msghdr *msg, u16 *gso_size);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 5d379df90c826..347c3768df6e8 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -838,6 +838,21 @@ int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 }
 EXPORT_SYMBOL(inet_sendmsg);
 
+void inet_splice_eof(struct socket *sock)
+{
+	const struct proto *prot;
+	struct sock *sk = sock->sk;
+
+	if (unlikely(inet_send_prepare(sk)))
+		return;
+
+	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
+	prot = READ_ONCE(sk->sk_prot);
+	if (prot->splice_eof)
+		prot->splice_eof(sock);
+}
+EXPORT_SYMBOL_GPL(inet_splice_eof);
+
 ssize_t inet_sendpage(struct socket *sock, struct page *page, int offset,
 		      size_t size, int flags)
 {
@@ -1057,6 +1072,7 @@ const struct proto_ops inet_stream_ops = {
 #ifdef CONFIG_MMU
 	.mmap		   = tcp_mmap,
 #endif
+	.splice_eof	   = inet_splice_eof,
 	.sendpage	   = inet_sendpage,
 	.splice_read	   = tcp_splice_read,
 	.read_sock	   = tcp_read_sock,
@@ -1091,6 +1107,7 @@ const struct proto_ops inet_dgram_ops = {
 	.read_skb	   = udp_read_skb,
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
+	.splice_eof	   = inet_splice_eof,
 	.sendpage	   = inet_sendpage,
 	.set_peek_off	   = sk_set_peek_off,
 #ifdef CONFIG_COMPAT
@@ -1122,6 +1139,7 @@ static const struct proto_ops inet_sockraw_ops = {
 	.sendmsg	   = inet_sendmsg,
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
+	.splice_eof	   = inet_splice_eof,
 	.sendpage	   = inet_sendpage,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet_compat_ioctl,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3935451ad061e..0b7844a8d5711 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1492,6 +1492,22 @@ int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 }
 EXPORT_SYMBOL(tcp_sendmsg);
 
+void tcp_splice_eof(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	struct tcp_sock *tp = tcp_sk(sk);
+	int mss_now, size_goal;
+
+	if (!tcp_write_queue_tail(sk))
+		return;
+
+	lock_sock(sk);
+	mss_now = tcp_send_mss(sk, &size_goal, 0);
+	tcp_push(sk, 0, mss_now, tp->nonagle, size_goal);
+	release_sock(sk);
+}
+EXPORT_SYMBOL_GPL(tcp_splice_eof);
+
 /*
  *	Handle reading urgent data. BSD has very simple semantics for
  *	this, no blocking and very strange errors 8)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7ebbbe561e402..be2c807eed15d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3067,6 +3067,7 @@ struct proto tcp_prot = {
 	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
+	.splice_eof		= tcp_splice_eof,
 	.sendpage		= tcp_sendpage,
 	.backlog_rcv		= tcp_v4_do_rcv,
 	.release_cb		= tcp_release_cb,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b49cb3df01bb4..e8dd2880ac9aa 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1332,6 +1332,21 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 }
 EXPORT_SYMBOL(udp_sendmsg);
 
+void udp_splice_eof(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	struct udp_sock *up = udp_sk(sk);
+
+	if (!up->pending || READ_ONCE(up->corkflag))
+		return;
+
+	lock_sock(sk);
+	if (up->pending && !READ_ONCE(up->corkflag))
+		udp_push_pending_frames(sk);
+	release_sock(sk);
+}
+EXPORT_SYMBOL_GPL(udp_splice_eof);
+
 int udp_sendpage(struct sock *sk, struct page *page, int offset,
 		 size_t size, int flags)
 {
@@ -2907,6 +2922,7 @@ struct proto udp_prot = {
 	.getsockopt		= udp_getsockopt,
 	.sendmsg		= udp_sendmsg,
 	.recvmsg		= udp_recvmsg,
+	.splice_eof		= udp_splice_eof,
 	.sendpage		= udp_sendpage,
 	.release_cb		= ip4_datagram_release_cb,
 	.hash			= udp_lib_hash,
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index b5309ae87fd79..a2f29ca516000 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -711,6 +711,7 @@ const struct proto_ops inet6_stream_ops = {
 #ifdef CONFIG_MMU
 	.mmap		   = tcp_mmap,
 #endif
+	.splice_eof	   = inet_splice_eof,
 	.sendpage	   = inet_sendpage,
 	.sendmsg_locked    = tcp_sendmsg_locked,
 	.sendpage_locked   = tcp_sendpage_locked,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7be89dcfd5fc5..ba9a22db5805c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2158,6 +2158,7 @@ struct proto tcpv6_prot = {
 	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
+	.splice_eof		= tcp_splice_eof,
 	.sendpage		= tcp_sendpage,
 	.backlog_rcv		= tcp_v6_do_rcv,
 	.release_cb		= tcp_release_cb,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 7f49f69226a21..2a65136dca773 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1657,6 +1657,20 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
 }
 
+static void udpv6_splice_eof(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	struct udp_sock *up = udp_sk(sk);
+
+	if (!up->pending || READ_ONCE(up->corkflag))
+		return;
+
+	lock_sock(sk);
+	if (up->pending && !READ_ONCE(up->corkflag))
+		udp_v6_push_pending_frames(sk);
+	release_sock(sk);
+}
+
 void udpv6_destroy_sock(struct sock *sk)
 {
 	struct udp_sock *up = udp_sk(sk);
@@ -1768,6 +1782,7 @@ struct proto udpv6_prot = {
 	.getsockopt		= udpv6_getsockopt,
 	.sendmsg		= udpv6_sendmsg,
 	.recvmsg		= udpv6_recvmsg,
+	.splice_eof		= udpv6_splice_eof,
 	.release_cb		= ip6_datagram_release_cb,
 	.hash			= udp_lib_hash,
 	.unhash			= udp_lib_unhash,
-- 
2.43.0




