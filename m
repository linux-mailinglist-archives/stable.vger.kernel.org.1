Return-Path: <stable+bounces-150856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BD1ACD186
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 02:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EFCF7A35AB
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 00:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF21AF0B6;
	Wed,  4 Jun 2025 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sirBc9Qr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C3B136349;
	Wed,  4 Jun 2025 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998454; cv=none; b=Y+emB907+tBzBLzzocfnq2Goeq325czhgFyEyawb4Pj+Uo+kmG4ul65uSdzSHf+caoLwzqvF7T36RtR6S/89QNRqB9rCOYNUMN8RtcJGeXM12a2aYdoSaKC0VirGlmMMw8a6rE7ysB5hlQBq4VCCkPwGlUDkRg86ArHZMo5nZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998454; c=relaxed/simple;
	bh=dQpebwv3fukHQYBo+UHi+1twyy7ckx+9oPJDDK8v5yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MptYQQGb983FUwVfn+FgkRoDH3X6anAVD2pRE030wBBGci1tefPtFH6upxLMO98iFtPNqvVgz1uO6vJArpwgpP14srKo+W5mNXoIfldDT2blNGfX65zGU2oNHDkLRdgBjhn21iQU0bqp8JiVsoKWegZn56vILEFzsuTPYPahgBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sirBc9Qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1B1C4CEED;
	Wed,  4 Jun 2025 00:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998453;
	bh=dQpebwv3fukHQYBo+UHi+1twyy7ckx+9oPJDDK8v5yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sirBc9QruZ7Oq4h8oLy3gMotYl07M6+R2BNUt65MoBDK0dfliZ90p8zTxLV4SV8rG
	 cOdoDc0dn5XCQl3Mz9xZ/6RAC7RgSXb7+Ue+PgwhAcK3YzQPAnmz4sXv0oxwYWhzcd
	 k+yodL5hUqJaSvfmjx0QMXV5Axw1W4iJoRzKGzNlBRKcyVXgK3+nRAmaiFAe0pTSTG
	 cKnBjpALvPcqo0GaD+JwCbMPF6Dl1n8xAx8LL+eiYywp6KKyInL0zsLErYJWLFRWAa
	 fUMlVS/0myvdrATjV8k8X8jRPJhCtrOG04XV+5rnHm3F66s1OLcWb7lcWyZTM8HMma
	 lBBNWyldmqpbQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yong Wang <yongwang@nvidia.com>,
	Andy Roulin <aroulin@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 085/118] net: bridge: mcast: update multicast contex when vlan state is changed
Date: Tue,  3 Jun 2025 20:50:16 -0400
Message-Id: <20250604005049.4147522-85-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005049.4147522-1-sashal@kernel.org>
References: <20250604005049.4147522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yong Wang <yongwang@nvidia.com>

[ Upstream commit 6c131043eaf1be2a6cc2d228f92ceb626fbcc0f3 ]

When the vlan STP state is changed, which could be manipulated by
"bridge vlan" commands, similar to port STP state, this also impacts
multicast behaviors such as igmp query. In the scenario of per-VLAN
snooping, there's a need to update the corresponding multicast context
to re-arm the port query timer when vlan state becomes "forwarding" etc.

Update br_vlan_set_state() function to enable vlan multicast context
in such scenario.

Before the patch, the IGMP query does not happen in the last step of the
following test sequence, i.e. no growth for tx counter:
 # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
 # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
 # ip link add name swp1 up master br1 type dummy
 # sleep 1
 # bridge vlan set vid 1 dev swp1 state 4
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # sleep 1
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # bridge vlan set vid 1 dev swp1 state 3
 # sleep 2
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1

After the patch, the IGMP query happens in the last step of the test:
 # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
 # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
 # ip link add name swp1 up master br1 type dummy
 # sleep 1
 # bridge vlan set vid 1 dev swp1 state 4
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # sleep 1
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # bridge vlan set vid 1 dev swp1 state 3
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

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Bug Fix Classification This is clearly a **bug
fix** that resolves broken IGMP query functionality when VLAN states
change. The commit message and test output demonstrate a clear
before/after scenario where IGMP queries fail to increment after VLAN
state transitions to forwarding, then work correctly after the patch. ##
Code Analysis ### 1. Core Issue and Fix The bug occurs because VLAN
state changes weren't properly synchronizing with multicast contexts.
The fix adds a call to `br_multicast_update_vlan_mcast_ctx(v, state)` in
the `br_vlan_set_state()` function: ```c static inline void
br_vlan_set_state(struct net_bridge_vlan *v, u8 state) {
WRITE_ONCE(v->state, state); + br_multicast_update_vlan_mcast_ctx(v,
state); // NEW LINE } ``` ### 2. Low Risk Assessment The changes are
**low risk** because: - **Conservative approach**: The fix reuses
existing, well-tested multicast context update logic - **Targeted
scope**: Only affects VLAN state → multicast context synchronization -
**Built-in safeguards**: The `br_multicast_update_vlan_mcast_ctx()`
function includes multiple safety checks: ```c if
(!br_vlan_should_use(v)) return; if (br_vlan_is_master(v)) return; if
(!br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) return; ``` ### 3.
Production Impact This bug affects **critical networking
functionality**: - **Broken multicast in VLAN environments**: IGMP
queries fail when VLANs transition to forwarding state - **Real-world
scenarios**: Common in enterprise networks using VLAN filtering with
multicast applications (video conferencing, IPTV, gaming) - **STP
convergence issues**: After network topology changes, multicast
functionality remains broken until manual intervention ### 4. Minimal
Code Footprint The changes are **minimal and contained**: - **3 files
changed**: All within bridge multicast/VLAN subsystem - **Small
additions**: New function + one-line addition to existing inline
function - **No API changes**: Internal synchronization fix only - **No
architectural changes**: Uses existing code paths and patterns ### 5.
Comparison with Historical Examples Looking at the similar commits
provided: - **Similar to Commit #4 (YES)**: Also fixes a helper function
in bridge multicast VLAN logic with minimal risk - **Unlike Commits
#1-3, #5 (NO)**: Those add new features or make architectural changes,
while this purely fixes broken existing functionality ### 6. Critical
Networking Subsystem Bridge multicast snooping is a **core networking
feature** that: - Prevents multicast flooding in switched networks -
Essential for network performance in multicast-heavy environments -
Widely deployed in production networks ### 7. Test Evidence The commit
message provides concrete test evidence showing: - **Before**: IGMP
query counter remains at 1 (broken) - **After**: IGMP query counter
increases to 3 (working) This demonstrates the fix resolves a
measurable, reproducible issue. ## Conclusion This commit meets all the
criteria for stable backporting: it's a low-risk fix for broken
functionality in a critical networking subsystem, with minimal code
changes and clear test evidence of the problem and solution. The
synchronization issue between VLAN state management and multicast
contexts represents exactly the type of bug that stable trees are
designed to address.

 net/bridge/br_mst.c       |  4 ++--
 net/bridge/br_multicast.c | 26 ++++++++++++++++++++++++++
 net/bridge/br_private.h   | 11 ++++++++++-
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 1820f09ff59ce..3f24b4ee49c27 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -80,10 +80,10 @@ static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
 	if (br_vlan_get_state(v) == state)
 		return;
 
-	br_vlan_set_state(v, state);
-
 	if (v->vid == vg->pvid)
 		br_vlan_set_pvid_state(vg, state);
+
+	br_vlan_set_state(v, state);
 }
 
 int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index dcbf058de1e3b..35e1fd4ec82ea 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4211,6 +4211,32 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 #endif
 }
 
+void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
+{
+#if IS_ENABLED(CONFIG_BRIDGE_VLAN_FILTERING)
+	struct net_bridge *br;
+
+	if (!br_vlan_should_use(v))
+		return;
+
+	if (br_vlan_is_master(v))
+		return;
+
+	br = v->port->br;
+
+	if (!br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
+		return;
+
+	if (br_vlan_state_allowed(state, true))
+		br_multicast_enable_port_ctx(&v->port_mcast_ctx);
+
+	/* Multicast is not disabled for the vlan when it goes in
+	 * blocking state because the timers will expire and stop by
+	 * themselves without sending more queries.
+	 */
+#endif
+}
+
 void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 {
 	struct net_bridge *br;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 4715a8d6dc326..c41d315b09d32 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1052,6 +1052,7 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 				struct net_bridge_vlan *vlan,
 				struct net_bridge_mcast_port *pmctx);
 void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx);
+void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state);
 void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on);
 int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 				      struct netlink_ext_ack *extack);
@@ -1502,6 +1503,11 @@ static inline void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pm
 {
 }
 
+static inline void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v,
+						      u8 state)
+{
+}
+
 static inline void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan,
 						bool on)
 {
@@ -1862,7 +1868,9 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 			      const struct net_bridge_vlan *v_opts);
 
-/* vlan state manipulation helpers using *_ONCE to annotate lock-free access */
+/* vlan state manipulation helpers using *_ONCE to annotate lock-free access,
+ * while br_vlan_set_state() may access data protected by multicast_lock.
+ */
 static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
 {
 	return READ_ONCE(v->state);
@@ -1871,6 +1879,7 @@ static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
 static inline void br_vlan_set_state(struct net_bridge_vlan *v, u8 state)
 {
 	WRITE_ONCE(v->state, state);
+	br_multicast_update_vlan_mcast_ctx(v, state);
 }
 
 static inline u8 br_vlan_get_pvid_state(const struct net_bridge_vlan_group *vg)
-- 
2.39.5


