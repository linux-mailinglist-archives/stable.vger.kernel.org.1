Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB9C7AE091
	for <lists+stable@lfdr.de>; Mon, 25 Sep 2023 23:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjIYVLK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 25 Sep 2023 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIYVLJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 25 Sep 2023 17:11:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E6C116
        for <stable@vger.kernel.org>; Mon, 25 Sep 2023 14:11:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c0dd156e5so144149247b3.3
        for <stable@vger.kernel.org>; Mon, 25 Sep 2023 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695676262; x=1696281062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otavCTdm7oXfns+CNeUc3Nzpd/ZkLX5cJ7mkdai1sG4=;
        b=Sq1cNlniRorH1+UhYg0y6NEIkgKJg3obRmkdZ069KD5lv3R31xpKicE6QQ5BJ42Afr
         wurZ6FmbzADlp666EQFPj041SF4gYJdgAleMDqWn7gn9Z23Aiwgwr+eaEgoNqZ4lopB4
         Veso/g9bGeHjcPNdc0uIPkrRzIf+vB5LRIHaLpAAPTnJT6D6iTRDm3n8IVuE9kv2ZnhO
         zkLGbs6+/kqlJ1Cbowq7TypcX1XUR72jquJTyclNzFeU0YrlCf03EOOJm40vVTL4P4TT
         wEcMpQj1ZS/oOhrLR+5NP7OVl5k0f1bXHPlqPBSXvECDIzkGOaE0KeulHNEYMy+w1ULk
         Ez1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695676262; x=1696281062;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=otavCTdm7oXfns+CNeUc3Nzpd/ZkLX5cJ7mkdai1sG4=;
        b=capLbyreE46KzOxQrSWOE1ZmFkZUv5OdyP8RNjOKjpg/HkrhJszl9iSNXBYf0wW35v
         ugrFJ0j0syENyTg1soKEXsxpYpKCT8iVslELoLikAPR3CieZESKiyaGYYuyPBj683ahq
         o90/9Qjh5bzU6QY/6i6adkoePfBwqPJAnNh7ooKWAN2Gbv+VgwKT3YtyPzzlZgfAGUsr
         DQIn45g9WZV648AzT5BuI9+u1TfN/cKH8dvjdq1dE65T2O4FEBqa6UFIYpTz7SDt8VEK
         0p8d1IBc4AED63pIWjb1sQwG1wqj7JQO/Q/cqcX7Dl9qu968N6BwpRGToerjkFFRAI3p
         I4yw==
X-Gm-Message-State: AOJu0Yxmz+QXmTS1V++4jvL6Ch4jgkl6aOZDw6VAWNCeRHii4atJ6SX/
        7oYvAh+noZKHifj29uo60iksEyFYMrz5MZtZw8LdwAWP34bG1d3qB88EBQo+q+/Jk8nwgZPIjS+
        rzKtBG6/eA5NKSaE6aB5TSbbNJcpNIuzhkciXMCydGl2d0wH5DC6aOZHVby0=
X-Google-Smtp-Source: AGHT+IFWMVzceuDhbXYjmYZqpcO4pf3PPFP+FsohjoBeYYW3I3DuvoAGaiJdIqmW2rkmZcZ18jFn7GvYCA==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:146d:2aa0:7ed1:bbb8])
 (user=prohr job=sendgmr) by 2002:a25:d393:0:b0:d7e:8dee:7813 with SMTP id
 e141-20020a25d393000000b00d7e8dee7813mr77739ybf.8.1695676261815; Mon, 25 Sep
 2023 14:11:01 -0700 (PDT)
Date:   Mon, 25 Sep 2023 14:10:32 -0700
In-Reply-To: <20230925211034.905320-1-prohr@google.com>
Mime-Version: 1.0
References: <20230925211034.905320-1-prohr@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230925211034.905320-2-prohr@google.com>
Subject: [PATCH 6.1 1/3] net: add sysctl accept_ra_min_rtr_lft
From:   Patrick Rohr <prohr@google.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Patrick Rohr <prohr@google.com>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This change adds a new sysctl accept_ra_min_rtr_lft to specify the
minimum acceptable router lifetime in an RA. If the received RA router
lifetime is less than the configured value (and not 0), the RA is
ignored.
This is useful for mobile devices, whose battery life can be impacted
by networks that configure RAs with a short lifetime. On such networks,
the device should never gain IPv6 provisioning and should attempt to
drop RAs via hardware offload, if available.

Signed-off-by: Patrick Rohr <prohr@google.com>
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 Documentation/networking/ip-sysctl.rst |  8 ++++++++
 include/linux/ipv6.h                   |  1 +
 include/uapi/linux/ipv6.h              |  1 +
 net/ipv6/addrconf.c                    | 10 ++++++++++
 net/ipv6/ndisc.c                       | 18 ++++++++++++++++--
 5 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/network=
ing/ip-sysctl.rst
index 3301288a7c69..b0e9210f7a28 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2148,6 +2148,14 @@ accept_ra_min_hop_limit - INTEGER
=20
 	Default: 1
=20
+accept_ra_min_rtr_lft - INTEGER
+	Minimum acceptable router lifetime in Router Advertisement.
+
+	RAs with a router lifetime less than this value shall be
+	ignored. RAs with a router lifetime of 0 are unaffected.
+
+	Default: 0
+
 accept_ra_pinfo - BOOLEAN
 	Learn Prefix Information in Router Advertisement.
=20
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 15d7529ac953..a4b35f4c89d7 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -33,6 +33,7 @@ struct ipv6_devconf {
 	__s32		accept_ra_defrtr;
 	__u32		ra_defrtr_metric;
 	__s32		accept_ra_min_hop_limit;
+	__s32		accept_ra_min_rtr_lft;
 	__s32		accept_ra_pinfo;
 	__s32		ignore_routes_with_linkdown;
 #ifdef CONFIG_IPV6_ROUTER_PREF
diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index 53326dfc59ec..2038eff9b63f 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -198,6 +198,7 @@ enum {
 	DEVCONF_IOAM6_ID_WIDE,
 	DEVCONF_NDISC_EVICT_NOCARRIER,
 	DEVCONF_ACCEPT_UNTRACKED_NA,
+	DEVCONF_ACCEPT_RA_MIN_RTR_LFT,
 	DEVCONF_MAX
 };
=20
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 83be84219824..c7e939c619c9 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -202,6 +202,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
+	.accept_ra_min_rtr_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -262,6 +263,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
+	.accept_ra_min_rtr_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -5601,6 +5603,7 @@ static inline void ipv6_store_devconf(struct ipv6_dev=
conf *cnf,
 	array[DEVCONF_IOAM6_ID_WIDE] =3D cnf->ioam6_id_wide;
 	array[DEVCONF_NDISC_EVICT_NOCARRIER] =3D cnf->ndisc_evict_nocarrier;
 	array[DEVCONF_ACCEPT_UNTRACKED_NA] =3D cnf->accept_untracked_na;
+	array[DEVCONF_ACCEPT_RA_MIN_RTR_LFT] =3D cnf->accept_ra_min_rtr_lft;
 }
=20
 static inline size_t inet6_ifla6_size(void)
@@ -6794,6 +6797,13 @@ static const struct ctl_table addrconf_sysctl[] =3D =
{
 		.mode		=3D 0644,
 		.proc_handler	=3D proc_dointvec,
 	},
+	{
+		.procname	=3D "accept_ra_min_rtr_lft",
+		.data		=3D &ipv6_devconf.accept_ra_min_rtr_lft,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dointvec,
+	},
 	{
 		.procname	=3D "accept_ra_pinfo",
 		.data		=3D &ipv6_devconf.accept_ra_pinfo,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index a4d43eb45a9d..c2a6cda4be28 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1284,6 +1284,8 @@ static void ndisc_router_discovery(struct sk_buff *sk=
b)
 		return;
 	}
=20
+	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
+
 	if (!ipv6_accept_ra(in6_dev)) {
 		ND_PRINTK(2, info,
 			  "RA: %s, did not accept ra for dev: %s\n",
@@ -1291,6 +1293,13 @@ static void ndisc_router_discovery(struct sk_buff *s=
kb)
 		goto skip_linkparms;
 	}
=20
+	if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
+		ND_PRINTK(2, info,
+			  "RA: router lifetime (%ds) is too short: %s\n",
+			  lifetime, skb->dev->name);
+		goto skip_linkparms;
+	}
+
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	/* skip link-specific parameters from interior routers */
 	if (skb->ndisc_nodetype =3D=3D NDISC_NODETYPE_NODEFAULT) {
@@ -1343,8 +1352,6 @@ static void ndisc_router_discovery(struct sk_buff *sk=
b)
 		goto skip_defrtr;
 	}
=20
-	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	pref =3D ra_msg->icmph.icmp6_router_pref;
 	/* 10b is handled as if it were 00b (medium) */
@@ -1495,6 +1502,13 @@ static void ndisc_router_discovery(struct sk_buff *s=
kb)
 		goto out;
 	}
=20
+	if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
+		ND_PRINTK(2, info,
+			  "RA: router lifetime (%ds) is too short: %s\n",
+			  lifetime, skb->dev->name);
+		goto out;
+	}
+
 #ifdef CONFIG_IPV6_ROUTE_INFO
 	if (!in6_dev->cnf.accept_ra_from_local &&
 	    ipv6_chk_addr(dev_net(in6_dev->dev), &ipv6_hdr(skb)->saddr,
--=20
2.42.0.515.g380fc7ccd1-goog

