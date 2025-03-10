Return-Path: <stable+bounces-121782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4629EA59C46
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E632D188B710
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDED1231A24;
	Mon, 10 Mar 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I8IOP9Od"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B945230D0F;
	Mon, 10 Mar 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626613; cv=none; b=UVOdqnXxTlu/VDFqjA8LwY0BUO8tKMnEfH7Kq6TWHnP6CawvrHtQTOta6PSYGMRFATwQ7LC9S9a3SR+iRK7ZogHM+lrzTLfV84OtjedfphKyFjHLOJPwiM0by0EP52YNQO+Uu+g5ZQY85A3DLPFB7/hL3DAfj8+L2aYUX8nk864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626613; c=relaxed/simple;
	bh=4J3uQLaaAg3lAtW8HdF71mSwxFVrxtmZCdzdWSUzPhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8OMUwPuSxAfr19ruZytSE+cRsP2X8QZxaey57J8Zx3glomjMmbRlWUJ/4GPWRf3hdQ4XWROcAQTYhV9YXNGpYJZ3keZwtFUXwff6+gdRPBEXTrWfDCfxaQEVpWYmlf52vCUHjJFKtQ4XhXRQjQUrvfOmXIYZbmQay5uSECMbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I8IOP9Od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A33C4CEE5;
	Mon, 10 Mar 2025 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626613;
	bh=4J3uQLaaAg3lAtW8HdF71mSwxFVrxtmZCdzdWSUzPhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I8IOP9Odfxbie9T9qj+aQhgcikG8LHYCDnKpnOInVHtS/ZrK3rEmr0c6TRxvXXq35
	 CA+ogws7Tc7EUk9OUm6+xwvK5eO+mnW/rS4ejKFTmVVe7fiUHIi3A2d+5bn9Zpt1gs
	 GZp64UtUckuZFAbpHiC1R7eZuRDuMBAn6DBBO9rs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Krister Johansen <kjlx@templeofstupid.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.13 053/207] mptcp: fix scheduling while atomic in mptcp_pm_nl_append_new_local_addr
Date: Mon, 10 Mar 2025 18:04:06 +0100
Message-ID: <20250310170449.879348768@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krister Johansen <kjlx@templeofstupid.com>

commit 022bfe24aad8937705704ff2e414b100cf0f2e1a upstream.

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
Link: https://patch.msgid.link/20250303-net-mptcp-fix-sched-while-atomic-v1-1-f6a216c5a74c@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -977,7 +977,7 @@ static void __mptcp_pm_release_addr_entr
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry,
-					     bool needs_id)
+					     bool needs_id, bool replace)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -1017,6 +1017,17 @@ static int mptcp_pm_nl_append_new_local_
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
@@ -1165,7 +1176,7 @@ int mptcp_pm_nl_get_local_id(struct mptc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1433,7 +1444,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_
 		}
 	}
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
-						!mptcp_pm_has_addr_attr_id(attr, info));
+						!mptcp_pm_has_addr_attr_id(attr, info),
+						true);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;



