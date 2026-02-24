Return-Path: <stable+bounces-217861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCkODTo8nWkGNwQAu9opvQ
	(envelope-from <stable+bounces-217861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 06:50:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5C18233D
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 06:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEEAC302B1B2
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 05:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C85B2C326D;
	Tue, 24 Feb 2026 05:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oQyXepRe"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FDD2C3256;
	Tue, 24 Feb 2026 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771912244; cv=none; b=FzPu8fgCHHzanVPw/PnlWt6coqSHXGo0/miDpgMGXoWuJdY+r8e5JNgZyxUAF605c3yx0kb7F+PD+0LdPtPpqkzX+Bo8i3bFcri/CV4B3uMd6TKm3MYLJa4pErt59MpLivXxDUOEdf9oFHOZGDXbZqfPSG5s4HOyXu/MaegiJRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771912244; c=relaxed/simple;
	bh=1xoHKza8D9qbpBu77QMbUCKoksai5zG0Vqlhugga9bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BHdrmEmTY2JhDuECRqWWOCtzYGvK7AxsUcVG2z4ugIECdvt7lPuQ9s5/VuF2Q3zm+YTDYU507npkZjHBeR/arr7w5+oBFiIBorjZMQAMyI38pOHOcofUikbFWw9VBadZIlnrPoSfyu8xDSzZag81OBlWt5F16FLuSg1vsz2k/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oQyXepRe; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8X
	HdgUxzGg4cYygXrKsfiEyU8WflBm67ZhCwzxUsvwQ=; b=oQyXepReo/JUpKF/Bq
	cpTnM8X+gP2HxlGwsBx/g+WA6daUgeNZFhrMEZEHKM8kKX9LfjbzQzSVe6ctv3b1
	X6uTfM1jExjFSbwB1mruRTkjIUTPuuIs7QjNnfRM58gO7rxNbgLuHjK2+v0FMMyR
	hpFkHOT0uYzesWyIR7A59kpSs=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBXv3P4O51pjHizOg--.39411S2;
	Tue, 24 Feb 2026 13:49:46 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot+179fc225724092b8b2b2@syzkaller.appspotmail.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.6.y] dst: fix races in rt6_uncached_list_del() and rt_del_uncached_list()
Date: Tue, 24 Feb 2026 13:49:43 +0800
Message-Id: <20260224054943.3324184-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXv3P4O51pjHizOg--.39411S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfGF1kWFW3Jw4xZF43Zr1kXwb_yoW8JF1fGo
	WFvws5Xr4xKa45t3WfAr12ga1FgF97XF17Zrsrur4FvF42v3s8ArySga15ZryxXa4fGa93
	XFy2qr18Ga4UJr93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTR3KsjDUUUU
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+hrOaGmdO-ooxAAA3f
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,syzkaller.appspotmail.com,kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-217861-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,179fc225724092b8b2b2];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 47E5C18233D
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9a6f0c4d5796ab89b5a28a890ce542344d58bd69 ]

syzbot was able to crash the kernel in rt6_uncached_list_flush_dev()
in an interesting way [1]

Crash happens in list_del_init()/INIT_LIST_HEAD() while writing
list->prev, while the prior write on list->next went well.

static inline void INIT_LIST_HEAD(struct list_head *list)
{
	WRITE_ONCE(list->next, list); // This went well
	WRITE_ONCE(list->prev, list); // Crash, @list has been freed.
}

Issue here is that rt6_uncached_list_del() did not attempt to lock
ul->lock, as list_empty(&rt->dst.rt_uncached) returned
true because the WRITE_ONCE(list->next, list) happened on the other CPU.

We might use list_del_init_careful() and list_empty_careful(),
or make sure rt6_uncached_list_del() always grabs the spinlock
whenever rt->dst.rt_uncached_list has been set.

A similar fix is neeed for IPv4.

[1]

 BUG: KASAN: slab-use-after-free in INIT_LIST_HEAD include/linux/list.h:46 [inline]
 BUG: KASAN: slab-use-after-free in list_del_init include/linux/list.h:296 [inline]
 BUG: KASAN: slab-use-after-free in rt6_uncached_list_flush_dev net/ipv6/route.c:191 [inline]
 BUG: KASAN: slab-use-after-free in rt6_disable_ip+0x633/0x730 net/ipv6/route.c:5020
Write of size 8 at addr ffff8880294cfa78 by task kworker/u8:14/3450

CPU: 0 UID: 0 PID: 3450 Comm: kworker/u8:14 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)}
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
  print_address_description mm/kasan/report.c:378 [inline]
  print_report+0xca/0x240 mm/kasan/report.c:482
  kasan_report+0x118/0x150 mm/kasan/report.c:595
  INIT_LIST_HEAD include/linux/list.h:46 [inline]
  list_del_init include/linux/list.h:296 [inline]
  rt6_uncached_list_flush_dev net/ipv6/route.c:191 [inline]
  rt6_disable_ip+0x633/0x730 net/ipv6/route.c:5020
  addrconf_ifdown+0x143/0x18a0 net/ipv6/addrconf.c:3853
 addrconf_notify+0x1bc/0x1050 net/ipv6/addrconf.c:-1
  notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
  call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
  call_netdevice_notifiers net/core/dev.c:2282 [inline]
  netif_close_many+0x29c/0x410 net/core/dev.c:1785
  unregister_netdevice_many_notify+0xb50/0x2330 net/core/dev.c:12353
  ops_exit_rtnl_list net/core/net_namespace.c:187 [inline]
  ops_undo_list+0x3dc/0x990 net/core/net_namespace.c:248
  cleanup_net+0x4de/0x7b0 net/core/net_namespace.c:696
  process_one_work kernel/workqueue.c:3257 [inline]
  process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
  kthread+0x711/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Allocated by task 803:
  kasan_save_stack mm/kasan/common.c:57 [inline]
  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
  unpoison_slab_object mm/kasan/common.c:340 [inline]
  __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
  kasan_slab_alloc include/linux/kasan.h:253 [inline]
  slab_post_alloc_hook mm/slub.c:4953 [inline]
  slab_alloc_node mm/slub.c:5263 [inline]
  kmem_cache_alloc_noprof+0x18d/0x6c0 mm/slub.c:5270
  dst_alloc+0x105/0x170 net/core/dst.c:89
  ip6_dst_alloc net/ipv6/route.c:342 [inline]
  icmp6_dst_alloc+0x75/0x460 net/ipv6/route.c:3333
  mld_sendpack+0x683/0xe60 net/ipv6/mcast.c:1844
  mld_send_cr net/ipv6/mcast.c:2154 [inline]
  mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2693
  process_one_work kernel/workqueue.c:3257 [inline]
  process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
  kthread+0x711/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Freed by task 20:
  kasan_save_stack mm/kasan/common.c:57 [inline]
  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
  poison_slab_object mm/kasan/common.c:253 [inline]
  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
  kasan_slab_free include/linux/kasan.h:235 [inline]
  slab_free_hook mm/slub.c:2540 [inline]
  slab_free mm/slub.c:6670 [inline]
  kmem_cache_free+0x18f/0x8d0 mm/slub.c:6781
  dst_destroy+0x235/0x350 net/core/dst.c:121
  rcu_do_batch kernel/rcu/tree.c:2605 [inline]
  rcu_core kernel/rcu/tree.c:2857 [inline]
  rcu_cpu_kthread+0xba5/0x1af0 kernel/rcu/tree.c:2945
  smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
  kthread+0x711/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Last potentially related work creation:
  kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
  kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
  __call_rcu_common kernel/rcu/tree.c:3119 [inline]
  call_rcu+0xee/0x890 kernel/rcu/tree.c:3239
  refdst_drop include/net/dst.h:266 [inline]
  skb_dst_drop include/net/dst.h:278 [inline]
  skb_release_head_state+0x71/0x360 net/core/skbuff.c:1156
  skb_release_all net/core/skbuff.c:1180 [inline]
  __kfree_skb net/core/skbuff.c:1196 [inline]
  sk_skb_reason_drop+0xe9/0x170 net/core/skbuff.c:1234
  kfree_skb_reason include/linux/skbuff.h:1322 [inline]
  tcf_kfree_skb_list include/net/sch_generic.h:1127 [inline]
  __dev_xmit_skb net/core/dev.c:4260 [inline]
  __dev_queue_xmit+0x26aa/0x3210 net/core/dev.c:4785
  NF_HOOK_COND include/linux/netfilter.h:307 [inline]
  ip6_output+0x340/0x550 net/ipv6/ip6_output.c:247
  NF_HOOK+0x9e/0x380 include/linux/netfilter.h:318
  mld_sendpack+0x8d4/0xe60 net/ipv6/mcast.c:1855
  mld_send_cr net/ipv6/mcast.c:2154 [inline]
  mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2693
  process_one_work kernel/workqueue.c:3257 [inline]
  process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
  kthread+0x711/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

The buggy address belongs to the object at ffff8880294cfa00
 which belongs to the cache ip6_dst_cache of size 232
The buggy address is located 120 bytes inside of
 freed 232-byte region [ffff8880294cfa00, ffff8880294cfae8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x294cf
memcg:ffff88803536b781
flags: 0x80000000000000(node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000000 ffff88802ff1c8c0 ffffea0000bf2bc0 dead000000000006
raw: 0000000000000000 00000000800c000c 00000000f5000000 ffff88803536b781
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 9, tgid 9 (kworker/0:0), ts 91119585830, free_ts 91088628818
  set_page_owner include/linux/page_owner.h:32 [inline]
  post_alloc_hook+0x234/0x290 mm/page_alloc.c:1857
  prep_new_page mm/page_alloc.c:1865 [inline]
  get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3915
  __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
  alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2486
  alloc_slab_page mm/slub.c:3075 [inline]
  allocate_slab+0x86/0x3b0 mm/slub.c:3248
  new_slab mm/slub.c:3302 [inline]
  ___slab_alloc+0xb10/0x13e0 mm/slub.c:4656
  __slab_alloc+0xc6/0x1f0 mm/slub.c:4779
  __slab_alloc_node mm/slub.c:4855 [inline]
  slab_alloc_node mm/slub.c:5251 [inline]
  kmem_cache_alloc_noprof+0x101/0x6c0 mm/slub.c:5270
  dst_alloc+0x105/0x170 net/core/dst.c:89
  ip6_dst_alloc net/ipv6/route.c:342 [inline]
  icmp6_dst_alloc+0x75/0x460 net/ipv6/route.c:3333
  mld_sendpack+0x683/0xe60 net/ipv6/mcast.c:1844
  mld_send_cr net/ipv6/mcast.c:2154 [inline]
  mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2693
  process_one_work kernel/workqueue.c:3257 [inline]
  process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
  kthread+0x711/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
page last free pid 5859 tgid 5859 stack trace:
  reset_page_owner include/linux/page_owner.h:25 [inline]
  free_pages_prepare mm/page_alloc.c:1406 [inline]
  __free_frozen_pages+0xfe1/0x1170 mm/page_alloc.c:2943
  discard_slab mm/slub.c:3346 [inline]
  __put_partials+0x149/0x170 mm/slub.c:3886
  __slab_free+0x2af/0x330 mm/slub.c:5952
  qlink_free mm/kasan/quarantine.c:163 [inline]
  qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
  kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
  __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
  kasan_slab_alloc include/linux/kasan.h:253 [inline]
  slab_post_alloc_hook mm/slub.c:4953 [inline]
  slab_alloc_node mm/slub.c:5263 [inline]
  kmem_cache_alloc_noprof+0x18d/0x6c0 mm/slub.c:5270
  getname_flags+0xb8/0x540 fs/namei.c:146
  getname include/linux/fs.h:2498 [inline]
  do_sys_openat2+0xbc/0x200 fs/open.c:1426
  do_sys_open fs/open.c:1436 [inline]
  __do_sys_openat fs/open.c:1452 [inline]
  __se_sys_openat fs/open.c:1447 [inline]
  __x64_sys_openat+0x138/0x170 fs/open.c:1447
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94

Fixes: 8d0b94afdca8 ("ipv6: Keep track of DST_NOCACHE routes in case of iface down/unregister")
Fixes: 78df76a065ae ("ipv4: take rt_uncached_lock only if needed")
Reported-by: syzbot+179fc225724092b8b2b2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6964cdf2.050a0220.eaf7.009d.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20260112103825.3810713-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 net/core/dst.c   | 1 +
 net/ipv4/route.c | 4 ++--
 net/ipv6/route.c | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/dst.c b/net/core/dst.c
index 2513665696f6..5ed8cb10748f 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -68,6 +68,7 @@ void dst_init(struct dst_entry *dst, struct dst_ops *ops,
 	dst->lwtstate = NULL;
 	rcuref_init(&dst->__rcuref, initial_ref);
 	INIT_LIST_HEAD(&dst->rt_uncached);
+	dst->rt_uncached_list = NULL;
 	dst->__use = 0;
 	dst->lastuse = jiffies;
 	dst->flags = flags;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fcabacec89c7..55ea367f95b3 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1546,9 +1546,9 @@ void rt_add_uncached_list(struct rtable *rt)
 
 void rt_del_uncached_list(struct rtable *rt)
 {
-	if (!list_empty(&rt->dst.rt_uncached)) {
-		struct uncached_list *ul = rt->dst.rt_uncached_list;
+	struct uncached_list *ul = rt->dst.rt_uncached_list;
 
+	if (ul) {
 		spin_lock_bh(&ul->lock);
 		list_del_init(&rt->dst.rt_uncached);
 		spin_unlock_bh(&ul->lock);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ad452a04d729..5f7238f6a2dc 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -149,9 +149,9 @@ void rt6_uncached_list_add(struct rt6_info *rt)
 
 void rt6_uncached_list_del(struct rt6_info *rt)
 {
-	if (!list_empty(&rt->dst.rt_uncached)) {
-		struct uncached_list *ul = rt->dst.rt_uncached_list;
+	struct uncached_list *ul = rt->dst.rt_uncached_list;
 
+	if (ul) {
 		spin_lock_bh(&ul->lock);
 		list_del_init(&rt->dst.rt_uncached);
 		spin_unlock_bh(&ul->lock);
-- 
2.34.1


