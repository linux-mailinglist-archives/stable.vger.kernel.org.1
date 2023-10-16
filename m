Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF397CA216
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjJPIpv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJPIpu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:45:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF88A2
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:45:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C92C433C8;
        Mon, 16 Oct 2023 08:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445946;
        bh=eRfjMoxX+orT05Sy5PVD3RS32Jbnud44Jq8soCkqYvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x2Ucr/Mv13pPBpBXyqEzKmK7RLJZwc+K7KC49Ap1ylMerDvwoiljLNuHXNumrkzgr
         mov4PXV6zNtM4IUJsaaA3D20fE46E/5k6BM8rkTc09XkjU9uhBSwfLz0N/7JbFExxW
         MQqLST0eHsCYsTj/ObjJwMEL1i+DUkOs9yBOyOLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Patrick Rohr <prohr@google.com>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 043/102] net: add sysctl accept_ra_min_rtr_lft
Date:   Mon, 16 Oct 2023 10:40:42 +0200
Message-ID: <20231016083954.847477866@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrick Rohr <prohr@google.com>

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
Cc: Maciej Żenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/networking/ip-sysctl.rst |    8 ++++++++
 include/linux/ipv6.h                   |    1 +
 include/uapi/linux/ipv6.h              |    3 +++
 net/ipv6/addrconf.c                    |   10 ++++++++++
 net/ipv6/ndisc.c                       |   18 ++++++++++++++++--
 5 files changed, 38 insertions(+), 2 deletions(-)

--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2070,6 +2070,14 @@ accept_ra_min_hop_limit - INTEGER
 
 	Default: 1
 
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
 
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -209,6 +209,7 @@ static struct ipv6_devconf ipv6_devconf
 	.ra_defrtr_metric	= IP6_RT_PRIO_USER,
 	.accept_ra_from_local	= 0,
 	.accept_ra_min_hop_limit= 1,
+	.accept_ra_min_rtr_lft	= 0,
 	.accept_ra_pinfo	= 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	= 1,
@@ -268,6 +269,7 @@ static struct ipv6_devconf ipv6_devconf_
 	.ra_defrtr_metric	= IP6_RT_PRIO_USER,
 	.accept_ra_from_local	= 0,
 	.accept_ra_min_hop_limit= 1,
+	.accept_ra_min_rtr_lft	= 0,
 	.accept_ra_pinfo	= 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	= 1,
@@ -5589,6 +5591,7 @@ static inline void ipv6_store_devconf(st
 	array[DEVCONF_IOAM6_ENABLED] = cnf->ioam6_enabled;
 	array[DEVCONF_IOAM6_ID] = cnf->ioam6_id;
 	array[DEVCONF_IOAM6_ID_WIDE] = cnf->ioam6_id_wide;
+	array[DEVCONF_ACCEPT_RA_MIN_RTR_LFT] = cnf->accept_ra_min_rtr_lft;
 }
 
 static inline size_t inet6_ifla6_size(void)
@@ -6781,6 +6784,13 @@ static const struct ctl_table addrconf_s
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "accept_ra_min_rtr_lft",
+		.data		= &ipv6_devconf.accept_ra_min_rtr_lft,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
 	},
 	{
 		.procname	= "accept_ra_pinfo",
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1223,6 +1223,8 @@ static void ndisc_router_discovery(struc
 		return;
 	}
 
+	lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);
+
 	if (!ipv6_accept_ra(in6_dev)) {
 		ND_PRINTK(2, info,
 			  "RA: %s, did not accept ra for dev: %s\n",
@@ -1230,6 +1232,13 @@ static void ndisc_router_discovery(struc
 		goto skip_linkparms;
 	}
 
+	if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
+		ND_PRINTK(2, info,
+			  "RA: router lifetime (%ds) is too short: %s\n",
+			  lifetime, skb->dev->name);
+		goto skip_linkparms;
+	}
+
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	/* skip link-specific parameters from interior routers */
 	if (skb->ndisc_nodetype == NDISC_NODETYPE_NODEFAULT) {
@@ -1282,8 +1291,6 @@ static void ndisc_router_discovery(struc
 		goto skip_defrtr;
 	}
 
-	lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	pref = ra_msg->icmph.icmp6_router_pref;
 	/* 10b is handled as if it were 00b (medium) */
@@ -1430,6 +1437,13 @@ skip_linkparms:
 		goto out;
 	}
 
+	if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
+		ND_PRINTK(2, info,
+			  "RA: router lifetime (%ds) is too short: %s\n",
+			  lifetime, skb->dev->name);
+		goto out;
+	}
+
 #ifdef CONFIG_IPV6_ROUTE_INFO
 	if (!in6_dev->cnf.accept_ra_from_local &&
 	    ipv6_chk_addr(dev_net(in6_dev->dev), &ipv6_hdr(skb)->saddr,


