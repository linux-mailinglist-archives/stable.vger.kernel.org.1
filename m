Return-Path: <stable+bounces-251525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL7IL9P1DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:56:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 66051594F2B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 268693078DE2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05573644CB;
	Wed, 20 May 2026 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FwLIl8eA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581E3A381D
	for <stable@vger.kernel.org>; Wed, 20 May 2026 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298206; cv=none; b=TNubhGcyZERLXaXM7jg0LPmTZ0A/XMDdlYYXrMI+IPFyBbEDSDV6ZZn/7wagxxq67oW6V0r3Wx1iriBgmZTRBvgnP4qG3tTwZwo1PQfz06uu3llf+eV15qb3zdhFx+gGbZSUZEb4iutrRyGQd0BxD8sO5qVF2Bulv2LPH3Y3g4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298206; c=relaxed/simple;
	bh=m1qbv6mF9RhZ6Or0RiOGiZvRAZrGbFxjgat4eiSIBh8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PUKOi0szVgtnbMH8MF7HpFE1QifFlrYvoORrQ3RIY5F4ZqqfPIuGZI6gtaK28GHHAoq7/3KkCC0cHh2taPI0Y3gevVczWh/+cTxzuAwPijk9nAuSkOg5X0nz2t0tBtgHhSmIpvWTipqSqZC1aCIg8wXVYzIKYQr+qdBoqrLNOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FwLIl8eA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3692f395339so5070874a91.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779298204; x=1779903004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3V7RUnZHB/rTyjhH2xTvr24MsEKS6M+dSewO19ouvl8=;
        b=FwLIl8eACwuMvZ5FmwRfrQuxohzBt77wtB7avSrVyxMXp/D85MJEgpa5wMexT39FZo
         k7V4juKha9UAceB0kh+cGG8wmNv2BfdgA5wYMb1dTMa+rCu0bivBPf4TSC2GaFl93pjj
         B+0afvc72K9IzspEsYVSqiNLtU0DOWc8n1/0qXiLDM2x0Ac62lV6VWqw+euN1YznEnmm
         w8LLCa0vrvOEydKYY8e2UjVZElg44SpxbH5Em6N2vKvfd2IQQbmpwMfhemj+qGGZ3I+7
         6aKa6eOzVI0Hmk+DYXe6vBCsMAac3X6679u/nscNL56mJAaMIKD3HbMdl+TkrriWYoN5
         c7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779298204; x=1779903004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3V7RUnZHB/rTyjhH2xTvr24MsEKS6M+dSewO19ouvl8=;
        b=k5AEUtuuRiAPmB1WDxJAkK22Bh5+WIv8gVsGaXqTkjWi+0BN9HSxU2wlOt0YcSu6pB
         /t434exGmMECEzrVO5d1uWM06+gYgDxQC0l5QLWIz6HABg5qRsFzDO6AWEHOUkHWciZr
         Uflz4gCWnzpQobSxBZgQQ2eep15/zBTCIrbG44Ne+VT3xkT3nIgqcBiQKk3LaY/0kTEE
         5E0Q7Gy83769InBGbzXEdLG+PjHUZCfabe9fe1wGBcFFrWdjtqIVtof2A0tAlXKpREhJ
         pi9z2fNZEGtxCim/YqGZxiA9opuEcRppicUuBGVrdA74DbuU9FBXTceCWdrRNE8gc2ot
         wFxA==
X-Forwarded-Encrypted: i=1; AFNElJ8Vh+pDX4FEQATqRoPoeq/NphRiqqoHKN6aJpdhfSXEjXkIzKZVoNk1ew1LZyMSrP8Yl7Uixdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW6ZfMKnJXVZep8eCosAlnMTsy33h1ZdMzPfiW7EHBPsEHhhVP
	CD4oKrsvhYmi5sPLpxy1PcmDqZBwk+pNj8Em3wOPJbL/mlu4DE6V/wS4Az28MXjMjK7UigmJ0fG
	etbthdv6zJQ==
X-Received: from pge13.prod.google.com ([2002:a05:6a02:2d0d:b0:c76:6cef:34e7])
 (user=kpberry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7284:b0:39b:fbb2:5e46
 with SMTP id adf61e73a8af0-3b22ec589fbmr28304688637.40.1779298204118; Wed, 20
 May 2026 10:30:04 -0700 (PDT)
Date: Wed, 20 May 2026 17:29:51 +0000
In-Reply-To: <2026052009-vexingly-chokehold-f8f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026052009-vexingly-chokehold-f8f7@gregkh>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260520172951.3087955-1-kpberry@google.com>
Subject: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
From: Kevin Berry <kpberry@google.com>
To: gregkh@linuxfoundation.org
Cc: bestswngs@gmail.com, chenglongtang@google.com, joneslee@google.com, 
	kpberry@google.com, pabeni@redhat.com, rnj@google.com, sashal@kernel.org, 
	stable@vger.kernel.org, xmei5@asu.edu
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,kernel.org,vger.kernel.org,asu.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251525-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpberry@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,asu.edu:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 66051594F2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xiang Mei <xmei5@asu.edu>

commit 2884bf72fb8f03409e423397319205de48adca16 upstream.

bond_xmit_broadcast() reuses the original skb for the last slave
(determined by bond_is_last_slave()) and clones it for others.
Concurrent slave enslave/release can mutate the slave list during
RCU-protected iteration, changing which slave is "last" mid-loop.
This causes the original skb to be double-consumed (double-freed).

Replace the racy bond_is_last_slave() check with a simple index
comparison (i + 1 == slaves_count) against the pre-snapshot slave
count taken via READ_ONCE() before the loop.  This preserves the
zero-copy optimization for the last slave while making the "last"
determination stable against concurrent list mutations.

The UAF can trigger the following crash:

==================================================================
BUG: KASAN: slab-use-after-free in skb_clone
Read of size 8 at addr ffff888100ef8d40 by task exploit/147

CPU: 1 UID: 0 PID: 147 Comm: exploit Not tainted 7.0.0-rc3+ #4 PREEMPTLAZY
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:123)
 print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
 kasan_report (mm/kasan/report.c:597)
 skb_clone (include/linux/skbuff.h:1724 include/linux/skbuff.h:1792 include/linux/skbuff.h:3396 net/core/skbuff.c:2108)
 bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5334)
 bond_start_xmit (drivers/net/bonding/bond_main.c:5567 drivers/net/bonding/bond_main.c:5593)
 dev_hard_start_xmit (include/linux/netdevice.h:5325 include/linux/netdevice.h:5334 net/core/dev.c:3871 net/core/dev.c:3887)
 __dev_queue_xmit (include/linux/netdevice.h:3601 net/core/dev.c:4838)
 ip6_finish_output2 (include/net/neighbour.h:540 include/net/neighbour.h:554 net/ipv6/ip6_output.c:136)
 ip6_finish_output (net/ipv6/ip6_output.c:208 net/ipv6/ip6_output.c:219)
 ip6_output (net/ipv6/ip6_output.c:250)
 ip6_send_skb (net/ipv6/ip6_output.c:1985)
 udp_v6_send_skb (net/ipv6/udp.c:1442)
 udpv6_sendmsg (net/ipv6/udp.c:1733)
 __sys_sendto (net/socket.c:730 net/socket.c:742 net/socket.c:2206)
 __x64_sys_sendto (net/socket.c:2209)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
 </TASK>

Allocated by task 147:

Freed by task 147:

The buggy address belongs to the object at ffff888100ef8c80
 which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 192 bytes inside of
 freed 224-byte region [ffff888100ef8c80, ffff888100ef8d60)

Memory state around the buggy address:
 ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                                    ^
 ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return value error bug")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Link: https://patch.msgid.link/20260326075553.3960562-1-xmei5@asu.edu
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Kevin Berry <kpberry@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 114ebaa284da..6484ba1ab14c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5280,18 +5280,22 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 				       struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
-	struct slave *slave = NULL;
-	struct list_head *iter;
+	struct bond_up_slave *slaves;
 	bool xmit_suc = false;
 	bool skb_used = false;
+	int slaves_count, i;
 
-	bond_for_each_slave_rcu(bond, slave, iter) {
+	slaves = rcu_dereference(bond->all_slaves);
+
+	slaves_count = slaves ? READ_ONCE(slaves->count) : 0;
+	for (i = 0; i < slaves_count; i++) {
+		struct slave *slave = slaves->arr[i];
 		struct sk_buff *skb2;
 
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (bond_is_last_slave(bond, slave)) {
+		if (i + 1 == slaves_count) {
 			skb2 = skb;
 			skb_used = true;
 		} else {

base-commit: 258cf62a6dfde3c6a39d120a56a298f2ed6a8901
-- 
2.54.0.563.g4f69b47b94-goog


