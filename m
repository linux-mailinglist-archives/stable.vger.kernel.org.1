Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E9C787B86
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 00:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjHXWdJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 18:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbjHXWc5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 18:32:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4D71BEB
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:32:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7475f45d31so399517276.0
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692916367; x=1693521167;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yCnYome8PAd3QC/Si61T2W2ZZrM6jPg5kZ/VhtS/wVk=;
        b=Qd6RK6ViEnRuNugywcZtpG+dU5vPQ6+D6UEXadXprd+D6zCTFDSSu/PU7u+0ojQmps
         OCViKWx4ZW13wQGpOuzQEcZu0zStgU3mAR1W0JPlhe+UqMVNkbS8EqqQBCPVFuKSVYtu
         V93I1UUiaBhyjf/GTds1vJvyTnE3NPXqiZOt56D31jBvfuwfdVOOvIBPoPFpFfvpchCO
         lVvsD9oSymT+3rHg3RdTnYF0b7fkCgwrqjPPKJIHzaqMiFJzedv3sQPOfcJ7Vh134Yu0
         xsPO+qjNVlQFGZK5+hSvRtjySBLhX4pxXJb3tuJf0KafbNNICzm0EK9l0OfwO84DWv75
         +1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692916367; x=1693521167;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCnYome8PAd3QC/Si61T2W2ZZrM6jPg5kZ/VhtS/wVk=;
        b=YrWV/sxtukYNClsbyJS1c8BEuxFNwGeozG8l+OKyrCfugiT7eIVT+DUVuk3e/Zy00Z
         sVUGGuXOGsMsEoPZ85zr3umY2q6aHs0vGTBINgesJ7p2VoRK52gt/MJ/+oR1V+0lylJX
         zmtqIzN4laKqv/UFlAe1kRhO1/Fv9F8I4ZqtV52vuMGP2BCs8fq5XBZr8g83Bj85lJY8
         QSXni+uyfsSz6wHj40unF3xgD//18JZBMlHGqEOoPpJuBgZZqSmB7SdUCwL0KoZvF1jJ
         Hyl5wCoHXOxYDBWVzZ4JpKgXVBaSC6RXRfzuD0mx5eqrbGvYGqe70lCUhKxB6DagfBI7
         nDtQ==
X-Gm-Message-State: AOJu0YwRRem90+fvA4fcm/a2gQ+el+rp/pxnL589uerfQbKM8+ElQE6H
        awwufvW8fRFHweWXEwG+ZuibUlhhg8oaIqHIBkEdzBBxpgRkcY3EHzEAvuQRSj7L06lmxFOC0Vd
        o5IyfLWygW4bOojWMu/n3dKlZZEqbHg5JRPWvo7KxSYAWzqr6u526Rg4wFHE=
X-Google-Smtp-Source: AGHT+IGgrArJ6KuWEfoqRiAlVMY/07X0dicWY0UXhV0vkep2AfUrsUvRiCEAEZMuwNeTHInhSucbWGaydA==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:171d:7a30:ab85:51b3])
 (user=prohr job=sendgmr) by 2002:a25:32c8:0:b0:d08:ea77:52d4 with SMTP id
 y191-20020a2532c8000000b00d08ea7752d4mr260984yby.12.1692916367607; Thu, 24
 Aug 2023 15:32:47 -0700 (PDT)
Date:   Thu, 24 Aug 2023 15:32:25 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230824223225.863719-1-prohr@google.com>
Subject: [PATCH 6.1] net: add sysctl accept_ra_min_lft
From:   Patrick Rohr <prohr@google.com>
To:     stable@vger.kernel.org
Cc:     Patrick Rohr <prohr@google.com>,
        "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This change adds a new sysctl accept_ra_min_lft which enforces a minimum
lifetime value for individual RA sections; in particular, router
lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
lifetimes are lower than the configured value, the specific RA section
is ignored.

This fixes a potential denial of service attack vector where rogue WiFi
routers (or devices) can send RAs with low lifetimes to actively drain a
mobile device's battery (by preventing sleep).

In addition to this change, Android uses hardware offloads to drop RAs
for a fraction of the minimum of all lifetimes present in the RA (some
networks have very frequent RAs (5s) with high lifetimes (2h)). Despite
this, we have encountered networks that set the router lifetime to 30s
which results in very frequent CPU wakeups. Instead of disabling IPv6
(and dropping IPv6 ethertype in the WiFi firmware) entirely on such
networks, misconfigured routers must be ignored while still processing
RAs from other IPv6 routers on the same network (i.e. to support IoT
applications).

This change squashes the following patches into a single commit:
- net-next 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
- net-next 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all R=
A lifetimes")
- net-next 5cb249686e67 ("net: release reference to inet6_dev pointer")

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Patrick Rohr <prohr@google.com>
---
 Documentation/networking/ip-sysctl.rst |  8 ++++++++
 include/linux/ipv6.h                   |  1 +
 include/uapi/linux/ipv6.h              |  1 +
 net/ipv6/addrconf.c                    | 13 +++++++++++++
 net/ipv6/ndisc.c                       | 13 +++++++++++--
 5 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/network=
ing/ip-sysctl.rst
index 3301288a7c69..f5f7a464605f 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2148,6 +2148,14 @@ accept_ra_min_hop_limit - INTEGER
=20
 	Default: 1
=20
+accept_ra_min_lft - INTEGER
+	Minimum acceptable lifetime value in Router Advertisement.
+
+	RA sections with a lifetime less than this value shall be
+	ignored. Zero lifetimes stay unaffected.
+
+	Default: 0
+
 accept_ra_pinfo - BOOLEAN
 	Learn Prefix Information in Router Advertisement.
=20
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 37dfdcfcdd54..0e3c95055b21 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -33,6 +33,7 @@ struct ipv6_devconf {
 	__s32		accept_ra_defrtr;
 	__u32		ra_defrtr_metric;
 	__s32		accept_ra_min_hop_limit;
+	__s32		accept_ra_min_lft;
 	__s32		accept_ra_pinfo;
 	__s32		ignore_routes_with_linkdown;
 #ifdef CONFIG_IPV6_ROUTER_PREF
diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index 53326dfc59ec..4fa8511b1e35 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -198,6 +198,7 @@ enum {
 	DEVCONF_IOAM6_ID_WIDE,
 	DEVCONF_NDISC_EVICT_NOCARRIER,
 	DEVCONF_ACCEPT_UNTRACKED_NA,
+	DEVCONF_ACCEPT_RA_MIN_LFT,
 	DEVCONF_MAX
 };
=20
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 48a6486951cd..5480ee507c61 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -202,6 +202,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
+	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -262,6 +263,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
+	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -2731,6 +2733,9 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *=
opt, int len, bool sllao)
 		return;
 	}
=20
+	if (valid_lft !=3D 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft)
+		goto put;
+
 	/*
 	 *	Two things going on here:
 	 *	1) Add routes for on-link prefixes
@@ -5601,6 +5606,7 @@ static inline void ipv6_store_devconf(struct ipv6_dev=
conf *cnf,
 	array[DEVCONF_IOAM6_ID_WIDE] =3D cnf->ioam6_id_wide;
 	array[DEVCONF_NDISC_EVICT_NOCARRIER] =3D cnf->ndisc_evict_nocarrier;
 	array[DEVCONF_ACCEPT_UNTRACKED_NA] =3D cnf->accept_untracked_na;
+	array[DEVCONF_ACCEPT_RA_MIN_LFT] =3D cnf->accept_ra_min_lft;
 }
=20
 static inline size_t inet6_ifla6_size(void)
@@ -6794,6 +6800,13 @@ static const struct ctl_table addrconf_sysctl[] =3D =
{
 		.mode		=3D 0644,
 		.proc_handler	=3D proc_dointvec,
 	},
+	{
+		.procname	=3D "accept_ra_min_lft",
+		.data		=3D &ipv6_devconf.accept_ra_min_lft,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dointvec,
+	},
 	{
 		.procname	=3D "accept_ra_pinfo",
 		.data		=3D &ipv6_devconf.accept_ra_pinfo,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index a4d43eb45a9d..6cb2d6a536a8 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1331,6 +1331,14 @@ static void ndisc_router_discovery(struct sk_buff *s=
kb)
 		goto skip_defrtr;
 	}
=20
+	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
+	if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_lft) {
+		ND_PRINTK(2, info,
+			  "RA: router lifetime (%ds) is too short: %s\n",
+			  lifetime, skb->dev->name);
+		goto skip_defrtr;
+	}
+
 	/* Do not accept RA with source-addr found on local machine unless
 	 * accept_ra_from_local is set to true.
 	 */
@@ -1343,8 +1351,6 @@ static void ndisc_router_discovery(struct sk_buff *sk=
b)
 		goto skip_defrtr;
 	}
=20
-	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	pref =3D ra_msg->icmph.icmp6_router_pref;
 	/* 10b is handled as if it were 00b (medium) */
@@ -1519,6 +1525,9 @@ static void ndisc_router_discovery(struct sk_buff *sk=
b)
 			if (ri->prefix_len =3D=3D 0 &&
 			    !in6_dev->cnf.accept_ra_defrtr)
 				continue;
+			if (ri->lifetime !=3D 0 &&
+			    ntohl(ri->lifetime) < in6_dev->cnf.accept_ra_min_lft)
+				continue;
 			if (ri->prefix_len < in6_dev->cnf.accept_ra_rt_info_min_plen)
 				continue;
 			if (ri->prefix_len > in6_dev->cnf.accept_ra_rt_info_max_plen)
--=20
2.42.0.rc1.204.g551eb34607-goog

