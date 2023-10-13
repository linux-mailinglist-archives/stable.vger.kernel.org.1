Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B3E7C8EEC
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 23:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJMVVW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 17:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMVVV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 17:21:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331CE95
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:21:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a581346c4so3405217276.0
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697232079; x=1697836879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUlSYTKyeiSi9PloS8btOVWKRe6DLrnGb3ptXHb88dA=;
        b=UBCdKCVJYVnkLVaFcqNUbk6rw5MdpqC70GJi9EIqYSk2wEK8weGPeG6pDPl/CY90pI
         yYcxBnRx02VZuay8SFIuKj4aV2weBNvPEkPPj+d4mTFZyxw4RIhcVYy0O24tQCGMvL9O
         SdIeMg2DYcVf2vPxThiZn9x3mUfcH8nmxgIRJckXXkcPgkOHor4pzdq+xK3zJv4sJjdc
         vqgIA0nN8L09PpK2hI4754EQOOhVhXjjU5DWk4fp3AWFNvfmKPA2qWsvDf8IWzSn4TB+
         V2n9mMf9ZaJH2IxDVt/HwA/v6gX6HUY6jCacuktHoa1OYeEvOJ2KE6QhXLyCVN9E9CSB
         UbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232079; x=1697836879;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GUlSYTKyeiSi9PloS8btOVWKRe6DLrnGb3ptXHb88dA=;
        b=wyZReAw5TnKiRU2PFIS78hMlZrzOr5eZTdrJupHt0ttQWOfn470MbtahreJsFEJeHs
         2/qHj93cCXKe2mYtRJ3OWwVAV/zX7cJqN4cDmavTJDOeqYFyPNhXNiPwTqBFP8Czl/1F
         mzixX+ynbZwmE38tw9NC9B1LDywkv2F0UA6O0pmCKbx15T4yOUtfOqotSFUsLB5nFv6e
         ihUHY/TWTIXyaxBC1R3dX30bV2IZOvT5Z81uS1rOoQFzOb8nzNhSeVzb+tA3x4JU3Arc
         dnKj0H3O0ZJT2O1qY7TvvnojnnG55rx/EFo2O2VUtBPFlQsJU2sjTYoe+JhbjkO7pMl7
         jVrA==
X-Gm-Message-State: AOJu0Yz3X6Jhr80QPrphhjS11kRKTarGL4KHo4xszIsOJlBCrhOt4kng
        8RSMDyNm67xQ8Xc9DZODTuzVZAXjQTV5Z8PwJPp5SdXjSrbdK7RAAwH+VNICbPOQMxMJ3Qhw/Bv
        Ar1x+RHu3H2HbkEkfYIcPZKSFgsGf++lIhyhdcE5AEvobiTjtX5eMfdaZYXc=
X-Google-Smtp-Source: AGHT+IH5etLDxb0xWqzJUZA8+d9Ks7kfebTC2kPv2Kz+RI/VI+IEOxI3SH8+nMWVJPIfIV1IN8dhC1ACUQ==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:2cb4:ec7b:cfc0:caf7])
 (user=prohr job=sendgmr) by 2002:a25:d510:0:b0:d89:4247:4191 with SMTP id
 r16-20020a25d510000000b00d8942474191mr575606ybe.3.1697232079401; Fri, 13 Oct
 2023 14:21:19 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:21:12 -0700
In-Reply-To: <20231013212114.3445624-1-prohr@google.com>
Mime-Version: 1.0
References: <20231013212114.3445624-1-prohr@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231013212114.3445624-2-prohr@google.com>
Subject: [PATCH v2 1/3] net: add sysctl accept_ra_min_rtr_lft
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
 include/uapi/linux/ipv6.h              |  3 +++
 net/ipv6/addrconf.c                    | 10 ++++++++++
 net/ipv6/ndisc.c                       | 18 ++++++++++++++++--
 5 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/network=
ing/ip-sysctl.rst
index 7890b395e629..f0e875938bb7 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2070,6 +2070,14 @@ accept_ra_min_hop_limit - INTEGER
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
index d1f386430795..0e085d712296 100644
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
index 39c6add59a1a..2038eff9b63f 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -196,6 +196,9 @@ enum {
 	DEVCONF_IOAM6_ENABLED,
 	DEVCONF_IOAM6_ID,
 	DEVCONF_IOAM6_ID_WIDE,
+	DEVCONF_NDISC_EVICT_NOCARRIER,
+	DEVCONF_ACCEPT_UNTRACKED_NA,
+	DEVCONF_ACCEPT_RA_MIN_RTR_LFT,
 	DEVCONF_MAX
 };
=20
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 6572174e2115..e82e5cd047ec 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -209,6 +209,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
+	.accept_ra_min_rtr_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -268,6 +269,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
+	.accept_ra_min_rtr_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -5589,6 +5591,7 @@ static inline void ipv6_store_devconf(struct ipv6_dev=
conf *cnf,
 	array[DEVCONF_IOAM6_ENABLED] =3D cnf->ioam6_enabled;
 	array[DEVCONF_IOAM6_ID] =3D cnf->ioam6_id;
 	array[DEVCONF_IOAM6_ID_WIDE] =3D cnf->ioam6_id_wide;
+	array[DEVCONF_ACCEPT_RA_MIN_RTR_LFT] =3D cnf->accept_ra_min_rtr_lft;
 }
=20
 static inline size_t inet6_ifla6_size(void)
@@ -6782,6 +6785,13 @@ static const struct ctl_table addrconf_sysctl[] =3D =
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
index 3ab903f7e0f8..f19079c1b774 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1223,6 +1223,8 @@ static void ndisc_router_discovery(struct sk_buff *sk=
b)
 		return;
 	}
=20
+	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
+
 	if (!ipv6_accept_ra(in6_dev)) {
 		ND_PRINTK(2, info,
 			  "RA: %s, did not accept ra for dev: %s\n",
@@ -1230,6 +1232,13 @@ static void ndisc_router_discovery(struct sk_buff *s=
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
@@ -1282,8 +1291,6 @@ static void ndisc_router_discovery(struct sk_buff *sk=
b)
 		goto skip_defrtr;
 	}
=20
-	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	pref =3D ra_msg->icmph.icmp6_router_pref;
 	/* 10b is handled as if it were 00b (medium) */
@@ -1430,6 +1437,13 @@ static void ndisc_router_discovery(struct sk_buff *s=
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

