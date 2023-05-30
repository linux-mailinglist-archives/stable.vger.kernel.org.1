Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4997169AA
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 18:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjE3QeC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 12:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjE3QeC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 12:34:02 -0400
Received: from mail-lj1-x263.google.com (mail-lj1-x263.google.com [IPv6:2a00:1450:4864:20::263])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD751116
        for <stable@vger.kernel.org>; Tue, 30 May 2023 09:33:33 -0700 (PDT)
Received: by mail-lj1-x263.google.com with SMTP id 38308e7fff4ca-2af2f4e719eso51160991fa.2
        for <stable@vger.kernel.org>; Tue, 30 May 2023 09:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1685464410; x=1688056410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8n22IGV9esuAfBWs9oOSxsrsS7nQAkK78qcSaHES4Rs=;
        b=DeceJrieFSzTsXrPnKZPKRrf0kMTRewyKGgHftrOfZqDVlTboeByhRL/uWZ2mAckPm
         /rO7nIE/S+PicOUuVaoShjWoMedotNUfXrFzBTtr2ouCSdrLoDyBTU5zb/HXKwC7YPUi
         +0VQVKLkMhByzcUvJBKM7gCQMphcGqKa8fjKqMZIl3oSNlxj5EyJezTvFXy44sAeqOiW
         j1VhU1Jj+hBwiNLtL6VvbuB1v79Sd9GhOuKtkLfvBV7b3nG8SC6PZoAB9dPtWls31Exg
         pMva/UShCJXrRyr6cdtkvtwOdXtN4YubiremO0exDHjN5bjosuKIe9h48LJvc7oIyNiO
         fpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685464410; x=1688056410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n22IGV9esuAfBWs9oOSxsrsS7nQAkK78qcSaHES4Rs=;
        b=X5+kNgmaOq9MhhNPI56v5+z3SDXpzRs++mKzZFGvDG18ITLcu71CD77jy4LFHwIxht
         Q3E9k7Br4rCNfa6rf0n3ejStEJdUwMaO4gQpmPICg2WaZEw0mapMtZHoP9OHIUb+jv5h
         SQ5ppSe3VwDHAm/Q2XJ2M0mV0o62HUZB3fCRPnBkDZUuMxGZ4HNN0ajLQ2Yx82Bw1xuY
         v3YAt5OsJAqmoreF1JuBCZOqmByPa4KCh9Nf7BtXk2zl9qJ3vMhFPRbonx3TOtuqZk8T
         s6w159FbtZoW71zXdO2q0FD6nF+TyDr++NU4X6KdvtgGStiH4cNTugiXkEtsjvDaGhEk
         kVkw==
X-Gm-Message-State: AC+VfDy26mq966mvOZAwj3pvIC6QnZ4Z1RrbWY1uQcx488b6cXdmJdEf
        XniuCL+mSBZpwWK9J5BvCqZbP1ErclQQprJ2fRvafAKFkeXESg==
X-Google-Smtp-Source: ACHHUZ4rwLP3oSwnPD+HiHEWkp3EcFHjz6+tCjKn0CJ408E3+KY8WlaEv8awpy/AhrUw8Q/WywdEFAtvjP8I
X-Received: by 2002:a2e:a287:0:b0:2ad:cb20:695a with SMTP id k7-20020a2ea287000000b002adcb20695amr1164877lja.51.1685464410459;
        Tue, 30 May 2023 09:33:30 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id m26-20020a2e871a000000b002a8a6ba16a4sm1157658lji.40.2023.05.30.09.33.30;
        Tue, 30 May 2023 09:33:30 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
        by smtpservice.6wind.com (Postfix) with ESMTPS id D87B46021C;
        Tue, 30 May 2023 18:33:29 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
        (envelope-from <nicolas.dichtel@6wind.com>)
        id 1q42Hp-00AhdX-Il; Tue, 30 May 2023 18:33:29 +0200
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
To:     stable@vger.kernel.org
Cc:     nicolas.dichtel@6wind.com, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] ipv{4,6}/raw: fix output xfrm lookup wrt protocol
Date:   Tue, 30 May 2023 18:33:12 +0200
Message-Id: <20230530163312.2550994-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023052622-such-rearview-04a6@gregkh>
References: <2023052622-such-rearview-04a6@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Link: https://lore.kernel.org/r/20230522120820.1319391-1-nicolas.dichtel@6wind.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit 3632679d9e4f879f49949bb5b050e0de553e4739)
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---

I include the IP_LOCAL_PORT_RANGE define in the backport, to avoid having a hole.
I can resubmit without this if needed.
This patch can be applied on 5.15, 5.10, 5.4 and 4.19 stable trees also.

 include/net/ip.h        |  2 ++
 include/uapi/linux/in.h |  2 ++
 net/ipv4/ip_sockglue.c  | 12 +++++++++++-
 net/ipv4/raw.c          |  5 ++++-
 net/ipv6/raw.c          |  3 ++-
 5 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 144bdfbb25af..629a3c29e355 100644
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
index 07a4cb149305..e682ab628dfa 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -162,6 +162,8 @@ struct in_addr {
 #define MCAST_MSFILTER			48
 #define IP_MULTICAST_ALL		49
 #define IP_UNICAST_IF			50
+#define IP_LOCAL_PORT_RANGE		51
+#define IP_PROTOCOL			52
 
 #define MCAST_EXCLUDE	0
 #define MCAST_INCLUDE	1
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 6e19cad154f5..addf44b2811b 100644
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
@@ -1742,6 +1749,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_MINTTL:
 		val = inet->min_ttl;
 		break;
+	case IP_PROTOCOL:
+		val = inet_sk(sk)->inet_num;
+		break;
 	default:
 		sockopt_release_sock(sk);
 		return -ENOPROTOOPT;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index af03aa8a8e51..86197634dcf5 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -530,6 +530,9 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	ipcm_init_sk(&ipc, inet);
+	/* Keep backward compat */
+	if (hdrincl)
+		ipc.protocol = IPPROTO_RAW;
 
 	if (msg->msg_controllen) {
 		err = ip_cmsg_send(sk, msg, &ipc, false);
@@ -597,7 +600,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark, tos,
 			   RT_SCOPE_UNIVERSE,
-			   hdrincl ? IPPROTO_RAW : sk->sk_protocol,
+			   hdrincl ? ipc.protocol : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk) |
 			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
 			   daddr, saddr, 0, 0, sk->sk_uid);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index f44b99f7ecdc..33852fc38ad9 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -791,7 +791,8 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 		if (!proto)
 			proto = inet->inet_num;
-		else if (proto != inet->inet_num)
+		else if (proto != inet->inet_num &&
+			 inet->inet_num != IPPROTO_RAW)
 			return -EINVAL;
 
 		if (proto > 255)
-- 
2.39.2

