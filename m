Return-Path: <stable+bounces-91495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C8C9BEE3F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251DB1F24FBC
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F2B1E32DC;
	Wed,  6 Nov 2024 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FCns1t5z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255E1DFE33;
	Wed,  6 Nov 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898900; cv=none; b=HUeGzrIeblyUA7ka1nGJrUmGC/V8Fe3xZdXDeBxD3EWTmlbmcjBS8qhhsOd9PREvjbImeD3KNs1sY/BTT7O+ynF0tEUxvT8g3doxFOP50xR3Q+IyvcojvkV4mb4ROLeb2DqkL9Q2xr48YN8hta9t61yskfZnY9+BNUoMCl2in0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898900; c=relaxed/simple;
	bh=p73J2Ax/RiZ/HAI8ZVAntPEZDkKPh/Ijn+pum/XqCls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMiXNfdJVBnQDLxmP6DKBFKUK3O0KC3Ptrds1kU733dv5Q2qdnPl/iLnQCS2i4MDzikHjY0SWEN5QpuiKTN3/3Um/lfe//anNAhcczLL8pVss76IH5Hfv78Wmkcqh+HOa3wdU6DhU4q9f0/vnvsPI4Y5pEHpzCU6GEmA3eFA2kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FCns1t5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37162C4CED4;
	Wed,  6 Nov 2024 13:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898899;
	bh=p73J2Ax/RiZ/HAI8ZVAntPEZDkKPh/Ijn+pum/XqCls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCns1t5zLydl/R5aFUFMPj75pimgsgZL595U5GQhhOZ9z8TFSoN5xnb+uws+OcSw2
	 +S618WepgjUWtnz/aBWsuIZd7r7+tYK/FZ9Wp8nFVqhzx8mV4RHbFP8grWNdra3TCl
	 P/HHdjBRV0ttgtpjHTBxdBe9jAGzXe6CH1pbPfSg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 394/462] genetlink: hold RCU in genlmsg_mcast()
Date: Wed,  6 Nov 2024 13:04:47 +0100
Message-ID: <20241106120341.257917381@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 56440d7ec28d60f8da3bfa09062b3368ff9b16db ]

While running net selftests with CONFIG_PROVE_RCU_LIST=y I saw
one lockdep splat [1].

genlmsg_mcast() uses for_each_net_rcu(), and must therefore hold RCU.

Instead of letting all callers guard genlmsg_multicast_allns()
with a rcu_read_lock()/rcu_read_unlock() pair, do it in genlmsg_mcast().

This also means the @flags parameter is useless, we need to always use
GFP_ATOMIC.

[1]
[10882.424136] =============================
[10882.424166] WARNING: suspicious RCU usage
[10882.424309] 6.12.0-rc2-virtme #1156 Not tainted
[10882.424400] -----------------------------
[10882.424423] net/netlink/genetlink.c:1940 RCU-list traversed in non-reader section!!
[10882.424469]
other info that might help us debug this:

[10882.424500]
rcu_scheduler_active = 2, debug_locks = 1
[10882.424744] 2 locks held by ip/15677:
[10882.424791] #0: ffffffffb6b491b0 (cb_lock){++++}-{3:3}, at: genl_rcv (net/netlink/genetlink.c:1219)
[10882.426334] #1: ffffffffb6b49248 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg (net/netlink/genetlink.c:61 net/netlink/genetlink.c:57 net/netlink/genetlink.c:1209)
[10882.426465]
stack backtrace:
[10882.426805] CPU: 14 UID: 0 PID: 15677 Comm: ip Not tainted 6.12.0-rc2-virtme #1156
[10882.426919] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[10882.427046] Call Trace:
[10882.427131]  <TASK>
[10882.427244] dump_stack_lvl (lib/dump_stack.c:123)
[10882.427335] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
[10882.427387] genlmsg_multicast_allns (net/netlink/genetlink.c:1940 (discriminator 7) net/netlink/genetlink.c:1977 (discriminator 7))
[10882.427436] l2tp_tunnel_notify.constprop.0 (net/l2tp/l2tp_netlink.c:119) l2tp_netlink
[10882.427683] l2tp_nl_cmd_tunnel_create (net/l2tp/l2tp_netlink.c:253) l2tp_netlink
[10882.427748] genl_family_rcv_msg_doit (net/netlink/genetlink.c:1115)
[10882.427834] genl_rcv_msg (net/netlink/genetlink.c:1195 net/netlink/genetlink.c:1210)
[10882.427877] ? __pfx_l2tp_nl_cmd_tunnel_create (net/l2tp/l2tp_netlink.c:186) l2tp_netlink
[10882.427927] ? __pfx_genl_rcv_msg (net/netlink/genetlink.c:1201)
[10882.427959] netlink_rcv_skb (net/netlink/af_netlink.c:2551)
[10882.428069] genl_rcv (net/netlink/genetlink.c:1220)
[10882.428095] netlink_unicast (net/netlink/af_netlink.c:1332 net/netlink/af_netlink.c:1357)
[10882.428140] netlink_sendmsg (net/netlink/af_netlink.c:1901)
[10882.428210] ____sys_sendmsg (net/socket.c:729 (discriminator 1) net/socket.c:744 (discriminator 1) net/socket.c:2607 (discriminator 1))

Fixes: 33f72e6f0c67 ("l2tp : multicast notification to the registered listeners")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: James Chapman <jchapman@katalix.com>
Cc: Tom Parkin <tparkin@katalix.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20241011171217.3166614-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_user.c |  2 +-
 include/net/genetlink.h           |  3 +--
 net/l2tp/l2tp_netlink.c           |  4 ++--
 net/netlink/genetlink.c           | 28 ++++++++++++++--------------
 net/wireless/nl80211.c            |  8 ++------
 5 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 077c56cbed4e1..aa187672cf99e 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1788,7 +1788,7 @@ static int tcmu_netlink_event_send(struct tcmu_dev *udev,
 	}
 
 	ret = genlmsg_multicast_allns(&tcmu_genl_family, skb, 0,
-				      TCMU_MCGRP_CONFIG, GFP_KERNEL);
+				      TCMU_MCGRP_CONFIG);
 
 	/* Wait during an add as the listener may not be up yet */
 	if (ret == 0 ||
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 2d52776def52c..19d51689a8212 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -299,13 +299,12 @@ static inline int genlmsg_multicast(const struct genl_family *family,
  * @skb: netlink message as socket buffer
  * @portid: own netlink portid to avoid sending to yourself
  * @group: offset of multicast group in groups array
- * @flags: allocation flags
  *
  * This function must hold the RTNL or rcu_read_lock().
  */
 int genlmsg_multicast_allns(const struct genl_family *family,
 			    struct sk_buff *skb, u32 portid,
-			    unsigned int group, gfp_t flags);
+			    unsigned int group);
 
 /**
  * genlmsg_unicast - unicast a netlink message
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index ebb381c3f1b99..733f59822f8f8 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -117,7 +117,7 @@ static int l2tp_tunnel_notify(struct genl_family *family,
 				  NLM_F_ACK, tunnel, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0, GFP_ATOMIC);
+		ret = genlmsg_multicast_allns(family, msg, 0, 0);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
@@ -145,7 +145,7 @@ static int l2tp_session_notify(struct genl_family *family,
 				   NLM_F_ACK, session, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0, GFP_ATOMIC);
+		ret = genlmsg_multicast_allns(family, msg, 0, 0);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index a03e16e06e29d..e56994104eed4 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -949,15 +949,11 @@ static int genl_ctrl_event(int event, const struct genl_family *family,
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
-	if (!family->netnsok) {
+	if (!family->netnsok)
 		genlmsg_multicast_netns(&genl_ctrl, &init_net, msg, 0,
 					0, GFP_KERNEL);
-	} else {
-		rcu_read_lock();
-		genlmsg_multicast_allns(&genl_ctrl, msg, 0,
-					0, GFP_ATOMIC);
-		rcu_read_unlock();
-	}
+	else
+		genlmsg_multicast_allns(&genl_ctrl, msg, 0, 0);
 
 	return 0;
 }
@@ -1093,23 +1089,23 @@ struct nlattr **genl_family_attrbuf(const struct genl_family *family)
 }
 EXPORT_SYMBOL(genl_family_attrbuf);
 
-static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group,
-			 gfp_t flags)
+static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group)
 {
 	struct sk_buff *tmp;
 	struct net *net, *prev = NULL;
 	bool delivered = false;
 	int err;
 
+	rcu_read_lock();
 	for_each_net_rcu(net) {
 		if (prev) {
-			tmp = skb_clone(skb, flags);
+			tmp = skb_clone(skb, GFP_ATOMIC);
 			if (!tmp) {
 				err = -ENOMEM;
 				goto error;
 			}
 			err = nlmsg_multicast(prev->genl_sock, tmp,
-					      portid, group, flags);
+					      portid, group, GFP_ATOMIC);
 			if (!err)
 				delivered = true;
 			else if (err != -ESRCH)
@@ -1118,26 +1114,30 @@ static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group,
 
 		prev = net;
 	}
+	err = nlmsg_multicast(prev->genl_sock, skb, portid, group, GFP_ATOMIC);
+
+	rcu_read_unlock();
 
-	err = nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
 	if (!err)
 		delivered = true;
 	else if (err != -ESRCH)
 		return err;
 	return delivered ? 0 : -ESRCH;
  error:
+	rcu_read_unlock();
+
 	kfree_skb(skb);
 	return err;
 }
 
 int genlmsg_multicast_allns(const struct genl_family *family,
 			    struct sk_buff *skb, u32 portid,
-			    unsigned int group, gfp_t flags)
+			    unsigned int group)
 {
 	if (WARN_ON_ONCE(group >= family->n_mcgrps))
 		return -EINVAL;
 	group = family->mcgrp_offset + group;
-	return genlmsg_mcast(skb, portid, group, flags);
+	return genlmsg_mcast(skb, portid, group);
 }
 EXPORT_SYMBOL(genlmsg_multicast_allns);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 77edb69384637..a27b2fae4843f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15072,10 +15072,8 @@ void nl80211_common_reg_change_event(enum nl80211_commands cmd_id,
 
 	genlmsg_end(msg, hdr);
 
-	rcu_read_lock();
 	genlmsg_multicast_allns(&nl80211_fam, msg, 0,
-				NL80211_MCGRP_REGULATORY, GFP_ATOMIC);
-	rcu_read_unlock();
+				NL80211_MCGRP_REGULATORY);
 
 	return;
 
@@ -15574,10 +15572,8 @@ void nl80211_send_beacon_hint_event(struct wiphy *wiphy,
 
 	genlmsg_end(msg, hdr);
 
-	rcu_read_lock();
 	genlmsg_multicast_allns(&nl80211_fam, msg, 0,
-				NL80211_MCGRP_REGULATORY, GFP_ATOMIC);
-	rcu_read_unlock();
+				NL80211_MCGRP_REGULATORY);
 
 	return;
 
-- 
2.43.0




