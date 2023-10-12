Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2487C7AA6
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 01:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjJLXzf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 19:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJLXze (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 19:55:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC50B8
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 16:55:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d84acda47aeso2077327276.3
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 16:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697154932; x=1697759732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5ij0e2kIxKCsiGg5rDfH3cgm5jv4V/QaqDvCqj59E0=;
        b=M/hQfTE1c5sZI3eCSWlIuXQNXi9rtuzwcMKu76yhLOPdXJrrYvBpl+AVAIPpN/a3E6
         pO6IchVS39kn5rm/OhXuDztaD23cFNcekvNI/2Rugt/bMmEjeTxD5SNzw5lNW6CmajVT
         Kd7D7O3Ljf9MuppRXykJEOPFlb8NVT7mMB/DKuckuPWnlGkolaLiqm7alUbSu2isiZH+
         GYWu5zLVQZ38xRlKKmHgP8Vpnoh/3xSlZ+k5HeO4IKfkYYfZS4WGOBEm1bMKiDzMGcJs
         15sktcxBbhbdvn5RoicDQy+I+SCtH4z0NNjaTdviP/Vki29FUeqxote1GTRZi9K632B/
         g7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697154932; x=1697759732;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o5ij0e2kIxKCsiGg5rDfH3cgm5jv4V/QaqDvCqj59E0=;
        b=Txbho4cl7vBptiExqdP0EczrkzviX2uMLYxCq0EijZVrLZWPDeIasbscbBAXnfZ0a4
         gQlE5SUHl7Rv57/NQS6iyl+Jlf+26vpC/txvgVNc55mejEGLss9Xtyf9WTmY6+VN5Yc6
         mJMD33Por3d2dB/WF5x2owTAeqRUk05HFsLk4f/L+yvBl6qIp59B8r5u9M8R6txQDsbj
         GqSRKorDmugMzSBDoXR8RNP15IU1BrKFtLqCxPhUTTy2qvMjcpktwcbpZ02bFGLtYzRB
         mV12lCFYMzSXx6L7G9FqmDZKGnfsdjuB4aM3ju39D+SoDrCtvCqmd7bvn2PNqZ+lN5O3
         c2Tg==
X-Gm-Message-State: AOJu0YzUSpb0ngdq3C6+noLQk6DVzhTTrAO//ok/N7zTr0dtaVLb8Xgo
        Z+OfeANp8UtN1//COSigqNd/hIDYbyhjz4WuReNmf5oSxqRWCEI7iImk6E51xHlRuFSSdTIhAcv
        /mObSUFQwkBhX/FVlLTr2W3Q2kdm2NYFCG30HvbENwZjmqQXgPGRdJQHhc/M=
X-Google-Smtp-Source: AGHT+IHWYTsChXAef22zs2vFfrCVKLX43MoT2i/KGTJtKspDEZBaDBAoqgJu5rjilo/5l4GFrDvxfvrE+w==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:b3aa:6851:9f24:c50a])
 (user=prohr job=sendgmr) by 2002:a25:4056:0:b0:d9a:4f4c:961b with SMTP id
 n83-20020a254056000000b00d9a4f4c961bmr200447yba.1.1697154932062; Thu, 12 Oct
 2023 16:55:32 -0700 (PDT)
Date:   Thu, 12 Oct 2023 16:55:22 -0700
In-Reply-To: <20231012235524.2741092-1-prohr@google.com>
Mime-Version: 1.0
References: <20231012235524.2741092-1-prohr@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231012235524.2741092-2-prohr@google.com>
Subject: [PATCH 1/3] net: add sysctl accept_ra_min_rtr_lft
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 1671bcfd76fdc0b9e65153cf759153083755fe4c upstream.

(Backported without unnecessary UAPI portion.)

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
 net/ipv6/addrconf.c                    |  9 +++++++++
 net/ipv6/ndisc.c                       | 18 ++++++++++++++++--
 4 files changed, 34 insertions(+), 2 deletions(-)

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
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 6572174e2115..3f7a0bc5f631 100644
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
@@ -6782,6 +6784,13 @@ static const struct ctl_table addrconf_sysctl[] =3D =
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

