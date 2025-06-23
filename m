Return-Path: <stable+bounces-156740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8477DAE50F1
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47542189E8C4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BB72206BB;
	Mon, 23 Jun 2025 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wzWkjWby"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD261EDA0F;
	Mon, 23 Jun 2025 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714150; cv=none; b=kRuzWl2MMTc8X8zUFb82rY0zLTST5BKvMWCY+zxhBGcdF+JRzYeHVgjgj8kQ435dRHJHxVnyZbjsyUVcqU6Ex3lW1VVdXHCgUlVFm8X+BdFW9aLWTReCCDzxrnpYpyczhmB/Vk8qQOwGMF3XgRPWYSGGA0sFiuju+DcWm87nJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714150; c=relaxed/simple;
	bh=Nbqfee1M/JPvK5nCAdhsF66QYD2kKoJLJSE23yBgJPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNBjeb6W1zpxIFowFUV8TzR+f68BzbY8xE3mt39kBGBkjkJaal+bsGxo5Fr6W1IGgvehZfNeMXvSX/hA1Oua4cUKdqjByYb1IbXHw42WcAWQoo72lIujPRi3ZTePIls4+pOe9GjKB7HJd5g/zOMqUGrt8iiZBblkre0vek2PqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wzWkjWby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D526AC4CEEA;
	Mon, 23 Jun 2025 21:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714150;
	bh=Nbqfee1M/JPvK5nCAdhsF66QYD2kKoJLJSE23yBgJPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wzWkjWbyhNgdV1IA3rBrDd29WNIxLU8qCWLEMZ9ew2sWz4VzrF0myVBcwgxNIU/W9
	 5vg5FuVLacI+gc0TRr3J7wDyf7wHDG9WpQcuQ4ZUQtqFSyxwGTYqlvbkZQsvSv8BZB
	 IIJJpLl7p4E1bfnAMbDczomU2oYiAqqMZpw3wYJ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yong Wang <yongwang@nvidia.com>,
	Andy Roulin <aroulin@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 393/592] net: bridge: mcast: re-implement br_multicast_{enable, disable}_port functions
Date: Mon, 23 Jun 2025 15:05:51 +0200
Message-ID: <20250623130709.792342648@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yong Wang <yongwang@nvidia.com>

[ Upstream commit 4b30ae9adb047dd0a7982975ec3933c529537026 ]

When a bridge port STP state is changed from BLOCKING/DISABLED to
FORWARDING, the port's igmp query timer will NOT re-arm itself if the
bridge has been configured as per-VLAN multicast snooping.

Solve this by choosing the correct multicast context(s) to enable/disable
port multicast based on whether per-VLAN multicast snooping is enabled or
not, i.e. using per-{port, VLAN} context in case of per-VLAN multicast
snooping by re-implementing br_multicast_enable_port() and
br_multicast_disable_port() functions.

Before the patch, the IGMP query does not happen in the last step of the
following test sequence, i.e. no growth for tx counter:
 # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
 # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
 # ip link add name swp1 up master br1 type dummy
 # bridge link set dev swp1 state 0
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # sleep 1
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # bridge link set dev swp1 state 3
 # sleep 2
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1

After the patch, the IGMP query happens in the last step of the test:
 # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
 # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
 # ip link add name swp1 up master br1 type dummy
 # bridge link set dev swp1 state 0
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # sleep 1
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # bridge link set dev swp1 state 3
 # sleep 2
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
3

Signed-off-by: Yong Wang <yongwang@nvidia.com>
Reviewed-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_multicast.c | 77 +++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 35e1fd4ec82ea..7e0b2362b9ee5 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2105,12 +2105,17 @@ static void __br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	}
 }
 
-void br_multicast_enable_port(struct net_bridge_port *port)
+static void br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 {
-	struct net_bridge *br = port->br;
+	struct net_bridge *br = pmctx->port->br;
 
 	spin_lock_bh(&br->multicast_lock);
-	__br_multicast_enable_port_ctx(&port->multicast_ctx);
+	if (br_multicast_port_ctx_is_vlan(pmctx) &&
+	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+		spin_unlock_bh(&br->multicast_lock);
+		return;
+	}
+	__br_multicast_enable_port_ctx(pmctx);
 	spin_unlock_bh(&br->multicast_lock);
 }
 
@@ -2137,11 +2142,67 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	br_multicast_rport_del_notify(pmctx, del);
 }
 
+static void br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
+{
+	struct net_bridge *br = pmctx->port->br;
+
+	spin_lock_bh(&br->multicast_lock);
+	if (br_multicast_port_ctx_is_vlan(pmctx) &&
+	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+		spin_unlock_bh(&br->multicast_lock);
+		return;
+	}
+
+	__br_multicast_disable_port_ctx(pmctx);
+	spin_unlock_bh(&br->multicast_lock);
+}
+
+static void br_multicast_toggle_port(struct net_bridge_port *port, bool on)
+{
+#if IS_ENABLED(CONFIG_BRIDGE_VLAN_FILTERING)
+	if (br_opt_get(port->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
+		struct net_bridge_vlan_group *vg;
+		struct net_bridge_vlan *vlan;
+
+		rcu_read_lock();
+		vg = nbp_vlan_group_rcu(port);
+		if (!vg) {
+			rcu_read_unlock();
+			return;
+		}
+
+		/* iterate each vlan, toggle vlan multicast context */
+		list_for_each_entry_rcu(vlan, &vg->vlan_list, vlist) {
+			struct net_bridge_mcast_port *pmctx =
+						&vlan->port_mcast_ctx;
+			u8 state = br_vlan_get_state(vlan);
+			/* enable vlan multicast context when state is
+			 * LEARNING or FORWARDING
+			 */
+			if (on && br_vlan_state_allowed(state, true))
+				br_multicast_enable_port_ctx(pmctx);
+			else
+				br_multicast_disable_port_ctx(pmctx);
+		}
+		rcu_read_unlock();
+		return;
+	}
+#endif
+	/* toggle port multicast context when vlan snooping is disabled */
+	if (on)
+		br_multicast_enable_port_ctx(&port->multicast_ctx);
+	else
+		br_multicast_disable_port_ctx(&port->multicast_ctx);
+}
+
+void br_multicast_enable_port(struct net_bridge_port *port)
+{
+	br_multicast_toggle_port(port, true);
+}
+
 void br_multicast_disable_port(struct net_bridge_port *port)
 {
-	spin_lock_bh(&port->br->multicast_lock);
-	__br_multicast_disable_port_ctx(&port->multicast_ctx);
-	spin_unlock_bh(&port->br->multicast_lock);
+	br_multicast_toggle_port(port, false);
 }
 
 static int __grp_src_delete_marked(struct net_bridge_port_group *pg)
@@ -4330,9 +4391,9 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 		__br_multicast_open(&br->multicast_ctx);
 	list_for_each_entry(p, &br->port_list, list) {
 		if (on)
-			br_multicast_disable_port(p);
+			br_multicast_disable_port_ctx(&p->multicast_ctx);
 		else
-			br_multicast_enable_port(p);
+			br_multicast_enable_port_ctx(&p->multicast_ctx);
 	}
 
 	list_for_each_entry(vlan, &vg->vlan_list, vlist)
-- 
2.39.5




