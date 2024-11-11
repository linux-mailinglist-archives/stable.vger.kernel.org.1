Return-Path: <stable+bounces-92152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE89C4274
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 17:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C467285C01
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 16:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EF3184556;
	Mon, 11 Nov 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgbWxmAd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BEC54728
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341841; cv=none; b=kX7HEnIl7zYIw7zYBVcrZ2wxSsMir/P26Z9rHPyQ0fL3MCrgXcKSZt5jUQMmiPEZ1XnR38Co+qmN7OBpwViN+O276GkbLDYHOYCeC60wA7pP51qIMAXES2avAwr3R09gpNuajfm1RYQ3Go237gagfeeYUG1Q5xtmZywPIDIOYnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341841; c=relaxed/simple;
	bh=aeQ4DQ5CNKlqFS3GbiBrBkbBLQvKlig6rZ/V7wIJKIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+WF3FSyVB+SFKSq/2Cc233aOaUIh/6fwgKCHHkSc54W8Izi+PNhJlcs+iaGoTeFYMe/V14UZXzMZPYr2Uz53+cznCI3qZuWWYmtt5OfL1A9jM/CoVKzLRqQYEReg6p/nfKaWrhPUUQ9R0DciKe5DUvpafkgNRHsvLaGKSuKK8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgbWxmAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B416C4CECF;
	Mon, 11 Nov 2024 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731341840;
	bh=aeQ4DQ5CNKlqFS3GbiBrBkbBLQvKlig6rZ/V7wIJKIk=;
	h=From:To:Cc:Subject:Date:From;
	b=YgbWxmAdd6JP4WXHhLccsJyw/6tck5p6aS3Pwi5FegLxR0IO5BmpR0WvjS9q/tvuH
	 lX+T2CrVOvsD1gugDaYorlirqYRW+goyHQXPknDw+RCGZSdlcqjPSliUDhv3cJQNeG
	 yquFGWfX/zCfwsv+441/cDsPmGl1Ks0ArFzqnnWgaJH4DOrWlWhflqHCL8B8+PQu8Z
	 HzFHsBb18OGos+yKH6lWNL49jv+Dcq1wJwaVKiW3yRC2ZN64A5Abg6oIXqKINynusM
	 wBExi+Y7KUsHP2VIPpeh/A8Ute8CCESSD9nMpTXC2kdMwwOovXmJvOoBw7X/Szi/4U
	 0jdeUVJMuyszg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v6.1 1/1] net: sched: use RCU read-side critical section in taprio_dump()
Date: Mon, 11 Nov 2024 16:17:01 +0000
Message-ID: <20241111161701.284694-1-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit b22db8b8befe90b61c98626ca1a2fbb0505e9fe3 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 5d282467245f267c0b9ada3f7f309ff838521536)
[Lee: Backported from linux-6.6.y to linux-6.1.y and fixed conflicts]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/sched/sch_taprio.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 212fef2b72f5..1d5cdc987abd 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1995,9 +1995,6 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct nlattr *nest, *sched_nest;
 	unsigned int i;
 
-	oper = rtnl_dereference(q->oper_sched);
-	admin = rtnl_dereference(q->admin_sched);
-
 	opt.num_tc = netdev_get_num_tc(dev);
 	memcpy(opt.prio_tc_map, dev->prio_tc_map, sizeof(opt.prio_tc_map));
 
@@ -2024,18 +2021,23 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
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
@@ -2043,11 +2045,15 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
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
 
-- 
2.47.0.277.g8800431eea-goog


