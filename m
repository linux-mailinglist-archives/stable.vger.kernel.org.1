Return-Path: <stable+bounces-108831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16328A12084
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106A8168172
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A681E9909;
	Wed, 15 Jan 2025 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eFabHf0s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6ED248BA6;
	Wed, 15 Jan 2025 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937948; cv=none; b=LKQgbR+BqtozsJDH+uFxG0nL27i+wKyry+INSGlndpkcZmFO/CFpQ2pwAkayl5TnKaeVsxFpc08SBhBIdoNoS9b1rdYTwjHxk6VuJWj+Fv4wzuhnpghnWmkDRJ+3GHqVzkUL9AD7Rb/LDJZ/KnU6sXmTjHhd4jDECiEtpOpk0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937948; c=relaxed/simple;
	bh=yJaYhTgTuBjwrAyg4/lJwPLe0ygMrc5FBC3XDU0eI88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uk5x8bD1NB05s+wqJy5z/nNSDBzk16Zig3I+ppQycYhEvliJGMt8XdAJieg77HhpEGa+srdOqFkB0re92i3G17o7y9Mr3JmUQzMnWVk0v643yY4DkPJPkiJjbTE7vY8jfyYxvq+y1lk0aD7YX5I58AB6RJAqtJMWMqh/0DQT09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eFabHf0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCBAC4CEDF;
	Wed, 15 Jan 2025 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736937948;
	bh=yJaYhTgTuBjwrAyg4/lJwPLe0ygMrc5FBC3XDU0eI88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eFabHf0sHAFsSD5u+I5sUmx7aQZqNGmS1WO93xy9x9Ihlwfq1NCxRYaKycqy8NK6e
	 l6GzOQW4bEuKpD8JcT12MF9XkqrvKvQQzuyRKTPHYs8xqWKrD1T5i79dHfcpgGKpgD
	 l2tns6kRVe8uTEExhnF/fYUaFwpnqmI/aog71c68=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzkaller <syzkaller@googlegroups.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 039/189] ipvlan: Fix use-after-free in ipvlan_get_iflink().
Date: Wed, 15 Jan 2025 11:35:35 +0100
Message-ID: <20250115103607.920800155@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit cb358ff94154774d031159b018adf45e17673941 ]

syzbot presented an use-after-free report [0] regarding ipvlan and
linkwatch.

ipvlan does not hold a refcnt of the lower device unlike vlan and
macvlan.

If the linkwatch work is triggered for the ipvlan dev, the lower dev
might have already been freed, resulting in UAF of ipvlan->phy_dev in
ipvlan_get_iflink().

We can delay the lower dev unregistration like vlan and macvlan by
holding the lower dev's refcnt in dev->netdev_ops->ndo_init() and
releasing it in dev->priv_destructor().

Jakub pointed out calling .ndo_XXX after unregister_netdevice() has
returned is error prone and suggested [1] addressing this UAF in the
core by taking commit 750e51603395 ("net: avoid potential UAF in
default_operstate()") further.

Let's assume unregistering devices DOWN and use RCU protection in
default_operstate() not to race with the device unregistration.

[0]:
BUG: KASAN: slab-use-after-free in ipvlan_get_iflink+0x84/0x88 drivers/net/ipvlan/ipvlan_main.c:353
Read of size 4 at addr ffff0000d768c0e0 by task kworker/u8:35/6944

CPU: 0 UID: 0 PID: 6944 Comm: kworker/u8:35 Not tainted 6.13.0-rc2-g9bc5c9515b48 #12 4c3cb9e8b4565456f6a355f312ff91f4f29b3c47
Hardware name: linux,dummy-virt (DT)
Workqueue: events_unbound linkwatch_event
Call trace:
 show_stack+0x38/0x50 arch/arm64/kernel/stacktrace.c:484 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xbc/0x108 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x16c/0x6f0 mm/kasan/report.c:489
 kasan_report+0xc0/0x120 mm/kasan/report.c:602
 __asan_report_load4_noabort+0x20/0x30 mm/kasan/report_generic.c:380
 ipvlan_get_iflink+0x84/0x88 drivers/net/ipvlan/ipvlan_main.c:353
 dev_get_iflink+0x7c/0xd8 net/core/dev.c:674
 default_operstate net/core/link_watch.c:45 [inline]
 rfc2863_policy+0x144/0x360 net/core/link_watch.c:72
 linkwatch_do_dev+0x60/0x228 net/core/link_watch.c:175
 __linkwatch_run_queue+0x2f4/0x5b8 net/core/link_watch.c:239
 linkwatch_event+0x64/0xa8 net/core/link_watch.c:282
 process_one_work+0x700/0x1398 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x8c4/0xe10 kernel/workqueue.c:3391
 kthread+0x2b0/0x360 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862

Allocated by task 9303:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x68 mm/kasan/common.c:68
 kasan_save_alloc_info+0x44/0x58 mm/kasan/generic.c:568
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x84/0xa0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4283 [inline]
 __kmalloc_node_noprof+0x2a0/0x560 mm/slub.c:4289
 __kvmalloc_node_noprof+0x9c/0x230 mm/util.c:650
 alloc_netdev_mqs+0xb4/0x1118 net/core/dev.c:11209
 rtnl_create_link+0x2b8/0xb60 net/core/rtnetlink.c:3595
 rtnl_newlink_create+0x19c/0x868 net/core/rtnetlink.c:3771
 __rtnl_newlink net/core/rtnetlink.c:3896 [inline]
 rtnl_newlink+0x122c/0x15c0 net/core/rtnetlink.c:4011
 rtnetlink_rcv_msg+0x61c/0x918 net/core/rtnetlink.c:6901
 netlink_rcv_skb+0x1dc/0x398 net/netlink/af_netlink.c:2542
 rtnetlink_rcv+0x34/0x50 net/core/rtnetlink.c:6928
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x618/0x838 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x5fc/0x8b0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 __sys_sendto+0x2ec/0x438 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __arm64_sys_sendto+0xe4/0x110 net/socket.c:2200
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x90/0x278 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x13c/0x250 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x54/0x70 arch/arm64/kernel/syscall.c:151
 el0_svc+0x4c/0xa8 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x1a0 arch/arm64/kernel/entry.S:600

Freed by task 10200:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x68 mm/kasan/common.c:68
 kasan_save_free_info+0x58/0x70 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x48/0x68 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x140/0x420 mm/slub.c:4746
 kvfree+0x4c/0x68 mm/util.c:693
 netdev_release+0x94/0xc8 net/core/net-sysfs.c:2034
 device_release+0x98/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x2b0/0x438 lib/kobject.c:737
 netdev_run_todo+0xdd8/0xf48 net/core/dev.c:10924
 rtnl_unlock net/core/rtnetlink.c:152 [inline]
 rtnl_net_unlock net/core/rtnetlink.c:209 [inline]
 rtnl_dellink+0x484/0x680 net/core/rtnetlink.c:3526
 rtnetlink_rcv_msg+0x61c/0x918 net/core/rtnetlink.c:6901
 netlink_rcv_skb+0x1dc/0x398 net/netlink/af_netlink.c:2542
 rtnetlink_rcv+0x34/0x50 net/core/rtnetlink.c:6928
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x618/0x838 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x5fc/0x8b0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 ____sys_sendmsg+0x410/0x708 net/socket.c:2583
 ___sys_sendmsg+0x178/0x1d8 net/socket.c:2637
 __sys_sendmsg net/socket.c:2669 [inline]
 __do_sys_sendmsg net/socket.c:2674 [inline]
 __se_sys_sendmsg net/socket.c:2672 [inline]
 __arm64_sys_sendmsg+0x12c/0x1c8 net/socket.c:2672
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x90/0x278 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x13c/0x250 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x54/0x70 arch/arm64/kernel/syscall.c:151
 el0_svc+0x4c/0xa8 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x1a0 arch/arm64/kernel/entry.S:600

The buggy address belongs to the object at ffff0000d768c000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 224 bytes inside of
 freed 4096-byte region [ffff0000d768c000, ffff0000d768d000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x117688
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff0000c77ef981
flags: 0xbfffe0000000040(head|node=0|zone=2|lastcpupid=0x1ffff)
page_type: f5(slab)
raw: 0bfffe0000000040 ffff0000c000f500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001f5000000 ffff0000c77ef981
head: 0bfffe0000000040 ffff0000c000f500 dead000000000100 dead000000000122
head: 0000000000000000 0000000000040004 00000001f5000000 ffff0000c77ef981
head: 0bfffe0000000003 fffffdffc35da201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000d768bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000d768c000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000d768c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff0000d768c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000d768c180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: 8c55facecd7a ("net: linkwatch: only report IF_OPER_LOWERLAYERDOWN if iflink is actually down")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20250102174400.085fd8ac@kernel.org/ [1]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250106071911.64355-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/link_watch.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 1b4d39e38084..cb04ef2b9807 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -42,14 +42,18 @@ static unsigned int default_operstate(const struct net_device *dev)
 	 * first check whether lower is indeed the source of its down state.
 	 */
 	if (!netif_carrier_ok(dev)) {
-		int iflink = dev_get_iflink(dev);
 		struct net_device *peer;
+		int iflink;
 
 		/* If called from netdev_run_todo()/linkwatch_sync_dev(),
 		 * dev_net(dev) can be already freed, and RTNL is not held.
 		 */
-		if (dev->reg_state == NETREG_UNREGISTERED ||
-		    iflink == dev->ifindex)
+		if (dev->reg_state <= NETREG_REGISTERED)
+			iflink = dev_get_iflink(dev);
+		else
+			iflink = dev->ifindex;
+
+		if (iflink == dev->ifindex)
 			return IF_OPER_DOWN;
 
 		ASSERT_RTNL();
-- 
2.39.5




