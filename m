Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A057C8F86
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 23:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjJMVom (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 17:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJMVol (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 17:44:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDB8CE
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:44:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5a586da6so20229517b3.1
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697233479; x=1697838279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lq1zSoNWQ1YCJaxNWQHcyMYnd8JXLENR7XT/ORJjVUs=;
        b=p8BkFHEVUoEruDu8FU7LYIBmdy5NfzvAbNRGkuhtPjfoZ/QwoxG4Ee0Aixuzpdk6Se
         8HOvbQ1jiJziiDSxL5w0f/nGAIfebYW6ZPL+5iTeLAeHuXxlU8LsoofCIVlYuspUHX8k
         cmEdMoqcqUA/aP8didU7rXN2dLgq6uG/f6iFJ6wvEY+AE8xaUqQ/4v5E/+xDw4Hr9pTr
         gV/ZwumP5Aiv9q87yuXES5VlU1fAwwGzmfQkLWz8mHUxBPVVf8vzL/PHnijFXoujAzoy
         hFjsQuskhbXk9eN54bPLcgHCmuthviJwHvYkRVW6ILCzEC4QiSzfjvkpQbQhXKtlfGBd
         XZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697233479; x=1697838279;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lq1zSoNWQ1YCJaxNWQHcyMYnd8JXLENR7XT/ORJjVUs=;
        b=HruY2ys+tNCMgodNgVeqMmSqba4GgASuPEcfXBg3C24hzAHXglAf6gVBQhoAslqQJD
         sr0yYMKQhda0JcL3I94yAbiZhb5OiSPkCRuebVjhHos0Kh9PD9E5SyLUiYynOYUd2NQr
         PfICxYctgsDZ7QyL25vz4Kia1zdmKGtvIUhwFWUzR1s/NqnoKirVtAa0xoVhrx9mxBKq
         fK5Z4ynSHlLfry5GxqlaNeYYliPPPx0uRD88m6fbaNfNsi0yCsYz9osPqJp2kBxUDx7m
         UCBqtr8o67yqoXEqK/4BC7d7nKA4JEHdZ5G3ZnvN2I1kFtVsMV+1xsibaKjBbpEWM7kx
         Cf+w==
X-Gm-Message-State: AOJu0Ywn+laO0L1pZeY8umoPzwVyjwc10KkkhALCxjREFwiGcRHu4ytx
        qDGoU+5VqxtNM2x5DGZdZR8M5jwCg7ZtGbReL4igHCS8BrgVnGLNpUz6hWK6OemQVcIYEz1fJGD
        YrX7PLqQIZWUA4851dP7OU6PKIFsJ3Y4OaWLJNB14ugNK6nXHjqItQyrGG30=
X-Google-Smtp-Source: AGHT+IHszeXIzV9DXAuDyr6ST5JUeXIyScvXVYgHjVcpGVKGRU5Zvs7JhuOz7EeE34uzqd7c9mdoIAaIjw==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:2cb4:ec7b:cfc0:caf7])
 (user=prohr job=sendgmr) by 2002:a05:690c:2d0f:b0:5a7:b87d:9825 with SMTP id
 eq15-20020a05690c2d0f00b005a7b87d9825mr38991ywb.5.1697233478843; Fri, 13 Oct
 2023 14:44:38 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:44:13 -0700
In-Reply-To: <20231013214414.3482322-1-prohr@google.com>
Mime-Version: 1.0
References: <20231013214414.3482322-1-prohr@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231013214414.3482322-3-prohr@google.com>
Subject: [PATCH 5.10 2/3] net: change accept_ra_min_rtr_lft to affect all RA lifetimes
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
index f7db7652341d..e912a47765f3 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1916,11 +1916,11 @@ accept_ra_min_hop_limit - INTEGER
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
index b91925a70296..d758c131ed5e 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -32,7 +32,7 @@ struct ipv6_devconf {
 	__s32		max_addresses;
 	__s32		accept_ra_defrtr;
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
index 7f122f27137f..2a389895d0a2 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -207,7 +207,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.accept_ra_defrtr	=3D 1,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
-	.accept_ra_min_rtr_lft	=3D 0,
+	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -263,7 +263,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.accept_ra_defrtr	=3D 1,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
-	.accept_ra_min_rtr_lft	=3D 0,
+	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -2726,6 +2726,9 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *=
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
@@ -5561,7 +5564,7 @@ static inline void ipv6_store_devconf(struct ipv6_dev=
conf *cnf,
 	array[DEVCONF_DISABLE_POLICY] =3D cnf->disable_policy;
 	array[DEVCONF_NDISC_TCLASS] =3D cnf->ndisc_tclass;
 	array[DEVCONF_RPL_SEG_ENABLED] =3D cnf->rpl_seg_enabled;
-	array[DEVCONF_ACCEPT_RA_MIN_RTR_LFT] =3D cnf->accept_ra_min_rtr_lft;
+	array[DEVCONF_ACCEPT_RA_MIN_LFT] =3D cnf->accept_ra_min_lft;
 }
=20
 static inline size_t inet6_ifla6_size(void)
@@ -6720,8 +6723,8 @@ static const struct ctl_table addrconf_sysctl[] =3D {
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
index 215ea5dbc5f0..14251347c4a5 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1222,8 +1222,6 @@ static void ndisc_router_discovery(struct sk_buff *sk=
b)
 		return;
 	}
=20
-	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 	if (!ipv6_accept_ra(in6_dev)) {
 		ND_PRINTK(2, info,
 			  "RA: %s, did not accept ra for dev: %s\n",
@@ -1231,13 +1229,6 @@ static void ndisc_router_discovery(struct sk_buff *s=
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
@@ -1278,6 +1269,14 @@ static void ndisc_router_discovery(struct sk_buff *s=
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
@@ -1436,13 +1435,6 @@ static void ndisc_router_discovery(struct sk_buff *s=
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
@@ -1467,6 +1459,9 @@ static void ndisc_router_discovery(struct sk_buff *sk=
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

