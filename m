Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC9712D0E
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243782AbjEZTFs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 15:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243813AbjEZTFq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 15:05:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CF313D
        for <stable@vger.kernel.org>; Fri, 26 May 2023 12:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40A18652C3
        for <stable@vger.kernel.org>; Fri, 26 May 2023 19:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DB3C433D2;
        Fri, 26 May 2023 19:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685127938;
        bh=mfueDL+RCoAcDwQ2gWPn6CemZwDuN2Tt9CTGWreqtZU=;
        h=Subject:To:Cc:From:Date:From;
        b=tmQ4PAuM3cER2rOcp/5fMkhnl4QyY6SG1T8pzQmh99kgoq+2ZIuiyGFpy1CIdS/xF
         8vAz9abasRNg6m0dKGRMHsYmK3Pwk0xYy8NpEn75OL94l2VIxj92GPiECm89Ihd0Fh
         GDRjwVgDAyKNL8hOMgYA4/U/g8eIf1QvYryQnmMk=
Subject: FAILED: patch "[PATCH] ipv{4,6}/raw: fix output xfrm lookup wrt protocol" failed to apply to 5.10-stable tree
To:     nicolas.dichtel@6wind.com, pabeni@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 26 May 2023 20:05:34 +0100
Message-ID: <2023052634-surgical-sulfite-a551@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3632679d9e4f879f49949bb5b050e0de553e4739
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052634-surgical-sulfite-a551@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

3632679d9e4f ("ipv{4,6}/raw: fix output xfrm lookup wrt protocol")
91d0b78c5177 ("inet: Add IP_LOCAL_PORT_RANGE socket option")
28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
d2c135619cb8 ("inet: add READ_ONCE(sk->sk_bound_dev_if) in inet_csk_bind_conflict()")
ca7af0402550 ("tcp: add small random increments to the source port")
ffa84b5ffb37 ("net: add netns refcount tracker to struct sock")
938cca9e4109 ("sock: fix /proc/net/sockstat underflow in sk_clone_lock()")
990c74e3f41d ("memcg: enable accounting for inet_bin_bucket cache")
333bb73f620e ("tcp: Keep TCP_CLOSE sockets in the reuseport group.")
5c040eaf5d17 ("tcp: Add num_closed_socks to struct sock_reuseport.")
c579bd1b4021 ("tcp: add some entropy in __inet_hash_connect()")
190cc82489f4 ("tcp: change source port randomizarion at connect() time")
bbc20b70424a ("net: reduce indentation level in sk_clone_lock()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3632679d9e4f879f49949bb5b050e0de553e4739 Mon Sep 17 00:00:00 2001
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Mon, 22 May 2023 14:08:20 +0200
Subject: [PATCH] ipv{4,6}/raw: fix output xfrm lookup wrt protocol

With a raw socket bound to IPPROTO_RAW (ie with hdrincl enabled), the
protocol field of the flow structure, build by raw_sendmsg() /
rawv6_sendmsg()),  is set to IPPROTO_RAW. This breaks the ipsec policy
lookup when some policies are defined with a protocol in the selector.

For ipv6, the sin6_port field from 'struct sockaddr_in6' could be used to
specify the protocol. Just accept all values for IPPROTO_RAW socket.

For ipv4, the sin_port field of 'struct sockaddr_in' could not be used
without breaking backward compatibility (the value of this field was never
checked). Let's add a new kind of control message, so that the userland
could specify which protocol is used.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
CC: stable@vger.kernel.org
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Link: https://lore.kernel.org/r/20230522120820.1319391-1-nicolas.dichtel@6wind.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/include/net/ip.h b/include/net/ip.h
index c3fffaa92d6e..acec504c469a 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -76,6 +76,7 @@ struct ipcm_cookie {
 	__be32			addr;
 	int			oif;
 	struct ip_options_rcu	*opt;
+	__u8			protocol;
 	__u8			ttl;
 	__s16			tos;
 	char			priority;
@@ -96,6 +97,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 	ipcm->sockc.tsflags = inet->sk.sk_tsflags;
 	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
 	ipcm->addr = inet->inet_saddr;
+	ipcm->protocol = inet->inet_num;
 }
 
 #define IPCB(skb) ((struct inet_skb_parm*)((skb)->cb))
diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index 4b7f2df66b99..e682ab628dfa 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -163,6 +163,7 @@ struct in_addr {
 #define IP_MULTICAST_ALL		49
 #define IP_UNICAST_IF			50
 #define IP_LOCAL_PORT_RANGE		51
+#define IP_PROTOCOL			52
 
 #define MCAST_EXCLUDE	0
 #define MCAST_INCLUDE	1
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index b511ff0adc0a..8e97d8d4cc9d 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -317,7 +317,14 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
 			ipc->tos = val;
 			ipc->priority = rt_tos2priority(ipc->tos);
 			break;
-
+		case IP_PROTOCOL:
+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(int)))
+				return -EINVAL;
+			val = *(int *)CMSG_DATA(cmsg);
+			if (val < 1 || val > 255)
+				return -EINVAL;
+			ipc->protocol = val;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1761,6 +1768,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_LOCAL_PORT_RANGE:
 		val = inet->local_port_range.hi << 16 | inet->local_port_range.lo;
 		break;
+	case IP_PROTOCOL:
+		val = inet_sk(sk)->inet_num;
+		break;
 	default:
 		sockopt_release_sock(sk);
 		return -ENOPROTOOPT;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index ff712bf2a98d..eadf1c9ef7e4 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -532,6 +532,9 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	ipcm_init_sk(&ipc, inet);
+	/* Keep backward compat */
+	if (hdrincl)
+		ipc.protocol = IPPROTO_RAW;
 
 	if (msg->msg_controllen) {
 		err = ip_cmsg_send(sk, msg, &ipc, false);
@@ -599,7 +602,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark, tos,
 			   RT_SCOPE_UNIVERSE,
-			   hdrincl ? IPPROTO_RAW : sk->sk_protocol,
+			   hdrincl ? ipc.protocol : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk) |
 			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
 			   daddr, saddr, 0, 0, sk->sk_uid);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 7d0adb612bdd..44ee7a2e72ac 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -793,7 +793,8 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 		if (!proto)
 			proto = inet->inet_num;
-		else if (proto != inet->inet_num)
+		else if (proto != inet->inet_num &&
+			 inet->inet_num != IPPROTO_RAW)
 			return -EINVAL;
 
 		if (proto > 255)

