Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0777A7AC8
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjITLqE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjITLqD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:46:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72D4D6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:45:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18755C433CA;
        Wed, 20 Sep 2023 11:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210355;
        bh=EtCv9VIoc0R8RH+2Ex/5L36Z9EHXxW2Al38hHe1fJmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZLAND9Pp1ws70HdS71nTvH/n8ff/ZTf0m5Qd5H9Q45xiVrTYea7ediCB+tsVW4uFd
         D+sxZg7+w3xQeQmpS2q3WRezRnnmf/F7xRuLO8Ba34HgLyo2XSD0LPOE80i84Nakb7
         L95wSM+VjX6+piiKlv9sHMoo5GdsF7ATHqaE+a1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 046/211] netlink: convert nlk->flags to atomic flags
Date:   Wed, 20 Sep 2023 13:28:10 +0200
Message-ID: <20230920112847.216085577@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

[ Upstream commit 8fe08d70a2b61b35a0a1235c78cf321e7528351f ]

sk_diag_put_flags(), netlink_setsockopt(), netlink_getsockopt()
and others use nlk->flags without correct locking.

Use set_bit(), clear_bit(), test_bit(), assign_bit() to remove
data-races.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlink/af_netlink.c | 90 ++++++++++++++--------------------------
 net/netlink/af_netlink.h | 22 ++++++----
 net/netlink/diag.c       | 10 ++---
 3 files changed, 48 insertions(+), 74 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 3836318737483..20082171f24a3 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -84,7 +84,7 @@ struct listeners {
 
 static inline int netlink_is_kernel(struct sock *sk)
 {
-	return nlk_sk(sk)->flags & NETLINK_F_KERNEL_SOCKET;
+	return nlk_test_bit(KERNEL_SOCKET, sk);
 }
 
 struct netlink_table *nl_table __read_mostly;
@@ -349,9 +349,7 @@ static void netlink_deliver_tap_kernel(struct sock *dst, struct sock *src,
 
 static void netlink_overrun(struct sock *sk)
 {
-	struct netlink_sock *nlk = nlk_sk(sk);
-
-	if (!(nlk->flags & NETLINK_F_RECV_NO_ENOBUFS)) {
+	if (!nlk_test_bit(RECV_NO_ENOBUFS, sk)) {
 		if (!test_and_set_bit(NETLINK_S_CONGESTED,
 				      &nlk_sk(sk)->state)) {
 			sk->sk_err = ENOBUFS;
@@ -1402,9 +1400,7 @@ EXPORT_SYMBOL_GPL(netlink_has_listeners);
 
 bool netlink_strict_get_check(struct sk_buff *skb)
 {
-	const struct netlink_sock *nlk = nlk_sk(NETLINK_CB(skb).sk);
-
-	return nlk->flags & NETLINK_F_STRICT_CHK;
+	return nlk_test_bit(STRICT_CHK, NETLINK_CB(skb).sk);
 }
 EXPORT_SYMBOL_GPL(netlink_strict_get_check);
 
@@ -1448,7 +1444,7 @@ static void do_one_broadcast(struct sock *sk,
 		return;
 
 	if (!net_eq(sock_net(sk), p->net)) {
-		if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
+		if (!nlk_test_bit(LISTEN_ALL_NSID, sk))
 			return;
 
 		if (!peernet_has_id(sock_net(sk), p->net))
@@ -1481,7 +1477,7 @@ static void do_one_broadcast(struct sock *sk,
 		netlink_overrun(sk);
 		/* Clone failed. Notify ALL listeners. */
 		p->failure = 1;
-		if (nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR)
+		if (nlk_test_bit(BROADCAST_SEND_ERROR, sk))
 			p->delivery_failure = 1;
 		goto out;
 	}
@@ -1496,7 +1492,7 @@ static void do_one_broadcast(struct sock *sk,
 	val = netlink_broadcast_deliver(sk, p->skb2);
 	if (val < 0) {
 		netlink_overrun(sk);
-		if (nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR)
+		if (nlk_test_bit(BROADCAST_SEND_ERROR, sk))
 			p->delivery_failure = 1;
 	} else {
 		p->congested |= val;
@@ -1576,7 +1572,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 	    !test_bit(p->group - 1, nlk->groups))
 		goto out;
 
-	if (p->code == ENOBUFS && nlk->flags & NETLINK_F_RECV_NO_ENOBUFS) {
+	if (p->code == ENOBUFS && nlk_test_bit(RECV_NO_ENOBUFS, sk)) {
 		ret = 1;
 		goto out;
 	}
@@ -1643,7 +1639,7 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
 	unsigned int val = 0;
-	int err;
+	int nr = -1;
 
 	if (level != SOL_NETLINK)
 		return -ENOPROTOOPT;
@@ -1654,14 +1650,12 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case NETLINK_PKTINFO:
-		if (val)
-			nlk->flags |= NETLINK_F_RECV_PKTINFO;
-		else
-			nlk->flags &= ~NETLINK_F_RECV_PKTINFO;
-		err = 0;
+		nr = NETLINK_F_RECV_PKTINFO;
 		break;
 	case NETLINK_ADD_MEMBERSHIP:
 	case NETLINK_DROP_MEMBERSHIP: {
+		int err;
+
 		if (!netlink_allowed(sock, NL_CFG_F_NONROOT_RECV))
 			return -EPERM;
 		err = netlink_realloc_groups(sk);
@@ -1681,61 +1675,38 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 		if (optname == NETLINK_DROP_MEMBERSHIP && nlk->netlink_unbind)
 			nlk->netlink_unbind(sock_net(sk), val);
 
-		err = 0;
 		break;
 	}
 	case NETLINK_BROADCAST_ERROR:
-		if (val)
-			nlk->flags |= NETLINK_F_BROADCAST_SEND_ERROR;
-		else
-			nlk->flags &= ~NETLINK_F_BROADCAST_SEND_ERROR;
-		err = 0;
+		nr = NETLINK_F_BROADCAST_SEND_ERROR;
 		break;
 	case NETLINK_NO_ENOBUFS:
+		assign_bit(NETLINK_F_RECV_NO_ENOBUFS, &nlk->flags, val);
 		if (val) {
-			nlk->flags |= NETLINK_F_RECV_NO_ENOBUFS;
 			clear_bit(NETLINK_S_CONGESTED, &nlk->state);
 			wake_up_interruptible(&nlk->wait);
-		} else {
-			nlk->flags &= ~NETLINK_F_RECV_NO_ENOBUFS;
 		}
-		err = 0;
 		break;
 	case NETLINK_LISTEN_ALL_NSID:
 		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_BROADCAST))
 			return -EPERM;
-
-		if (val)
-			nlk->flags |= NETLINK_F_LISTEN_ALL_NSID;
-		else
-			nlk->flags &= ~NETLINK_F_LISTEN_ALL_NSID;
-		err = 0;
+		nr = NETLINK_F_LISTEN_ALL_NSID;
 		break;
 	case NETLINK_CAP_ACK:
-		if (val)
-			nlk->flags |= NETLINK_F_CAP_ACK;
-		else
-			nlk->flags &= ~NETLINK_F_CAP_ACK;
-		err = 0;
+		nr = NETLINK_F_CAP_ACK;
 		break;
 	case NETLINK_EXT_ACK:
-		if (val)
-			nlk->flags |= NETLINK_F_EXT_ACK;
-		else
-			nlk->flags &= ~NETLINK_F_EXT_ACK;
-		err = 0;
+		nr = NETLINK_F_EXT_ACK;
 		break;
 	case NETLINK_GET_STRICT_CHK:
-		if (val)
-			nlk->flags |= NETLINK_F_STRICT_CHK;
-		else
-			nlk->flags &= ~NETLINK_F_STRICT_CHK;
-		err = 0;
+		nr = NETLINK_F_STRICT_CHK;
 		break;
 	default:
-		err = -ENOPROTOOPT;
+		return -ENOPROTOOPT;
 	}
-	return err;
+	if (nr >= 0)
+		assign_bit(nr, &nlk->flags, val);
+	return 0;
 }
 
 static int netlink_getsockopt(struct socket *sock, int level, int optname,
@@ -1802,7 +1773,7 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 		return -EINVAL;
 
 	len = sizeof(int);
-	val = nlk->flags & flag ? 1 : 0;
+	val = test_bit(flag, &nlk->flags);
 
 	if (put_user(len, optlen) ||
 	    copy_to_user(optval, &val, len))
@@ -1979,9 +1950,9 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		msg->msg_namelen = sizeof(*addr);
 	}
 
-	if (nlk->flags & NETLINK_F_RECV_PKTINFO)
+	if (nlk_test_bit(RECV_PKTINFO, sk))
 		netlink_cmsg_recv_pktinfo(msg, skb);
-	if (nlk->flags & NETLINK_F_LISTEN_ALL_NSID)
+	if (nlk_test_bit(LISTEN_ALL_NSID, sk))
 		netlink_cmsg_listen_all_nsid(sk, msg, skb);
 
 	memset(&scm, 0, sizeof(scm));
@@ -2058,7 +2029,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 		goto out_sock_release;
 
 	nlk = nlk_sk(sk);
-	nlk->flags |= NETLINK_F_KERNEL_SOCKET;
+	set_bit(NETLINK_F_KERNEL_SOCKET, &nlk->flags);
 
 	netlink_table_grab();
 	if (!nl_table[unit].registered) {
@@ -2192,7 +2163,7 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 	nl_dump_check_consistent(cb, nlh);
 	memcpy(nlmsg_data(nlh), &nlk->dump_done_errno, sizeof(nlk->dump_done_errno));
 
-	if (extack->_msg && nlk->flags & NETLINK_F_EXT_ACK) {
+	if (extack->_msg && test_bit(NETLINK_F_EXT_ACK, &nlk->flags)) {
 		nlh->nlmsg_flags |= NLM_F_ACK_TLVS;
 		if (!nla_put_string(skb, NLMSGERR_ATTR_MSG, extack->_msg))
 			nlmsg_end(skb, nlh);
@@ -2321,8 +2292,8 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 			 const struct nlmsghdr *nlh,
 			 struct netlink_dump_control *control)
 {
-	struct netlink_sock *nlk, *nlk2;
 	struct netlink_callback *cb;
+	struct netlink_sock *nlk;
 	struct sock *sk;
 	int ret;
 
@@ -2357,8 +2328,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	cb->min_dump_alloc = control->min_dump_alloc;
 	cb->skb = skb;
 
-	nlk2 = nlk_sk(NETLINK_CB(skb).sk);
-	cb->strict_check = !!(nlk2->flags & NETLINK_F_STRICT_CHK);
+	cb->strict_check = nlk_test_bit(STRICT_CHK, NETLINK_CB(skb).sk);
 
 	if (control->start) {
 		cb->extack = control->extack;
@@ -2402,7 +2372,7 @@ netlink_ack_tlv_len(struct netlink_sock *nlk, int err,
 {
 	size_t tlvlen;
 
-	if (!extack || !(nlk->flags & NETLINK_F_EXT_ACK))
+	if (!extack || !test_bit(NETLINK_F_EXT_ACK, &nlk->flags))
 		return 0;
 
 	tlvlen = 0;
@@ -2474,7 +2444,7 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 	 * requests to cap the error message, and get extra error data if
 	 * requested.
 	 */
-	if (err && !(nlk->flags & NETLINK_F_CAP_ACK))
+	if (err && !test_bit(NETLINK_F_CAP_ACK, &nlk->flags))
 		payload += nlmsg_len(nlh);
 	else
 		flags |= NLM_F_CAPPED;
diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 90a3198a9b7f7..3dbd38aef50a4 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -8,14 +8,16 @@
 #include <net/sock.h>
 
 /* flags */
-#define NETLINK_F_KERNEL_SOCKET		0x1
-#define NETLINK_F_RECV_PKTINFO		0x2
-#define NETLINK_F_BROADCAST_SEND_ERROR	0x4
-#define NETLINK_F_RECV_NO_ENOBUFS	0x8
-#define NETLINK_F_LISTEN_ALL_NSID	0x10
-#define NETLINK_F_CAP_ACK		0x20
-#define NETLINK_F_EXT_ACK		0x40
-#define NETLINK_F_STRICT_CHK		0x80
+enum {
+	NETLINK_F_KERNEL_SOCKET,
+	NETLINK_F_RECV_PKTINFO,
+	NETLINK_F_BROADCAST_SEND_ERROR,
+	NETLINK_F_RECV_NO_ENOBUFS,
+	NETLINK_F_LISTEN_ALL_NSID,
+	NETLINK_F_CAP_ACK,
+	NETLINK_F_EXT_ACK,
+	NETLINK_F_STRICT_CHK,
+};
 
 #define NLGRPSZ(x)	(ALIGN(x, sizeof(unsigned long) * 8) / 8)
 #define NLGRPLONGS(x)	(NLGRPSZ(x)/sizeof(unsigned long))
@@ -23,10 +25,10 @@
 struct netlink_sock {
 	/* struct sock has to be the first member of netlink_sock */
 	struct sock		sk;
+	unsigned long		flags;
 	u32			portid;
 	u32			dst_portid;
 	u32			dst_group;
-	u32			flags;
 	u32			subscriptions;
 	u32			ngroups;
 	unsigned long		*groups;
@@ -54,6 +56,8 @@ static inline struct netlink_sock *nlk_sk(struct sock *sk)
 	return container_of(sk, struct netlink_sock, sk);
 }
 
+#define nlk_test_bit(nr, sk) test_bit(NETLINK_F_##nr, &nlk_sk(sk)->flags)
+
 struct netlink_table {
 	struct rhashtable	hash;
 	struct hlist_head	mc_list;
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index e4f21b1067bcc..9c4f231be2757 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -27,15 +27,15 @@ static int sk_diag_put_flags(struct sock *sk, struct sk_buff *skb)
 
 	if (nlk->cb_running)
 		flags |= NDIAG_FLAG_CB_RUNNING;
-	if (nlk->flags & NETLINK_F_RECV_PKTINFO)
+	if (nlk_test_bit(RECV_PKTINFO, sk))
 		flags |= NDIAG_FLAG_PKTINFO;
-	if (nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR)
+	if (nlk_test_bit(BROADCAST_SEND_ERROR, sk))
 		flags |= NDIAG_FLAG_BROADCAST_ERROR;
-	if (nlk->flags & NETLINK_F_RECV_NO_ENOBUFS)
+	if (nlk_test_bit(RECV_NO_ENOBUFS, sk))
 		flags |= NDIAG_FLAG_NO_ENOBUFS;
-	if (nlk->flags & NETLINK_F_LISTEN_ALL_NSID)
+	if (nlk_test_bit(LISTEN_ALL_NSID, sk))
 		flags |= NDIAG_FLAG_LISTEN_ALL_NSID;
-	if (nlk->flags & NETLINK_F_CAP_ACK)
+	if (nlk_test_bit(CAP_ACK, sk))
 		flags |= NDIAG_FLAG_CAP_ACK;
 
 	return nla_put_u32(skb, NETLINK_DIAG_FLAGS, flags);
-- 
2.40.1



