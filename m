Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4854670BCF4
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 14:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjEVMIl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 08:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjEVMIk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 08:08:40 -0400
Received: from mail-ed1-x563.google.com (mail-ed1-x563.google.com [IPv6:2a00:1450:4864:20::563])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71138BA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 05:08:25 -0700 (PDT)
Received: by mail-ed1-x563.google.com with SMTP id 4fb4d7f45d1cf-510dabb3989so9857135a12.0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1684757303; x=1687349303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZQANtnYzYVh9bLE6o/zHcuLfWgH/zMHwwYGn/d3H40=;
        b=g5f3E9N8Xyga3zVJEohWNmVS3D89svqtP359KOi7he7s3NyCMgeZg2uic69TNJuzvS
         nbeOXM5VffRNvtQIg2YFOGBLxQgch7Pbr3UvFWMOV2SQKPDPbC/K8T08MeU7WQ83HUQU
         /5ZtGgTARgtSRcYCXbZA1CSAtsrvgQM6RRI+Jp/2177qyoOodS6KlSWigNlYiPyVLbUF
         EGdGNSLnbv+M33nPWqHL1UOVPBERbwBHhF6Qnh1c9Mi0xYUgAeDrN4SgU5uckS2sQrP/
         /32iykU8bbOFy/e7sjdgvs5Zdbjvl7/0aZXMFjfJ85eQPim6GbMjY2RARAaNJ3xhnLDd
         GKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684757303; x=1687349303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZQANtnYzYVh9bLE6o/zHcuLfWgH/zMHwwYGn/d3H40=;
        b=BYjpOSq7NN2gtdpg5dsUDqkc9NFdrOVcBskyIhRKeP4HWBul7XtPLXe0SkGhj7w7wA
         aC/RRPA7/zFXc6e18PeM0xmVO4EdgKRlFKFE1xyOaIm9uPsgNhofQnSgDz3VFM2UfmXj
         CDWKrfEgW/neAJAzbJwtyAfCgciXIgiwzfYuXbNacao2r9dnUQHC4ekA8q7YVbTCUxxb
         zDIrs3Xf+4k7zyhVdCeoeNE/EvDd6Na4JJjG/ziWKFUF1RDCW+xxx/h77bMM57ANTseQ
         p3Ur4PyWV7l55OT9qsx+PcLpL29zKURMnl1MH4Z07rhnSCnUQOZTO8dOwCJnYf8VGwRr
         ASyQ==
X-Gm-Message-State: AC+VfDyv83JNJJsitKE0CZ2+8RT7wELAK5uyG0SATYjOoLOKIlxbRFx0
        qHP97EHxHRIlMTJJB0te3Nl17tzB9h8GUQxwRAMrS9AhQwV+Zw==
X-Google-Smtp-Source: ACHHUZ4CQO8et14Y4Zk3ZBuYVEojUVYHEfqtzRRn5Vfzpoizo05yYezy/8U9DJcwvi4dsELQIETkkz+DEkxJ
X-Received: by 2002:a17:907:1607:b0:966:5912:c4b with SMTP id hb7-20020a170907160700b0096659120c4bmr10032375ejc.76.1684757303545;
        Mon, 22 May 2023 05:08:23 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id gh14-20020a170906e08e00b0096647f95cc2sm758300ejb.291.2023.05.22.05.08.23;
        Mon, 22 May 2023 05:08:23 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
        by smtpservice.6wind.com (Postfix) with ESMTPS id 42CA760115;
        Mon, 22 May 2023 14:08:23 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
        (envelope-from <nicolas.dichtel@6wind.com>)
        id 1q14Ks-005XEv-V8; Mon, 22 May 2023 14:08:22 +0200
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>
Cc:     Steffen Klassert <klassert@kernel.org>, netdev@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        stable@vger.kernel.org
Subject: [PATCH net v2] ipv{4,6}/raw: fix output xfrm lookup wrt protocol
Date:   Mon, 22 May 2023 14:08:20 +0200
Message-Id: <20230522120820.1319391-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
---

v1 -> v2:
 - accept only int in cmsg for IP_PROTOCOL

 include/net/ip.h        |  2 ++
 include/uapi/linux/in.h |  1 +
 net/ipv4/ip_sockglue.c  | 12 +++++++++++-
 net/ipv4/raw.c          |  5 ++++-
 net/ipv6/raw.c          |  3 ++-
 5 files changed, 20 insertions(+), 3 deletions(-)

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
-- 
2.39.2

