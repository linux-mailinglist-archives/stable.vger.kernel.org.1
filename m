Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1CE719DE1
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjFAN1K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjFAN06 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E100FE50
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67106644C5
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805B4C433EF;
        Thu,  1 Jun 2023 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625999;
        bh=mcbedARLwUXMKsgZpndP9bwAbacGMN2FIKNS4cIMrqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4syUUFsoFRXphhfhx+AelndfqMfreu17FRyxJv+267todoNQmKhNLAMx8BRasp/h
         3GTLqtk0NVJrWsVw/Wsk3KCbacKe38y1QLYlSfR6N5erXdhV9AgcGzgNyVDBeT1RVP
         MMpGL4bz/I0GcEbRphHKKKxQzExLY0/4iWC/U8nY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 36/45] bpf, sockmap: Incorrectly handling copied_seq
Date:   Thu,  1 Jun 2023 14:21:32 +0100
Message-Id: <20230601131940.300804076@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit e5c6de5fa025882babf89cecbed80acf49b987fa ]

The read_skb() logic is incrementing the tcp->copied_seq which is used for
among other things calculating how many outstanding bytes can be read by
the application. This results in application errors, if the application
does an ioctl(FIONREAD) we return zero because this is calculated from
the copied_seq value.

To fix this we move tcp->copied_seq accounting into the recv handler so
that we update these when the recvmsg() hook is called and data is in
fact copied into user buffers. This gives an accurate FIONREAD value
as expected and improves ACK handling. Before we were calling the
tcp_rcv_space_adjust() which would update 'number of bytes copied to
user in last RTT' which is wrong for programs returning SK_PASS. The
bytes are only copied to the user when recvmsg is handled.

Doing the fix for recvmsg is straightforward, but fixing redirect and
SK_DROP pkts is a bit tricker. Build a tcp_psock_eat() helper and then
call this from skmsg handlers. This fixes another issue where a broken
socket with a BPF program doing a resubmit could hang the receiver. This
happened because although read_skb() consumed the skb through sock_drop()
it did not update the copied_seq. Now if a single reccv socket is
redirecting to many sockets (for example for lb) the receiver sk will be
hung even though we might expect it to continue. The hang comes from
not updating the copied_seq numbers and memory pressure resulting from
that.

We have a slight layer problem of calling tcp_eat_skb even if its not
a TCP socket. To fix we could refactor and create per type receiver
handlers. I decided this is more work than we want in the fix and we
already have some small tweaks depending on caller that use the
helper skb_bpf_strparser(). So we extend that a bit and always set
the strparser bit when it is in use and then we can gate the
seq_copied updates on this.

Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20230523025618.113937-9-john.fastabend@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h  | 10 ++++++++++
 net/core/skmsg.c   | 15 +++++++--------
 net/ipv4/tcp.c     | 10 +---------
 net/ipv4/tcp_bpf.c | 28 +++++++++++++++++++++++++++-
 4 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index db9f828e9d1ee..76bf0a11bdc77 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1467,6 +1467,8 @@ static inline void tcp_adjust_rcv_ssthresh(struct sock *sk)
 }
 
 void tcp_cleanup_rbuf(struct sock *sk, int copied);
+void __tcp_cleanup_rbuf(struct sock *sk, int copied);
+
 
 /* We provision sk_rcvbuf around 200% of sk_rcvlowat.
  * If 87.5 % (7/8) of the space has been consumed, we want to override
@@ -2323,6 +2325,14 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
 #endif /* CONFIG_BPF_SYSCALL */
 
+#ifdef CONFIG_INET
+void tcp_eat_skb(struct sock *sk, struct sk_buff *skb);
+#else
+static inline void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
+{
+}
+#endif
+
 int tcp_bpf_sendmsg_redir(struct sock *sk, bool ingress,
 			  struct sk_msg *msg, u32 bytes, int flags);
 #endif /* CONFIG_NET_SOCK_MSG */
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 08be5f409fb89..a9060e1f0e437 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -979,10 +979,8 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 		err = -EIO;
 		sk_other = psock->sk;
 		if (sock_flag(sk_other, SOCK_DEAD) ||
-		    !sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
-			skb_bpf_redirect_clear(skb);
+		    !sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
 			goto out_free;
-		}
 
 		skb_bpf_set_ingress(skb);
 
@@ -1011,18 +1009,19 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 				err = 0;
 			}
 			spin_unlock_bh(&psock->ingress_lock);
-			if (err < 0) {
-				skb_bpf_redirect_clear(skb);
+			if (err < 0)
 				goto out_free;
-			}
 		}
 		break;
 	case __SK_REDIRECT:
+		tcp_eat_skb(psock->sk, skb);
 		err = sk_psock_skb_redirect(psock, skb);
 		break;
 	case __SK_DROP:
 	default:
 out_free:
+		skb_bpf_redirect_clear(skb);
+		tcp_eat_skb(psock->sk, skb);
 		sock_drop(psock->sk, skb);
 	}
 
@@ -1067,8 +1066,7 @@ static void sk_psock_strp_read(struct strparser *strp, struct sk_buff *skb)
 		skb_dst_drop(skb);
 		skb_bpf_redirect_clear(skb);
 		ret = bpf_prog_run_pin_on_cpu(prog, skb);
-		if (ret == SK_PASS)
-			skb_bpf_set_strparser(skb);
+		skb_bpf_set_strparser(skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
 		skb->sk = NULL;
 	}
@@ -1176,6 +1174,7 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
 		len = 0;
+		tcp_eat_skb(sk, skb);
 		sock_drop(sk, skb);
 		goto out;
 	}
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 01ea2705deea9..ed63ee8f0d7e3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1570,7 +1570,7 @@ static int tcp_peek_sndq(struct sock *sk, struct msghdr *msg, int len)
  * calculation of whether or not we must ACK for the sake of
  * a window update.
  */
-static void __tcp_cleanup_rbuf(struct sock *sk, int copied)
+void __tcp_cleanup_rbuf(struct sock *sk, int copied)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	bool time_to_ack = false;
@@ -1785,14 +1785,6 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 			break;
 		}
 	}
-	WRITE_ONCE(tp->copied_seq, seq);
-
-	tcp_rcv_space_adjust(sk);
-
-	/* Clean up data we have read: This will do ACK frames. */
-	if (copied > 0)
-		__tcp_cleanup_rbuf(sk, copied);
-
 	return copied;
 }
 EXPORT_SYMBOL(tcp_read_skb);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 01dd76be1a584..5f93918c063c7 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -11,6 +11,24 @@
 #include <net/inet_common.h>
 #include <net/tls.h>
 
+void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
+{
+	struct tcp_sock *tcp;
+	int copied;
+
+	if (!skb || !skb->len || !sk_is_tcp(sk))
+		return;
+
+	if (skb_bpf_strparser(skb))
+		return;
+
+	tcp = tcp_sk(sk);
+	copied = tcp->copied_seq + skb->len;
+	WRITE_ONCE(tcp->copied_seq, copied);
+	tcp_rcv_space_adjust(sk);
+	__tcp_cleanup_rbuf(sk, skb->len);
+}
+
 static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 			   struct sk_msg *msg, u32 apply_bytes, int flags)
 {
@@ -198,8 +216,10 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 				  int flags,
 				  int *addr_len)
 {
+	struct tcp_sock *tcp = tcp_sk(sk);
+	u32 seq = tcp->copied_seq;
 	struct sk_psock *psock;
-	int copied;
+	int copied = 0;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len, addr_len);
@@ -244,9 +264,11 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 
 		if (is_fin) {
 			copied = 0;
+			seq++;
 			goto out;
 		}
 	}
+	seq += copied;
 	if (!copied) {
 		long timeo;
 		int data;
@@ -284,6 +306,10 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		copied = -EAGAIN;
 	}
 out:
+	WRITE_ONCE(tcp->copied_seq, seq);
+	tcp_rcv_space_adjust(sk);
+	if (copied > 0)
+		__tcp_cleanup_rbuf(sk, copied);
 	release_sock(sk);
 	sk_psock_put(sk, psock);
 	return copied;
-- 
2.39.2



