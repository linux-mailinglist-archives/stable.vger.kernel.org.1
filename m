Return-Path: <stable+bounces-88781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32569B2777
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5831F24865
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEF518E05D;
	Mon, 28 Oct 2024 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eOU4Qpfu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953382AF07;
	Mon, 28 Oct 2024 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098108; cv=none; b=N7bH7/zIbjxKXF7mIlfIskpuZ89FthMoJtpcCFHH/x27SwavuR5anAeV35KtS6JmADf1gOY33ofMx2jLA3qla1wVOh4F4/tN19z1O646Bf9bqR+9w5yF4AtUSHryIikbJFTYYl8+su1Iekq8rkdX4F0UgZBzJMqvFEeb4CYqv3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098108; c=relaxed/simple;
	bh=OS0xlP7lsTsd5luk6CdZVCrfKf4GexVqSuvGoT7heU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cz3cYx+TsyVvktyF/77FygW5rBcZSjDqBRN6jQxCfxld7eU/CpDogboSWSKQcYbJcHI2JU/dja7JUQIP/poY2zINrL+8XDc5birTshUVYC11lp8WA2wl/qxdpavqN/l90odutHCOy1oxmUiAp/7KIWEog/0Jo/k+Qr72oXQx84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eOU4Qpfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F66C4CEC3;
	Mon, 28 Oct 2024 06:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098108;
	bh=OS0xlP7lsTsd5luk6CdZVCrfKf4GexVqSuvGoT7heU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eOU4QpfuRzhrWTohnS3J69PMxLIX7u3Q4iPog+wS+4rTwsUweTaQjGJ8zkk5MmjB6
	 gJNojU9Z/P1Eb6TLKW6FwCDQ/+hn7fNvNE6T1CzugMM8Ekf9GFIlu8AjjP9s+CrRoM
	 9sU5FmEGsSYlFIAx53aJvea/d1c5pBI/+3YXKPPc=
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
Subject: [PATCH 6.11 080/261] genetlink: hold RCU in genlmsg_mcast()
Date: Mon, 28 Oct 2024 07:23:42 +0100
Message-ID: <20241028062314.034665617@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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
index 7eb94894bd68f..717931267bda0 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -2130,7 +2130,7 @@ static int tcmu_netlink_event_send(struct tcmu_dev *udev,
 	}
 
 	ret = genlmsg_multicast_allns(&tcmu_genl_family, skb, 0,
-				      TCMU_MCGRP_CONFIG, GFP_KERNEL);
+				      TCMU_MCGRP_CONFIG);
 
 	/* Wait during an add as the listener may not be up yet */
 	if (ret == 0 ||
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 9ab49bfeae789..c1d91f1d20f6c 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -531,13 +531,12 @@ static inline int genlmsg_multicast(const struct genl_family *family,
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
index fc43ecbd128cc..28e77a222a39b 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -116,7 +116,7 @@ static int l2tp_tunnel_notify(struct genl_family *family,
 				  NLM_F_ACK, tunnel, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0, GFP_ATOMIC);
+		ret = genlmsg_multicast_allns(family, msg, 0, 0);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
@@ -144,7 +144,7 @@ static int l2tp_session_notify(struct genl_family *family,
 				   NLM_F_ACK, session, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0, GFP_ATOMIC);
+		ret = genlmsg_multicast_allns(family, msg, 0, 0);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index feb54c63a1165..07ad65774fe29 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1501,15 +1501,11 @@ static int genl_ctrl_event(int event, const struct genl_family *family,
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
@@ -1929,23 +1925,23 @@ static int __init genl_init(void)
 
 core_initcall(genl_init);
 
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
@@ -1954,27 +1950,31 @@ static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group,
 
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
index f18e1716339e0..3766efacfd64f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17967,10 +17967,8 @@ void nl80211_common_reg_change_event(enum nl80211_commands cmd_id,
 
 	genlmsg_end(msg, hdr);
 
-	rcu_read_lock();
 	genlmsg_multicast_allns(&nl80211_fam, msg, 0,
-				NL80211_MCGRP_REGULATORY, GFP_ATOMIC);
-	rcu_read_unlock();
+				NL80211_MCGRP_REGULATORY);
 
 	return;
 
@@ -18703,10 +18701,8 @@ void nl80211_send_beacon_hint_event(struct wiphy *wiphy,
 
 	genlmsg_end(msg, hdr);
 
-	rcu_read_lock();
 	genlmsg_multicast_allns(&nl80211_fam, msg, 0,
-				NL80211_MCGRP_REGULATORY, GFP_ATOMIC);
-	rcu_read_unlock();
+				NL80211_MCGRP_REGULATORY);
 
 	return;
 
-- 
2.43.0




