Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B215C72C027
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjFLKub (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbjFLKtt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5066195
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C5B8623E8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502FDC433D2;
        Mon, 12 Jun 2023 10:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566072;
        bh=Hi1gcnckmzJJ3mBYt6M/GKNWQUtbnGO2vnlJgpn9Ly8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=142x9QQf3xpzt0XPWXExdlM1Gtoo49w8cbJZtMu4STytM2ohGOhq/V3x4kV49Ua12
         B1XeVyDdbxsMJwmzKaj9HY83Hm62Fo0W7BB2HFGxdK95svijwXDc7yt4PtX9U45mR0
         qFSTAvZCweqTZ61MR5vxLaVPe/toGtwd7sqJwiHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzkaller <syzkaller@googlegroups.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 24/68] netfilter: ipset: Add schedule point in call_ad().
Date:   Mon, 12 Jun 2023 12:26:16 +0200
Message-ID: <20230612101659.433546076@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 24e227896bbf003165e006732dccb3516f87f88e ]

syzkaller found a repro that causes Hung Task [0] with ipset.  The repro
first creates an ipset and then tries to delete a large number of IPs
from the ipset concurrently:

  IPSET_ATTR_IPADDR_IPV4 : 172.20.20.187
  IPSET_ATTR_CIDR        : 2

The first deleting thread hogs a CPU with nfnl_lock(NFNL_SUBSYS_IPSET)
held, and other threads wait for it to be released.

Previously, the same issue existed in set->variant->uadt() that could run
so long under ip_set_lock(set).  Commit 5e29dc36bd5e ("netfilter: ipset:
Rework long task execution when adding/deleting entries") tried to fix it,
but the issue still exists in the caller with another mutex.

While adding/deleting many IPs, we should release the CPU periodically to
prevent someone from abusing ipset to hang the system.

Note we need to increment the ipset's refcnt to prevent the ipset from
being destroyed while rescheduling.

[0]:
INFO: task syz-executor174:268 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc1-00145-gba79e9a73284 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor174 state:D stack:0     pid:268   ppid:260    flags:0x0000000d
Call trace:
 __switch_to+0x308/0x714 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xd84/0x1648 kernel/sched/core.c:6669
 schedule+0xf0/0x214 kernel/sched/core.c:6745
 schedule_preempt_disabled+0x58/0xf0 kernel/sched/core.c:6804
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x6fc/0xdb0 kernel/locking/mutex.c:747
 __mutex_lock_slowpath+0x14/0x20 kernel/locking/mutex.c:1035
 mutex_lock+0x98/0xf0 kernel/locking/mutex.c:286
 nfnl_lock net/netfilter/nfnetlink.c:98 [inline]
 nfnetlink_rcv_msg+0x480/0x70c net/netfilter/nfnetlink.c:295
 netlink_rcv_skb+0x1c0/0x350 net/netlink/af_netlink.c:2546
 nfnetlink_rcv+0x18c/0x199c net/netfilter/nfnetlink.c:658
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x664/0x8cc net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x6d0/0xa4c net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg net/socket.c:747 [inline]
 ____sys_sendmsg+0x4b8/0x810 net/socket.c:2503
 ___sys_sendmsg net/socket.c:2557 [inline]
 __sys_sendmsg+0x1f8/0x2a4 net/socket.c:2586
 __do_sys_sendmsg net/socket.c:2595 [inline]
 __se_sys_sendmsg net/socket.c:2593 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2593
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x84/0x270 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x134/0x24c arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x2c/0x7c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

Reported-by: syzkaller <syzkaller@googlegroups.com>
Fixes: a7b4f989a629 ("netfilter: ipset: IP set core support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 1bf6ab83644b3..55ac0cc12657c 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1704,6 +1704,14 @@ call_ad(struct sock *ctnl, struct sk_buff *skb, struct ip_set *set,
 	bool eexist = flags & IPSET_FLAG_EXIST, retried = false;
 
 	do {
+		if (retried) {
+			__ip_set_get(set);
+			nfnl_unlock(NFNL_SUBSYS_IPSET);
+			cond_resched();
+			nfnl_lock(NFNL_SUBSYS_IPSET);
+			__ip_set_put(set);
+		}
+
 		ip_set_lock(set);
 		ret = set->variant->uadt(set, tb, adt, &lineno, flags, retried);
 		ip_set_unlock(set);
-- 
2.39.2



