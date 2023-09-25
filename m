Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7903D7AE092
	for <lists+stable@lfdr.de>; Mon, 25 Sep 2023 23:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjIYVLO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 25 Sep 2023 17:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIYVLN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 25 Sep 2023 17:11:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9C5109
        for <stable@vger.kernel.org>; Mon, 25 Sep 2023 14:11:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f7d4bbfc7so54231627b3.3
        for <stable@vger.kernel.org>; Mon, 25 Sep 2023 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695676266; x=1696281066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pemI/6/17rYs8LjbBoUUf7MQrj79SUpqiaiDCqt02KQ=;
        b=QoPsyqUZt/27hFbH6RcDOwByMNEHGVsOenVf3F6/2BgRt1CKR1EjhWF1xLN44mT47o
         TUDvG8LwP+V8xaEJH7wrabF92A5q/n+FX7pZl1F8BRj3cZ2jN9UFf9CXP5whBS83Dj4/
         9uOSMU1ER5+Zx2cRoal0sK7hx4uwtsJ6Qafyztczu2vrKkmPpc96Z0kouKc5zz8NPFKN
         NFSdV3r4gpF8YkG/8GTWwbDYX0FI20PVHb0Aq5Jg+NI0TJvnNUlxaSfbRF1m0lXI9rQB
         UVO+/6ee3JfHXuRa93ICbh5gXJdcx8N8BRUwRDYk6QxPjcUMXT6HuKeqpx2rb3Adg2oI
         xlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695676266; x=1696281066;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pemI/6/17rYs8LjbBoUUf7MQrj79SUpqiaiDCqt02KQ=;
        b=SiuK74jWnqVrabAgqTOdnP7h8+pxcZjajqhAjzP8mXOHiddjwg6Fs7WM7H4RScps7x
         4wQUXkIYczT+vQ1lG7qb9eO07jfed/N8hY6H0swZqmKHakAwCD+W/VUp7w8JS0gJ/ZWz
         Q05cP/hE3U3vUhOOyGZAmpGjj2wXWdJ/qonC3qMCIt3+L3GRrTFs5yEftEwmQtHNYYOl
         79px4q8wFvSf8csHvwErvMDJc6G47vR+QjL94szr68r1QX0GCqayzT5V8IQc/6arsFBe
         Zm3VgqvwNld/Gx+YIzVDZXL5ji5Dgoh2J06VZFpUaiqCbV1/mhB77xNW0Z78ON2lXKAk
         ++Sw==
X-Gm-Message-State: AOJu0YyJQE/Cva5q0KpYUfwbQ6+KZRtLH6o/O3AgF+mHXzMDndfs/EPB
        H1y3fyRNUtw2/QJE8jZ276bLcVawng2TBodSaMq6ptVkGj8AnftyUPgkLBbUIkOAiS2akwpVmIR
        nG3X8fvfgzm1fRQBpdZOiwaLXfoqjAAojy5tiP7K6qo70zeHuaJUy7dArhdw=
X-Google-Smtp-Source: AGHT+IFMSA5TM26R663bAgt7P47iGl50fA/T4zXKRf1ptG3ukgM6abrPAVs3ZbRY5oS48t5nsPxb2lvnXA==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:146d:2aa0:7ed1:bbb8])
 (user=prohr job=sendgmr) by 2002:a05:6902:a8c:b0:d80:6110:835e with SMTP id
 cd12-20020a0569020a8c00b00d806110835emr75170ybb.3.1695676264054; Mon, 25 Sep
 2023 14:11:04 -0700 (PDT)
Date:   Mon, 25 Sep 2023 14:10:33 -0700
In-Reply-To: <20230925211034.905320-1-prohr@google.com>
Mime-Version: 1.0
References: <20230925211034.905320-1-prohr@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230925211034.905320-3-prohr@google.com>
Subject: [PATCH 6.1 2/3] net: change accept_ra_min_rtr_lft to affect all RA lifetimes
From:   Patrick Rohr <prohr@google.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Patrick Rohr <prohr@google.com>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
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

accept_ra_min_rtr_lft only considered the lifetime of the default route
and discarded entire RAs accordingly.

This change renames accept_ra_min_rtr_lft to accept_ra_min_lft, and
applies the value to individual RA sections; in particular, router
lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
lifetimes are lower than the configured value, the specific RA section
is ignored.

In order for the sysctl to be useful to Android, it should really apply
to all lifetimes in the RA, since that is what determines the minimum
frequency at which RAs must be processed by the kernel. Android uses
hardware offloads to drop RAs for a fraction of the minimum of all
lifetimes present in the RA (some networks have very frequent RAs (5s)
with high lifetimes (2h)). Despite this, we have encountered networks
that set the router lifetime to 30s which results in very frequent CPU
wakeups. Instead of disabling IPv6 (and dropping IPv6 ethertype in the
WiFi firmware) entirely on such networks, it seems better to ignore the
misconfigured routers while still processing RAs from other IPv6 routers
on the same network (i.e. to support IoT applications).

The previous implementation dropped the entire RA based on router
lifetime. This turned out to be hard to expand to the other lifetimes
present in the RA in a consistent manner; dropping the entire RA based
on RIO/PIO lifetimes would essentially require parsing the whole thing
twice.

Fixes: 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Patrick Rohr <prohr@google.com>
Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20230726230701.919212-1-prohr@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/ip-sysctl.rst |  8 ++++----
 include/linux/ipv6.h                   |  2 +-
 include/uapi/linux/ipv6.h              |  2 +-
 net/ipv6/addrconf.c                    | 13 ++++++++-----
 net/ipv6/ndisc.c                       | 27 +++++++++++---------------
 5 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/network=
ing/ip-sysctl.rst
index b0e9210f7a28..f5f7a464605f 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2148,11 +2148,11 @@ accept_ra_min_hop_limit - INTEGER
=20
 	Default: 1
=20
-accept_ra_min_rtr_lft - INTEGER
-	Minimum acceptable router lifetime in Router Advertisement.
+accept_ra_min_lft - INTEGER
+	Minimum acceptable lifetime value in Router Advertisement.
=20
-	RAs with a router lifetime less than this value shall be
-	ignored. RAs with a router lifetime of 0 are unaffected.
+	RA sections with a lifetime less than this value shall be
+	ignored. Zero lifetimes stay unaffected.
=20
 	Default: 0
=20
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index a4b35f4c89d7..9a44de45cc1f 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -33,7 +33,7 @@ struct ipv6_devconf {
 	__s32		accept_ra_defrtr;
 	__u32		ra_defrtr_metric;
 	__s32		accept_ra_min_hop_limit;
-	__s32		accept_ra_min_rtr_lft;
+	__s32		accept_ra_min_lft;
 	__s32		accept_ra_pinfo;
 	__s32		ignore_routes_with_linkdown;
 #ifdef CONFIG_IPV6_ROUTER_PREF
diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index 2038eff9b63f..4fa8511b1e35 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -198,7 +198,7 @@ enum {
 	DEVCONF_IOAM6_ID_WIDE,
 	DEVCONF_NDISC_EVICT_NOCARRIER,
 	DEVCONF_ACCEPT_UNTRACKED_NA,
-	DEVCONF_ACCEPT_RA_MIN_RTR_LFT,
+	DEVCONF_ACCEPT_RA_MIN_LFT,
 	DEVCONF_MAX
 };
=20
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c7e939c619c9..53db8daa7385 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -202,7 +202,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
-	.accept_ra_min_rtr_lft	=3D 0,
+	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -263,7 +263,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
-	.accept_ra_min_rtr_lft	=3D 0,
+	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -2733,6 +2733,9 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *=
opt, int len, bool sllao)
 		return;
 	}
=20
+	if (valid_lft !=3D 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft)
+		return;
+
 	/*
 	 *	Two things going on here:
 	 *	1) Add routes for on-link prefixes
@@ -5603,7 +5606,7 @@ static inline void ipv6_store_devconf(struct ipv6_dev=
conf *cnf,
 	array[DEVCONF_IOAM6_ID_WIDE] =3D cnf->ioam6_id_wide;
 	array[DEVCONF_NDISC_EVICT_NOCARRIER] =3D cnf->ndisc_evict_nocarrier;
 	array[DEVCONF_ACCEPT_UNTRACKED_NA] =3D cnf->accept_untracked_na;
-	array[DEVCONF_ACCEPT_RA_MIN_RTR_LFT] =3D cnf->accept_ra_min_rtr_lft;
+	array[DEVCONF_ACCEPT_RA_MIN_LFT] =3D cnf->accept_ra_min_lft;
 }
=20
 static inline size_t inet6_ifla6_size(void)
@@ -6798,8 +6801,8 @@ static const struct ctl_table addrconf_sysctl[] =3D {
 		.proc_handler	=3D proc_dointvec,
 	},
 	{
-		.procname	=3D "accept_ra_min_rtr_lft",
-		.data		=3D &ipv6_devconf.accept_ra_min_rtr_lft,
+		.procname	=3D "accept_ra_min_lft",
+		.data		=3D &ipv6_devconf.accept_ra_min_lft,
 		.maxlen		=3D sizeof(int),
 		.mode		=3D 0644,
 		.proc_handler	=3D proc_dointvec,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index c2a6cda4be28..6cb2d6a536a8 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1284,8 +1284,6 @@ static void ndisc_router_discovery(struct sk_buff *sk=
b)
 		return;
 	}
=20
-	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 	if (!ipv6_accept_ra(in6_dev)) {
 		ND_PRINTK(2, info,
 			  "RA: %s, did not accept ra for dev: %s\n",
@@ -1293,13 +1291,6 @@ static void ndisc_router_discovery(struct sk_buff *s=
kb)
 		goto skip_linkparms;
 	}
=20
-	if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
-		ND_PRINTK(2, info,
-			  "RA: router lifetime (%ds) is too short: %s\n",
-			  lifetime, skb->dev->name);
-		goto skip_linkparms;
-	}
-
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	/* skip link-specific parameters from interior routers */
 	if (skb->ndisc_nodetype =3D=3D NDISC_NODETYPE_NODEFAULT) {
@@ -1340,6 +1331,14 @@ static void ndisc_router_discovery(struct sk_buff *s=
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
@@ -1502,13 +1501,6 @@ static void ndisc_router_discovery(struct sk_buff *s=
kb)
 		goto out;
 	}
=20
-	if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
-		ND_PRINTK(2, info,
-			  "RA: router lifetime (%ds) is too short: %s\n",
-			  lifetime, skb->dev->name);
-		goto out;
-	}
-
 #ifdef CONFIG_IPV6_ROUTE_INFO
 	if (!in6_dev->cnf.accept_ra_from_local &&
 	    ipv6_chk_addr(dev_net(in6_dev->dev), &ipv6_hdr(skb)->saddr,
@@ -1533,6 +1525,9 @@ static void ndisc_router_discovery(struct sk_buff *sk=
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
2.42.0.515.g380fc7ccd1-goog

