Return-Path: <stable+bounces-92391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874199C53C6
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470E82814DC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198F2212F1C;
	Tue, 12 Nov 2024 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KAKLxId5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C030F2123CF;
	Tue, 12 Nov 2024 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407505; cv=none; b=ZogBXWt+2YpXbbWmJVl7KTDzxMU/uQFiGL5uXzdS5fq16YmYNstq8UcvapKVukCQxy/lQqW6jqo+0laMJ/GHE3idRofPFu3zjtkz89nfpX6iir1tFVyD6gVE9WnHA3BI3RyRytfiYaaJE33CfBtYAxsgRZCzyJvWdiDV6L7g2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407505; c=relaxed/simple;
	bh=yIOan99hEmQH7XU1To4Ffmz5CKXmZQxcX7J/WH+hZ+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRowGAGoT/1iVOWO5GRfd+crmS/hjkYY738mZuS64hn1nS49G1eKdtRBOwXxUkEvFHfj7z7pnMbHExpWOVNT1Tw+kS8WSbS/+b3NyIhHOdPH59ZH/ISWThfullPOfwEqs6C6EvwhI+EEaAY8Lu7wMzF/I9rPLJJ5Jy3Lsb8TsC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KAKLxId5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ECEC4CED4;
	Tue, 12 Nov 2024 10:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407505;
	bh=yIOan99hEmQH7XU1To4Ffmz5CKXmZQxcX7J/WH+hZ+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAKLxId5QI77W0jJdHIxQXBxfVgtn+GVm0Oa+XZkFA32nc0xEXSvDIagNQJQwgmeC
	 1CLrzYTIpdpfKASlnT0bn8QZYsE+i8C40fGfrTP0QAZZfRo54jnjGOGH2IAf3QewNt
	 LjQYJoi2ycQ7cMa1ySDbieNkq4mXGT0QncSi36kA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.1 95/98] net: sched: use RCU read-side critical section in taprio_dump()
Date: Tue, 12 Nov 2024 11:21:50 +0100
Message-ID: <20241112101847.862458877@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101844.263449965@linuxfoundation.org>
References: <20241112101844.263449965@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

commit b22db8b8befe90b61c98626ca1a2fbb0505e9fe3 upstream.

Fix possible use-after-free in 'taprio_dump()' by adding RCU
read-side critical section there. Never seen on x86 but
found on a KASAN-enabled arm64 system when investigating
https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa:

[T15862] BUG: KASAN: slab-use-after-free in taprio_dump+0xa0c/0xbb0
[T15862] Read of size 4 at addr ffff0000d4bb88f8 by task repro/15862
[T15862]
[T15862] CPU: 0 UID: 0 PID: 15862 Comm: repro Not tainted 6.11.0-rc1-00293-gdefaf1a2113a-dirty #2
[T15862] Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-20240524-5.fc40 05/24/2024
[T15862] Call trace:
[T15862]  dump_backtrace+0x20c/0x220
[T15862]  show_stack+0x2c/0x40
[T15862]  dump_stack_lvl+0xf8/0x174
[T15862]  print_report+0x170/0x4d8
[T15862]  kasan_report+0xb8/0x1d4
[T15862]  __asan_report_load4_noabort+0x20/0x2c
[T15862]  taprio_dump+0xa0c/0xbb0
[T15862]  tc_fill_qdisc+0x540/0x1020
[T15862]  qdisc_notify.isra.0+0x330/0x3a0
[T15862]  tc_modify_qdisc+0x7b8/0x1838
[T15862]  rtnetlink_rcv_msg+0x3c8/0xc20
[T15862]  netlink_rcv_skb+0x1f8/0x3d4
[T15862]  rtnetlink_rcv+0x28/0x40
[T15862]  netlink_unicast+0x51c/0x790
[T15862]  netlink_sendmsg+0x79c/0xc20
[T15862]  __sock_sendmsg+0xe0/0x1a0
[T15862]  ____sys_sendmsg+0x6c0/0x840
[T15862]  ___sys_sendmsg+0x1ac/0x1f0
[T15862]  __sys_sendmsg+0x110/0x1d0
[T15862]  __arm64_sys_sendmsg+0x74/0xb0
[T15862]  invoke_syscall+0x88/0x2e0
[T15862]  el0_svc_common.constprop.0+0xe4/0x2a0
[T15862]  do_el0_svc+0x44/0x60
[T15862]  el0_svc+0x50/0x184
[T15862]  el0t_64_sync_handler+0x120/0x12c
[T15862]  el0t_64_sync+0x190/0x194
[T15862]
[T15862] Allocated by task 15857:
[T15862]  kasan_save_stack+0x3c/0x70
[T15862]  kasan_save_track+0x20/0x3c
[T15862]  kasan_save_alloc_info+0x40/0x60
[T15862]  __kasan_kmalloc+0xd4/0xe0
[T15862]  __kmalloc_cache_noprof+0x194/0x334
[T15862]  taprio_change+0x45c/0x2fe0
[T15862]  tc_modify_qdisc+0x6a8/0x1838
[T15862]  rtnetlink_rcv_msg+0x3c8/0xc20
[T15862]  netlink_rcv_skb+0x1f8/0x3d4
[T15862]  rtnetlink_rcv+0x28/0x40
[T15862]  netlink_unicast+0x51c/0x790
[T15862]  netlink_sendmsg+0x79c/0xc20
[T15862]  __sock_sendmsg+0xe0/0x1a0
[T15862]  ____sys_sendmsg+0x6c0/0x840
[T15862]  ___sys_sendmsg+0x1ac/0x1f0
[T15862]  __sys_sendmsg+0x110/0x1d0
[T15862]  __arm64_sys_sendmsg+0x74/0xb0
[T15862]  invoke_syscall+0x88/0x2e0
[T15862]  el0_svc_common.constprop.0+0xe4/0x2a0
[T15862]  do_el0_svc+0x44/0x60
[T15862]  el0_svc+0x50/0x184
[T15862]  el0t_64_sync_handler+0x120/0x12c
[T15862]  el0t_64_sync+0x190/0x194
[T15862]
[T15862] Freed by task 6192:
[T15862]  kasan_save_stack+0x3c/0x70
[T15862]  kasan_save_track+0x20/0x3c
[T15862]  kasan_save_free_info+0x4c/0x80
[T15862]  poison_slab_object+0x110/0x160
[T15862]  __kasan_slab_free+0x3c/0x74
[T15862]  kfree+0x134/0x3c0
[T15862]  taprio_free_sched_cb+0x18c/0x220
[T15862]  rcu_core+0x920/0x1b7c
[T15862]  rcu_core_si+0x10/0x1c
[T15862]  handle_softirqs+0x2e8/0xd64
[T15862]  __do_softirq+0x14/0x20

Fixes: 18cdd2f0998a ("net/sched: taprio: taprio_dump and taprio_change are protected by rtnl_mutex")
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://patch.msgid.link/20241018051339.418890-2-dmantipov@yandex.ru
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[Lee: Backported from linux-6.6.y to linux-6.1.y and fixed conflicts]
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_taprio.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1995,9 +1995,6 @@ static int taprio_dump(struct Qdisc *sch
 	struct nlattr *nest, *sched_nest;
 	unsigned int i;
 
-	oper = rtnl_dereference(q->oper_sched);
-	admin = rtnl_dereference(q->admin_sched);
-
 	opt.num_tc = netdev_get_num_tc(dev);
 	memcpy(opt.prio_tc_map, dev->prio_tc_map, sizeof(opt.prio_tc_map));
 
@@ -2024,18 +2021,23 @@ static int taprio_dump(struct Qdisc *sch
 	    nla_put_u32(skb, TCA_TAPRIO_ATTR_TXTIME_DELAY, q->txtime_delay))
 		goto options_error;
 
+	rcu_read_lock();
+
+	oper = rtnl_dereference(q->oper_sched);
+	admin = rtnl_dereference(q->admin_sched);
+
 	if (taprio_dump_tc_entries(q, skb))
-		goto options_error;
+		goto options_error_rcu;
 
 	if (oper && dump_schedule(skb, oper))
-		goto options_error;
+		goto options_error_rcu;
 
 	if (!admin)
 		goto done;
 
 	sched_nest = nla_nest_start_noflag(skb, TCA_TAPRIO_ATTR_ADMIN_SCHED);
 	if (!sched_nest)
-		goto options_error;
+		goto options_error_rcu;
 
 	if (dump_schedule(skb, admin))
 		goto admin_error;
@@ -2043,11 +2045,15 @@ static int taprio_dump(struct Qdisc *sch
 	nla_nest_end(skb, sched_nest);
 
 done:
+	rcu_read_unlock();
 	return nla_nest_end(skb, nest);
 
 admin_error:
 	nla_nest_cancel(skb, sched_nest);
 
+options_error_rcu:
+	rcu_read_unlock();
+
 options_error:
 	nla_nest_cancel(skb, nest);
 



