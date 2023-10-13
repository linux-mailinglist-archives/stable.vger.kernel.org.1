Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B224D7C8EED
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 23:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjJMVV0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 17:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMVVZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 17:21:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5F0BF
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:21:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso3666838276.1
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697232081; x=1697836881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UF7ZYWWkwihJeD0xTKXGTtQj9iLALT8tpLJIAasUM1o=;
        b=yZNrJHlUEi9tg8TstvTlnIB/RQu5XRbSSylT/pHrehHp0Y+1qTfiZJ2FFRjQIAGn1Y
         hRZtyN8u9nLidxeQTcrF0F1XFW/KsojXQpBvpLiHKIy1cPrfocI3aJx/AV+FCYqRHBUo
         8y4gfTId60t2ggxoOrq/J1eHPAWNXSgE/t4CFAXqDMaWK7R7dagNzKSk/iWRGpKPR76W
         qC7csdQhQl/mlt6wPBLQ0oSFwxCfGm44K/of7yU5ZCQGkfZgtugMTXGqBUVWRnnwTDO2
         Ci6EwHeEUODl7HaiWUxdpX0w7EhmHYrBbCewolN/az2rzTnrgvHUcWtgmICWykMEF2Jf
         pHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232081; x=1697836881;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UF7ZYWWkwihJeD0xTKXGTtQj9iLALT8tpLJIAasUM1o=;
        b=fT9msNtq9l17q7rlFGffibWxhXl9IQqO+d7YIlSLPO8R7coblVWfWGAqO+vOYkoVtd
         7EFPB1YQxG/sgPnZVthezZcAqcPpo9OCqf85EtANkrfV28ikzLDSD4gsFZCsNPru+RMd
         8UCxXcvkZCdfS+acWXqY2rO8qyKyeknFcReUpUN9TDgD5UIaLoejX+O7hcQEWBqztqb4
         duyGlfhIN1HiqAzdSvVVT8sa5AodSigVjRojMt4cvI2ZOA4ePQKHIjU5f9sr0Y9kS9KZ
         TYnHPV6BRDyHTYEY+Z4GR+sfwQGBju0FZdjno/+Z7/Wt1zG0+j9YKay3fffqCema601M
         TCjQ==
X-Gm-Message-State: AOJu0Yy+B+OwKUU18yqs9k+OkTMJ471dq9oh5nKOlF606X3EXPNTjw++
        AeZI4av7UCxzXLg6UN8/1k1X/nadBs1MhnWlmDGeMfEx9ZUgjGdwAunBpORxamU+LyuD/7QtFFN
        r0pYhKHzB+0fuaW2a+mHSXMU1GqrWGjYnNJYKt6GG3OztM9NzhU9LcmW47IE=
X-Google-Smtp-Source: AGHT+IGSoF+01ctE7v59e8LMYfYCbBEv2+j0BrAtvez3XJdQyekCL1VBrsPesi34vnx4nIiNHWl48e1Nvw==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:2cb4:ec7b:cfc0:caf7])
 (user=prohr job=sendgmr) by 2002:a25:290:0:b0:d9a:d78f:a008 with SMTP id
 138-20020a250290000000b00d9ad78fa008mr124804ybc.3.1697232081503; Fri, 13 Oct
 2023 14:21:21 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:21:13 -0700
In-Reply-To: <20231013212114.3445624-1-prohr@google.com>
Mime-Version: 1.0
References: <20231013212114.3445624-1-prohr@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231013212114.3445624-3-prohr@google.com>
Subject: [PATCH v2 2/3] net: change accept_ra_min_rtr_lft to affect all RA lifetimes
From:   Patrick Rohr <prohr@google.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Patrick Rohr <prohr@google.com>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
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

commit 5027d54a9c30bc7ec808360378e2b4753f053f25 upstream.

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
index f0e875938bb7..7f75767a24f1 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2070,11 +2070,11 @@ accept_ra_min_hop_limit - INTEGER
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
index 0e085d712296..b6fb76568b01 100644
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
index e82e5cd047ec..b11ada7ccc6e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -209,7 +209,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
-	.accept_ra_min_rtr_lft	=3D 0,
+	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -269,7 +269,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
-	.accept_ra_min_rtr_lft	=3D 0,
+	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -2736,6 +2736,9 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *=
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
@@ -5591,7 +5594,7 @@ static inline void ipv6_store_devconf(struct ipv6_dev=
conf *cnf,
 	array[DEVCONF_IOAM6_ENABLED] =3D cnf->ioam6_enabled;
 	array[DEVCONF_IOAM6_ID] =3D cnf->ioam6_id;
 	array[DEVCONF_IOAM6_ID_WIDE] =3D cnf->ioam6_id_wide;
-	array[DEVCONF_ACCEPT_RA_MIN_RTR_LFT] =3D cnf->accept_ra_min_rtr_lft;
+	array[DEVCONF_ACCEPT_RA_MIN_LFT] =3D cnf->accept_ra_min_lft;
 }
=20
 static inline size_t inet6_ifla6_size(void)
@@ -6786,8 +6789,8 @@ static const struct ctl_table addrconf_sysctl[] =3D {
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
index f19079c1b774..856edbe81e11 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1223,8 +1223,6 @@ static void ndisc_router_discovery(struct sk_buff *sk=
b)
 		return;
 	}
=20
-	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 	if (!ipv6_accept_ra(in6_dev)) {
 		ND_PRINTK(2, info,
 			  "RA: %s, did not accept ra for dev: %s\n",
@@ -1232,13 +1230,6 @@ static void ndisc_router_discovery(struct sk_buff *s=
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
@@ -1279,6 +1270,14 @@ static void ndisc_router_discovery(struct sk_buff *s=
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
@@ -1437,13 +1436,6 @@ static void ndisc_router_discovery(struct sk_buff *s=
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
@@ -1468,6 +1460,9 @@ static void ndisc_router_discovery(struct sk_buff *sk=
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
2.42.0.655.g421f12c284-goog

