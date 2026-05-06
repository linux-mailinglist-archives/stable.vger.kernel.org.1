Return-Path: <stable+bounces-244447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJnXOqOk+2mvegMAu9opvQ
	(envelope-from <stable+bounces-244447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 22:29:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDE44E0301
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 22:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A0AC3008A6D
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681E037E2F9;
	Wed,  6 May 2026 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pht1O9V7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990137D138
	for <stable@vger.kernel.org>; Wed,  6 May 2026 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099338; cv=none; b=JO7d4o2GvomhboMlDNrkgf6H0gltom7kRdVwTvqYy0J1yeWi0eYDE2BqX3O+pgvHsNW0KdreFYHwbfmVS8eHhVcmS7RU+korrio5NczSY8oVH/sdfyhHz7p2gMUAQEvL7KlX2BbSrduUFVRckiHfaBXmuHq0H+niDyBPkW+Pe0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099338; c=relaxed/simple;
	bh=m1qbv6mF9RhZ6Or0RiOGiZvRAZrGbFxjgat4eiSIBh8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pivSl2hbQlfLyZhCEzTrUeHhBWBbCHz8MJQPvJPTL1xcav/WBXoPaTTEtLToDrZ7nBDGdd2OxVOFVytJwnAHesSMqtxnkwKjc4HGYTymVY3s6IiyuD2keCHiEqpx+MaitnVixM8EM7mbyGz2X7URK9EwAyx6WfFVEp9CzTQvjYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pht1O9V7; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c80b103360cso34456a12.3
        for <stable@vger.kernel.org>; Wed, 06 May 2026 13:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778099335; x=1778704135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3V7RUnZHB/rTyjhH2xTvr24MsEKS6M+dSewO19ouvl8=;
        b=Pht1O9V7UnBwTfIFph1+/WK9JQpPeCMlzYk8cxTWyz+/v/IO2NFSP04oIPQ4dZmLP5
         Elr8ANzyNTMLtucQHWe1ZmUp1ZG+BwG5mUBUZ0QIXLAfRMeElhn3AADZcJLi3wWlB13O
         BkJ0U1H7vpVZdmBrCqcsgSxw+bC4LmpOCZLNX50PpazFKMDczdBCQ92kp+3aTKkCszoD
         0KATsdLzTE80UIPR99WUUEx/FYVDAocMK/PW7LT2oHfa8L/UrYg6TwzrsHNf5D2cP7IS
         Xy6KayIkvu8Ksb6bY2u7k/GnVUT42EQxa2wubK7/xZOZByMftV0hNtcZOs0aD81NC+yS
         c5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778099335; x=1778704135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3V7RUnZHB/rTyjhH2xTvr24MsEKS6M+dSewO19ouvl8=;
        b=J/V5lKYZ3hHjkpQnm2UoNwSUwId0fn4LJPrjO837VztrFDhe1f/t8oVemXbBW6ZLe9
         cO+HpPM/EbzXKmvP/CBqaxM2YZ9O6JZ+2TXZaxm29eg/J55I9drNG28w6NUWh80Do6NO
         w3zr1gKj9NufiN59QwQQk0QczooATo80Zhy90/nMJTKSjn5pK4eazTiT9/VgBwn6RqOd
         k9XxC8Sm3TrABbStnCr4p7anGJWMNCuAv6AV6KvxrMCrVwJXZ5EfgkPkb4w1pHG/A01I
         TTNVoXFUSC5Lk23/caHIOpP0J491hu7FTrLU6zYHw9Z554n/WObqTTvLU9XX4eshgi/N
         ZYWg==
X-Forwarded-Encrypted: i=1; AFNElJ+7yoB0fnf4KDIAcdmnXy8onqP+6dnlyIA7rymMAmOkabYhtW6GoJpFams+pyWarzmh0dziis4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMZY7OCFHyh1s/qd/lfqo9TvnSdQIMQlaaHmiVrUY4+paV2cI7
	jzyP6NnvI8G+RW/1e0te1xu7+tvV9hJ2ma3o7STMQOoG3JibdcSm1UzV4ea0DXBQ8g0l/Ju8Pri
	FvwOQ+GpKDg==
X-Received: from pfblg1.prod.google.com ([2002:a05:6a00:7081:b0:835:4079:c7be])
 (user=kpberry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8b:b0:3a2:d68d:9e7e
 with SMTP id adf61e73a8af0-3aa5ab846dcmr5190871637.41.1778099334692; Wed, 06
 May 2026 13:28:54 -0700 (PDT)
Date: Wed,  6 May 2026 20:28:42 +0000
In-Reply-To: <20260506202842.1788682-1-kpberry@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAPpSM+TbMOPL93CkWtrYjYW+T+Q+iWuo+ZhfutYNFOuOCBU5fQ@mail.gmail.com>
 <20260506202842.1788682-1-kpberry@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260506202842.1788682-2-kpberry@google.com>
Subject: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
From: Kevin Berry <kpberry@google.com>
To: xmei5@asu.edu
Cc: bestswngs@gmail.com, chenglongtang@google.com, joneslee@google.com, 
	kpberry@google.com, pabeni@redhat.com, rnj@google.com, stable@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4FDE44E0301
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
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,vger.kernel.org,kernel.org,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-244447-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	R_DKIM_ALLOW(0.00)[google.com:s=20251104];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpberry@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.354];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


