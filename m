Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E497CA218
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjJPIpy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPIpy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:45:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26582A1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:45:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7AEC433C7;
        Mon, 16 Oct 2023 08:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445951;
        bh=NMweXkFVtFiDWm4qS6U6cNfXyZxzXL9Aw8zrwUE13TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BwnFPQfzQk1oswpogP18xmjek0viUeTOBGyWZEiourQuvTyHdJl3FiEpUzd2SOAoa
         eCxwexLu9W2srXDzJP2Wdl9TZZWNB177T7h96ojyKLTHdcZr1H0zo6Yt0xH802/3k2
         06IcOISkmKfGVpIsHTrMd6ye5oih4R49j4tvYQfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lorenzo Colitti <lorenzo@google.com>,
        Patrick Rohr <prohr@google.com>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 044/102] net: change accept_ra_min_rtr_lft to affect all RA lifetimes
Date:   Mon, 16 Oct 2023 10:40:43 +0200
Message-ID: <20231016083954.873479156@linuxfoundation.org>
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
Reviewed-by: Maciej Żenczykowski <maze@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20230726230701.919212-1-prohr@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/networking/ip-sysctl.rst |    8 ++++----
 include/linux/ipv6.h                   |    2 +-
 include/uapi/linux/ipv6.h              |    2 +-
 net/ipv6/addrconf.c                    |   13 ++++++++-----
 net/ipv6/ndisc.c                       |   27 +++++++++++----------------
 5 files changed, 25 insertions(+), 27 deletions(-)

--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2070,11 +2070,11 @@ accept_ra_min_hop_limit - INTEGER
 
 	Default: 1
 
-accept_ra_min_rtr_lft - INTEGER
-	Minimum acceptable router lifetime in Router Advertisement.
+accept_ra_min_lft - INTEGER
+	Minimum acceptable lifetime value in Router Advertisement.
 
-	RAs with a router lifetime less than this value shall be
-	ignored. RAs with a router lifetime of 0 are unaffected.
+	RA sections with a lifetime less than this value shall be
+	ignored. Zero lifetimes stay unaffected.
 
 	Default: 0
 
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
 
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -209,7 +209,7 @@ static struct ipv6_devconf ipv6_devconf
 	.ra_defrtr_metric	= IP6_RT_PRIO_USER,
 	.accept_ra_from_local	= 0,
 	.accept_ra_min_hop_limit= 1,
-	.accept_ra_min_rtr_lft	= 0,
+	.accept_ra_min_lft	= 0,
 	.accept_ra_pinfo	= 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	= 1,
@@ -269,7 +269,7 @@ static struct ipv6_devconf ipv6_devconf_
 	.ra_defrtr_metric	= IP6_RT_PRIO_USER,
 	.accept_ra_from_local	= 0,
 	.accept_ra_min_hop_limit= 1,
-	.accept_ra_min_rtr_lft	= 0,
+	.accept_ra_min_lft	= 0,
 	.accept_ra_pinfo	= 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	= 1,
@@ -2736,6 +2736,9 @@ void addrconf_prefix_rcv(struct net_devi
 		return;
 	}
 
+	if (valid_lft != 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft)
+		return;
+
 	/*
 	 *	Two things going on here:
 	 *	1) Add routes for on-link prefixes
@@ -5591,7 +5594,7 @@ static inline void ipv6_store_devconf(st
 	array[DEVCONF_IOAM6_ENABLED] = cnf->ioam6_enabled;
 	array[DEVCONF_IOAM6_ID] = cnf->ioam6_id;
 	array[DEVCONF_IOAM6_ID_WIDE] = cnf->ioam6_id_wide;
-	array[DEVCONF_ACCEPT_RA_MIN_RTR_LFT] = cnf->accept_ra_min_rtr_lft;
+	array[DEVCONF_ACCEPT_RA_MIN_LFT] = cnf->accept_ra_min_lft;
 }
 
 static inline size_t inet6_ifla6_size(void)
@@ -6786,8 +6789,8 @@ static const struct ctl_table addrconf_s
 		.proc_handler	= proc_dointvec,
 	},
 	{
-		.procname	= "accept_ra_min_rtr_lft",
-		.data		= &ipv6_devconf.accept_ra_min_rtr_lft,
+		.procname	= "accept_ra_min_lft",
+		.data		= &ipv6_devconf.accept_ra_min_lft,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1223,8 +1223,6 @@ static void ndisc_router_discovery(struc
 		return;
 	}
 
-	lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 	if (!ipv6_accept_ra(in6_dev)) {
 		ND_PRINTK(2, info,
 			  "RA: %s, did not accept ra for dev: %s\n",
@@ -1232,13 +1230,6 @@ static void ndisc_router_discovery(struc
 		goto skip_linkparms;
 	}
 
-	if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
-		ND_PRINTK(2, info,
-			  "RA: router lifetime (%ds) is too short: %s\n",
-			  lifetime, skb->dev->name);
-		goto skip_linkparms;
-	}
-
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	/* skip link-specific parameters from interior routers */
 	if (skb->ndisc_nodetype == NDISC_NODETYPE_NODEFAULT) {
@@ -1279,6 +1270,14 @@ static void ndisc_router_discovery(struc
 		goto skip_defrtr;
 	}
 
+	lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);
+	if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_lft) {
+		ND_PRINTK(2, info,
+			  "RA: router lifetime (%ds) is too short: %s\n",
+			  lifetime, skb->dev->name);
+		goto skip_defrtr;
+	}
+
 	/* Do not accept RA with source-addr found on local machine unless
 	 * accept_ra_from_local is set to true.
 	 */
@@ -1437,13 +1436,6 @@ skip_linkparms:
 		goto out;
 	}
 
-	if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
-		ND_PRINTK(2, info,
-			  "RA: router lifetime (%ds) is too short: %s\n",
-			  lifetime, skb->dev->name);
-		goto out;
-	}
-
 #ifdef CONFIG_IPV6_ROUTE_INFO
 	if (!in6_dev->cnf.accept_ra_from_local &&
 	    ipv6_chk_addr(dev_net(in6_dev->dev), &ipv6_hdr(skb)->saddr,
@@ -1468,6 +1460,9 @@ skip_linkparms:
 			if (ri->prefix_len == 0 &&
 			    !in6_dev->cnf.accept_ra_defrtr)
 				continue;
+			if (ri->lifetime != 0 &&
+			    ntohl(ri->lifetime) < in6_dev->cnf.accept_ra_min_lft)
+				continue;
 			if (ri->prefix_len < in6_dev->cnf.accept_ra_rt_info_min_plen)
 				continue;
 			if (ri->prefix_len > in6_dev->cnf.accept_ra_rt_info_max_plen)


