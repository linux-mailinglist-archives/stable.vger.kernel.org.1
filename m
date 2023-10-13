Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9BA7C8F85
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 23:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjJMVok (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 17:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjJMVoj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 17:44:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43A5CA
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:44:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7daf45537so38162617b3.2
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697233477; x=1697838277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aF3wpC9MGkEZXlfPmVo7P8SaqZhVf5i69ii4yBbuNzM=;
        b=FihG3bDCemkJW8MhARTAz1PL5em6UD2om0T3zHG0pSLV/ghV7vi/6eD+RVVdTPxvcI
         +T7W6w72LCoTp0uH8fJFEVDD8hh08tZLdDVTj7Oj5iGxOC4l9FlJQQa5IXDEFbyWPy3n
         uVCAdct9CqTRF1DwxnXykUC+61NpHJyuXeTKZF+vmxE/NXPJKK3N7UfzQj/BqCO9HlVp
         7Y5+MThH80RWUflGQgXQ0mlIRvo/5N5S8CtLTHULdQ+kEcAFGdDUhezrfwTR2KbSrH66
         rJOFJebSaPyKA0DXCSwTXTpJ+34G1F1hYhPUGf+0NNuL4NPHhs+fSHk1OF3i/zGEiUx0
         p8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697233477; x=1697838277;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aF3wpC9MGkEZXlfPmVo7P8SaqZhVf5i69ii4yBbuNzM=;
        b=OX8aljbVP0F6fx+Bbj8AQlzR399Zmbm1FpesdbUwloilZgp6Q+Izg638cwvkFfVgAc
         llTaJ44+hkC+RNFcGLFe821q8RuHIyevwPPZhKH2QcpdnZOLP84efb/oQbj+b/N7bwZN
         RpqVxJZi9Tck2UGMTFIXxwSsz1jqlNmkzicTMdop9G+cThptFkKQlm575By/KddmVXoH
         h97HIoDu4E7iDMVglSBL8fs4bde4lmqe77XffegULX61zDpXNgr9oz2vC+IaYINiZMAG
         n3SWuW436pXGDUiPar4jim1va4So8mHkQBTWd6muN0iBDPPs4lAcevUWcEq/zG4Jrbn3
         qDnA==
X-Gm-Message-State: AOJu0YyMfyK3xMLolid0qrEJjqnv2KY8X+LMxCpe7rHl3iNO/FDmyI0g
        gCzObFDM9SOwIbUNPnEXSTpYT8oDhEX91zjQZobltzg2T3bVDvHhLRMIP0FM5q0tGeQ8H1AsTZA
        NBLm9ZITbtbKGDO6VOfVByNn0OCCWO9HeYWVIto12VHi5K/rT0uqkpWHz8Ug=
X-Google-Smtp-Source: AGHT+IFIABv920DbVIKCLCY55sfhw8551sDhqhFPxKf5rmen3lYzDpwhqftRSlBSMOIwN00MBDii7fIBcQ==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:2cb4:ec7b:cfc0:caf7])
 (user=prohr job=sendgmr) by 2002:a81:4949:0:b0:5a7:af9a:7530 with SMTP id
 w70-20020a814949000000b005a7af9a7530mr317972ywa.1.1697233476922; Fri, 13 Oct
 2023 14:44:36 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:44:12 -0700
In-Reply-To: <20231013214414.3482322-1-prohr@google.com>
Mime-Version: 1.0
References: <20231013214414.3482322-1-prohr@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231013214414.3482322-2-prohr@google.com>
Subject: [PATCH 5.10 1/3] net: add sysctl accept_ra_min_rtr_lft
From:   Patrick Rohr <prohr@google.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
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

commit 1671bcfd76fdc0b9e65153cf759153083755fe4c upstream.

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
 include/uapi/linux/ipv6.h              |  7 +++++++
 net/ipv6/addrconf.c                    | 10 ++++++++++
 net/ipv6/ndisc.c                       | 18 ++++++++++++++++--
 5 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/network=
ing/ip-sysctl.rst
index 252212998378..f7db7652341d 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1916,6 +1916,14 @@ accept_ra_min_hop_limit - INTEGER
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
index 510f87656479..b91925a70296 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -32,6 +32,7 @@ struct ipv6_devconf {
 	__s32		max_addresses;
 	__s32		accept_ra_defrtr;
 	__s32		accept_ra_min_hop_limit;
+	__s32		accept_ra_min_rtr_lft;
 	__s32		accept_ra_pinfo;
 	__s32		ignore_routes_with_linkdown;
 #ifdef CONFIG_IPV6_ROUTER_PREF
diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index d44d0483fd73..2038eff9b63f 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -192,6 +192,13 @@ enum {
 	DEVCONF_ACCEPT_RA_RT_INFO_MIN_PLEN,
 	DEVCONF_NDISC_TCLASS,
 	DEVCONF_RPL_SEG_ENABLED,
+	DEVCONF_RA_DEFRTR_METRIC,
+	DEVCONF_IOAM6_ENABLED,
+	DEVCONF_IOAM6_ID,
+	DEVCONF_IOAM6_ID_WIDE,
+	DEVCONF_NDISC_EVICT_NOCARRIER,
+	DEVCONF_ACCEPT_UNTRACKED_NA,
+	DEVCONF_ACCEPT_RA_MIN_RTR_LFT,
 	DEVCONF_MAX
 };
=20
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0eafe26c05f7..7f122f27137f 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -207,6 +207,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.accept_ra_defrtr	=3D 1,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
+	.accept_ra_min_rtr_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -262,6 +263,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.accept_ra_defrtr	=3D 1,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
+	.accept_ra_min_rtr_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -5559,6 +5561,7 @@ static inline void ipv6_store_devconf(struct ipv6_dev=
conf *cnf,
 	array[DEVCONF_DISABLE_POLICY] =3D cnf->disable_policy;
 	array[DEVCONF_NDISC_TCLASS] =3D cnf->ndisc_tclass;
 	array[DEVCONF_RPL_SEG_ENABLED] =3D cnf->rpl_seg_enabled;
+	array[DEVCONF_ACCEPT_RA_MIN_RTR_LFT] =3D cnf->accept_ra_min_rtr_lft;
 }
=20
 static inline size_t inet6_ifla6_size(void)
@@ -6716,6 +6719,13 @@ static const struct ctl_table addrconf_sysctl[] =3D =
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
index ac1e51087b1d..215ea5dbc5f0 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1222,6 +1222,8 @@ static void ndisc_router_discovery(struct sk_buff *sk=
b)
 		return;
 	}
=20
+	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
+
 	if (!ipv6_accept_ra(in6_dev)) {
 		ND_PRINTK(2, info,
 			  "RA: %s, did not accept ra for dev: %s\n",
@@ -1229,6 +1231,13 @@ static void ndisc_router_discovery(struct sk_buff *s=
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
@@ -1281,8 +1290,6 @@ static void ndisc_router_discovery(struct sk_buff *sk=
b)
 		goto skip_defrtr;
 	}
=20
-	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	pref =3D ra_msg->icmph.icmp6_router_pref;
 	/* 10b is handled as if it were 00b (medium) */
@@ -1429,6 +1436,13 @@ static void ndisc_router_discovery(struct sk_buff *s=
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
2.42.0.655.g421f12c284-goog

