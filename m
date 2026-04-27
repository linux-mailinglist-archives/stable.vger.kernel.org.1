Return-Path: <stable+bounces-241426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF4qJ66w72lyDwEAu9opvQ
	(envelope-from <stable+bounces-241426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:53:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B9D478E31
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 776A93032768
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E579A3DD50D;
	Mon, 27 Apr 2026 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbyFcgpi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745CB374E5C
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315351; cv=none; b=Sc+GK6xbBw6irLFh4/3fZrAAw+ZFJYCx1Apb6afVSDUHOsbQEEp36lhudaytjJxijFcqDFZSC8av8Nf/k1c5377Va0oA9vZBEAyI8qGV7lLnP17tYJAdXlH3O00REyrl2QzYWZAXCj0qvkOvQqA61bcj0b/ycvD2djYQl/NWNd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315351; c=relaxed/simple;
	bh=actksT4NaVdiDhbrhr1NLH2otkKCkCvm7EX9dDXdYQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QehGVFJTAq5hK/kqWB+oBEMmJsQ+eXGUkE88eRwGFwvcgnvE0nK9v7gztXJEdBcoq+q86DR5ykFqNHab1PE+clg4RHbh/Ld5aeSpExChQm+TXM5x0xIvroSvEz1xI1vLzIGg/AnVFo9iLwfGDzIxJY9bE+Z5vMUIbGVCNox8FTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vbyFcgpi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b7c904d476so30350315ad.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 11:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777315350; x=1777920150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nj4pMSUxKdRVNvNsZW/wYJhKiPsTcAtnwl8ZtC3mHZw=;
        b=vbyFcgpiEdP5oCDVfSvZn80xQVbcQNtdLMxCdB1GI24CuuzTYZPtQFoYmn5rhZPxBf
         2TudmCUcNW+V6uXyTd/Xpg+kCocBncInNEHXoXZO0/RYn3Fdep5qgmvUbwgGMFiE/okt
         Sr1GMvvJRllDLvVbABGZOAcRT2iwavc0DV3ijGaUDzGlzKNM4cBHLPT+FePF0RBFx2jL
         vF6Xhwg49ACEdg+wtaQEx6ZA4aNunWjm8i9E2CjgoZeW8gSpOH22cLAqiPkDPZQIOgk8
         8dmFZFG6aEnwu5HMP7/PRy0V9BkvE/m8tH9xn69cPSeELpCMqhpfgZzRaXeXsVxqiSg+
         btgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777315350; x=1777920150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nj4pMSUxKdRVNvNsZW/wYJhKiPsTcAtnwl8ZtC3mHZw=;
        b=nKAuhnaBGPa90k8AOui4H+8rzbHWnZILfuQtsG5VgEh7apUapUZWl5QUAdE9giqGy3
         5MrtZtVVyqX+TC/vtbbfJNim2ss9Yoh8+DAFuVohbeEsG7GMGLjD2o8Y1M4JxrzaQI3r
         rR+aZkJm5kXp4ioVg0NhdB/riaz8iSvE1bd/LaFUbBnHYFmKlo+Pn2DZnGtaM3G87xjT
         6m5bEsRSH9erD8KmAZxROM3+Rm1yMOEHIvPQlxAdU38fEhZAV1Xazy4XYzWx/9AcHolO
         A4QomXuopDBJFoPYH/A7zaaX3yn0I1wi3QRb6brY363ruSgjmyCmVWtF28GHzi9QsyoL
         j8iw==
X-Forwarded-Encrypted: i=1; AFNElJ/5fY+nWtTFyY9ikGyn7hGTizNu96+2Aty7qJY1ZtIMckBBN9jW8cKofFX3jh5nxcE4KuFQlgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHIYincqjEWYkbfd+dnUCfrjgFmCAqu11vjqfWkYvv+X+6eg9
	o3CyQgOyjmiwqWMXYkkRizuxlJgQ6rj9rmNRVIV48N5FcjlNFIQDZt6uHYNX4R548o/t+QpSE0V
	QAMpcklhVaA==
X-Received: from plps18.prod.google.com ([2002:a17:902:9892:b0:2b0:4f1c:be29])
 (user=kpberry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ab8b:b0:2b0:7e4d:f43f
 with SMTP id d9443c01a7336-2b97a97167bmr2415125ad.41.1777315349604; Mon, 27
 Apr 2026 11:42:29 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:42:07 +0000
In-Reply-To: <20260427184208.161981-1-kpberry@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAPpSM+SbRsFUd9jcP81K1VmhANhT7uzPqOPmy8i0gZ28ctjQKw@mail.gmail.com>
 <20260427184208.161981-1-kpberry@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427184208.161981-2-kpberry@google.com>
Subject: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
From: Kevin Berry <kpberry@google.com>
To: xmei5@asu.edu
Cc: bestswngs@gmail.com, chenglongtang@google.com, joneslee@google.com, 
	kpberry@google.com, pabeni@redhat.com, rnj@google.com, stable@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 00B9D478E31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-241426-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	R_DKIM_ALLOW(0.00)[google.com:s=20251104];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpberry@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	NEURAL_SPAM(0.00)[0.878];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,asu.edu:email]

From: Xiang Mei <xmei5@asu.edu>

[ Upstream commit 2884bf72fb8f03409e423397319205de48adca16 ]

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
---
 drivers/net/bonding/bond_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5035cfa74f1a..20043f1094df 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5322,18 +5322,22 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
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

base-commit: eefc95626b5cb02ea6268d1ae58237768004a60d
-- 
2.54.0.545.g6539524ca2-goog


