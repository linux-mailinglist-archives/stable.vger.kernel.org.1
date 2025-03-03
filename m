Return-Path: <stable+bounces-120174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15992A4C9EB
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 18:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508E03B9B37
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B062505DA;
	Mon,  3 Mar 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr+Ay+4t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F092505BD;
	Mon,  3 Mar 2025 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021839; cv=none; b=d+8ogOv0wUbrFmsVbtPYzpd6swsFXEHcK4YrXMqwlyESZHNa7NkIGThGFJBsQno9CljPsQorogHbmYXkHbVa0aEL3FEbjJRjOFOc6ulpJB9AKyC8+vQGiGes6NkD5QP9Ly9MKJA+Pcejoc9mWnrTFP8mJRxXuaJRMH35fT7CZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021839; c=relaxed/simple;
	bh=0Ma6qtuWXoQR5mDUqmgzEioSTKwb9JabDAkmPqXbGro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tkSSn4D1ALupOitXZ7JAAIruWzIx1dx2r2JToIdqxgWeYFuXmIBiMS1SqGqr7pDxwPEdlYmCmzKQf3DV9Lv0xDx/BODZ6eB3jfG6AG1vQ6aMlWOj1OGqRqY3LHbtL6h9pnF6wJKzgQ6UPAZ91gBM6EzzLURmB/xeERcvhicFF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr+Ay+4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38184C4CEE9;
	Mon,  3 Mar 2025 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741021838;
	bh=0Ma6qtuWXoQR5mDUqmgzEioSTKwb9JabDAkmPqXbGro=;
	h=From:Date:Subject:To:Cc:From;
	b=lr+Ay+4tZ+db/l321NhdYmN/Bx44rkHv2eW+ZdMUE9rFVejQ7O5tx6Qm1+b509JuA
	 tpTOcdJqQf+2YfAZpDK0dWdpx2rpwIV42LYR0AvVT6qz+PvUs4459aAuFnHeLMoakd
	 ZGOLCeSVStuibTH8OXBXiurlxWCz6w1od1+8om+L0vIA+c5ja21kKaqzAG1EIhOEUh
	 k/8M7uXCZHjsDbfKZOnbc6QQD2mnyVkJQORcRNIhp4upb99pGtkYL1wC3LgwoPSGb0
	 FDK/K+rc5Tdsn/ZosaBhO3M3IsJA6FqMguJ5oTeawsXVjhI2NigE9zNUnh0tsdd7ur
	 5F5JcwOzrb0iw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 03 Mar 2025 18:10:13 +0100
Subject: [PATCH net] mptcp: fix 'scheduling while atomic' in
 mptcp_pm_nl_append_new_local_addr
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-net-mptcp-fix-sched-while-atomic-v1-1-f6a216c5a74c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHTixWcC/x2NQQqDMBBFryKz7kAaEaxXKV0kk7EZ0BiSoIJ49
 w5dPvjvvwsqF+EKU3dB4V2qbEnh+eiAoktfRgnKYI0dTG96TNxwzY0yznJipcgBjygLo2vbKoT
 ENDpv/cuPAfQmF9blP/EGteFz3z/daplxdwAAAA==
X-Change-ID: 20250303-net-mptcp-fix-sched-while-atomic-cec8ab2b9b8d
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krister Johansen <kjlx@templeofstupid.com>, stable@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6168; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rI+xTjW/4Di7bik1jLTrX+13V8FWkx3oKnm1qjlifLk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnxeKK0U7l7IEBnfq70QSMPIDEPTqChfSHmENaY
 Wmwj+lJbz6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8XiigAKCRD2t4JPQmmg
 c8OsEADKOrBAMJdg2+WjVltI89o6n7LuiBcXel5yfXK1OHWldplLTPAu5+mhDblqqhL7ayb/5A7
 BRj0wwJ3Fa79iMk931xbmQ+rnKRBIIfOexNlgvxjkj8If6ofZueI6WPBthi41y5vQGCfoA/JmX3
 1ET7nvS1SyEECNU+oLMpEVoWOEqR8+iebbWa65elJf/G9/1p59QExvg1KiF5K2YByd/uHV9NkWo
 r1Ebx2CDRFbhoCY2QQB1wu1352LWIA8K76faHkk+3orIt09TFCnYOTeZdTdLgr1d6joTNTEITgC
 r12PwQoxXTTKnR60C7rJkGm20V8fhP4vLstdMDgozyHlBX/BFwQIdxAsQuj9SfAQGDM/qtUj1Ky
 nQwkaIRwp1zEYMLTq4+6VxYobOfC2e0Xmt/g5qKM/zt7vyBD4bedv8X/VioXi0EekrMWZVlTrYO
 QBS5Id9AbY95+34TEpFEUBRyZdavEYZUyH96MoIdtf97x6iSk4DbBhCFXd7x5mHA0IbioCMNkfr
 gNbheQ3vEGW6V/4NRNRQpnKuOAmvyR37TlyQjkxFYRj7XYSY4c/88Gr39h1ygg3+TClD8n/mRgA
 0NgNsXmWFHFBnFP2kM38V6Smkn0G0oe24gZaisgSDMTuM+FyxtaS/zRu1g+P4JTbYz8bAxaD309
 0dliG6NJCcXSvYg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Krister Johansen <kjlx@templeofstupid.com>

If multiple connection requests attempt to create an implicit mptcp
endpoint in parallel, more than one caller may end up in
mptcp_pm_nl_append_new_local_addr because none found the address in
local_addr_list during their call to mptcp_pm_nl_get_local_id.  In this
case, the concurrent new_local_addr calls may delete the address entry
created by the previous caller.  These deletes use synchronize_rcu, but
this is not permitted in some of the contexts where this function may be
called.  During packet recv, the caller may be in a rcu read critical
section and have preemption disabled.

An example stack:

   BUG: scheduling while atomic: swapper/2/0/0x00000302

   Call Trace:
   <IRQ>
   dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1))
   dump_stack (lib/dump_stack.c:124)
   __schedule_bug (kernel/sched/core.c:5943)
   schedule_debug.constprop.0 (arch/x86/include/asm/preempt.h:33 kernel/sched/core.c:5970)
   __schedule (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 kernel/sched/features.h:29 kernel/sched/core.c:6621)
   schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6804 kernel/sched/core.c:6818)
   schedule_timeout (kernel/time/timer.c:2160)
   wait_for_completion (kernel/sched/completion.c:96 kernel/sched/completion.c:116 kernel/sched/completion.c:127 kernel/sched/completion.c:148)
   __wait_rcu_gp (include/linux/rcupdate.h:311 kernel/rcu/update.c:444)
   synchronize_rcu (kernel/rcu/tree.c:3609)
   mptcp_pm_nl_append_new_local_addr (net/mptcp/pm_netlink.c:966 net/mptcp/pm_netlink.c:1061)
   mptcp_pm_nl_get_local_id (net/mptcp/pm_netlink.c:1164)
   mptcp_pm_get_local_id (net/mptcp/pm.c:420)
   subflow_check_req (net/mptcp/subflow.c:98 net/mptcp/subflow.c:213)
   subflow_v4_route_req (net/mptcp/subflow.c:305)
   tcp_conn_request (net/ipv4/tcp_input.c:7216)
   subflow_v4_conn_request (net/mptcp/subflow.c:651)
   tcp_rcv_state_process (net/ipv4/tcp_input.c:6709)
   tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1934)
   tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2334)
   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205 (discriminator 1))
   ip_local_deliver_finish (include/linux/rcupdate.h:813 net/ipv4/ip_input.c:234)
   ip_local_deliver (include/linux/netfilter.h:314 include/linux/netfilter.h:308 net/ipv4/ip_input.c:254)
   ip_sublist_rcv_finish (include/net/dst.h:461 net/ipv4/ip_input.c:580)
   ip_sublist_rcv (net/ipv4/ip_input.c:640)
   ip_list_rcv (net/ipv4/ip_input.c:675)
   __netif_receive_skb_list_core (net/core/dev.c:5583 net/core/dev.c:5631)
   netif_receive_skb_list_internal (net/core/dev.c:5685 net/core/dev.c:5774)
   napi_complete_done (include/linux/list.h:37 include/net/gro.h:449 include/net/gro.h:444 net/core/dev.c:6114)
   igb_poll (drivers/net/ethernet/intel/igb/igb_main.c:8244) igb
   __napi_poll (net/core/dev.c:6582)
   net_rx_action (net/core/dev.c:6653 net/core/dev.c:6787)
   handle_softirqs (kernel/softirq.c:553)
   __irq_exit_rcu (kernel/softirq.c:588 kernel/softirq.c:427 kernel/softirq.c:636)
   irq_exit_rcu (kernel/softirq.c:651)
   common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
   </IRQ>

This problem seems particularly prevalent if the user advertises an
endpoint that has a different external vs internal address.  In the case
where the external address is advertised and multiple connections
already exist, multiple subflow SYNs arrive in parallel which tends to
trigger the race during creation of the first local_addr_list entries
which have the internal address instead.

Fix by skipping the replacement of an existing implicit local address if
called via mptcp_pm_nl_get_local_id.

Fixes: d045b9eb95a9 ("mptcp: introduce implicit endpoints")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c0e47f4f7b1aa2fedf615c44ea595c1f9d2528f9..7868207c4e9d9d7d4855ca3fadc02506637708ba 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -977,7 +977,7 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry,
-					     bool needs_id)
+					     bool needs_id, bool replace)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -1017,6 +1017,17 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 			if (entry->addr.id)
 				goto out;
 
+			/* allow callers that only need to look up the local
+			 * addr's id to skip replacement. This allows them to
+			 * avoid calling synchronize_rcu in the packet recv
+			 * path.
+			 */
+			if (!replace) {
+				kfree(entry);
+				ret = cur->addr.id;
+				goto out;
+			}
+
 			pernet->addrs--;
 			entry->addr.id = cur->addr.id;
 			list_del_rcu(&cur->list);
@@ -1165,7 +1176,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1433,7 +1444,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
-						!mptcp_pm_has_addr_attr_id(attr, info));
+						!mptcp_pm_has_addr_attr_id(attr, info),
+						true);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;

---
base-commit: 64e6a754d33d31aa844b3ee66fb93ac84ca1565e
change-id: 20250303-net-mptcp-fix-sched-while-atomic-cec8ab2b9b8d

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


