Return-Path: <stable+bounces-182885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C094BAEB3D
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 00:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1BC16E9F6
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 22:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADF72C2ABF;
	Tue, 30 Sep 2025 22:23:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47231F03C9
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759270987; cv=none; b=EBzIMVr/wXkxqQsqJh4Q9leGr8hpJESCi24KV5Vhqn1Sfobgl76Zuafctz2Y0gHZAtmEIbtzRrjfGXoDmj2XnH0w42fGkOK7CX3N4kc2I3QTIxY+9aAUtxGyI3A5K2FzQSX/gtGi2BrZNkciVI0G4lPpFHf67MZ3/y8dpO9XNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759270987; c=relaxed/simple;
	bh=57MwBoTbQo10mTTONSI/zIJib+Djxy1OFOKuFV47KMw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fkZUNscC2K8eKmFtys3+/iZ1vKAnzQLEetE+vUalbpGTqi/4vCpui+EgTS4uN42s4yGChGx2XOFKx/1A9T5wQs1FRN1RRNXs++5Y7K2UtBJnp3lj3Rh6AcBhRTGSISolcyh9nWIPfv6ljBqkBgfEc3TH/2o4WK6K3io5LZcdRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4257e203f14so195691945ab.2
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 15:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759270983; x=1759875783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqXQKjmycSxxhSvvFqs1SMC8w4rokeniQ1yL+WPbmIg=;
        b=MWdzCu6AaZo2iyV45z2pNzBfPzDFJeysrgJo/KAiEkVJvyOtVt5y0Tndy4WFvd4UUq
         m9jboOJtAGFmIATEnOcMJ9M48T8w3D/ZgpaaBojp3T03GmnOcEsc5HXEYK/qCqUVJ+c0
         Ul1Rah4selXarQ7oFh1sinqXDYQjWoA7/RPaRkymQ7eQUD1SME6nFq4cCXtaQVtCbUsi
         69mjDkLbu81Nzi3vYhTVnCqsMdgRbVDMl/8LAuGV0X0LmNyssG4doZEKZz6y3MVrlM5f
         je21QbQ+8CXvRD0fxkGYjiN3fXn6a1xjeXp6dqOBBhq7PeVa2Jr0qvdzaDQMbcTUlmFP
         fyUg==
X-Forwarded-Encrypted: i=1; AJvYcCXDrcY4eNqjFTS1GYJohSoAOMIFpHf8wc9jE1e13CodIPH8ckaoICHLhpz9Hr4SWeoT1YjhORY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZl2sZrkygRTxwLaa2MdpYts797jv7+yLQ2uJlZWHQbgkAruP
	lMRuTozfEEW26yQe/EfeGENuLSrSMA8Dk95+KZjoFqFsPQRDjGRIPMtq+tmPyDY9kA8fd32fEc+
	1PMCMAOv5ph1tct/epSYYrLbBxWa7SBNkbrse+IbQIx309JC8eAksgiXHjxw=
X-Google-Smtp-Source: AGHT+IEDcfsT1Vc9pVh1ktnU/+V7gcKDZ1UyB6QJjdnqBL4sNlkqJQdiDxGe6CQNmVRx0TLHM8XuVECbuMbPf2NnrIpF6yrsQFp2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c7:b0:427:c8d1:bea5 with SMTP id
 e9e14a558f8ab-42d81630300mr21602295ab.21.1759270983771; Tue, 30 Sep 2025
 15:23:03 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:23:03 -0700
In-Reply-To: <20250930220502.771163-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc5847.a00a0220.102ee.0050.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_ext_insert_extent
From: syzbot <syzbot+9db318d6167044609878@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in ext4_find_extent

EXT4-fs (loop4): stripe (1570) is not aligned with cluster size (16), stripe is disabled
==================================================================
BUG: KASAN: slab-out-of-bounds in ext4_ext_binsearch fs/ext4/extents.c:841 [inline]
BUG: KASAN: slab-out-of-bounds in ext4_find_extent+0xae6/0xcc0 fs/ext4/extents.c:956
Read of size 4 at addr ffff8880739bce18 by task syz.4.64/6825

CPU: 1 UID: 0 PID: 6825 Comm: syz.4.64 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ext4_ext_binsearch fs/ext4/extents.c:841 [inline]
 ext4_find_extent+0xae6/0xcc0 fs/ext4/extents.c:956
 ext4_ext_map_blocks+0x27c/0x3880 fs/ext4/extents.c:4211
 ext4_map_query_blocks+0x13b/0x930 fs/ext4/inode.c:550
 ext4_map_blocks+0x4b3/0x1740 fs/ext4/inode.c:773
 _ext4_get_block+0x200/0x4c0 fs/ext4/inode.c:910
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:943
 ext4_block_write_begin+0x990/0x1710 fs/ext4/inode.c:1198
 ext4_write_begin+0xc04/0x19a0 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x445/0xda0 fs/ext4/inode.c:3129
 generic_perform_write+0x2c2/0x900 mm/filemap.c:4175
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_pwrite64 fs/read_write.c:793 [inline]
 __do_sys_pwrite64 fs/read_write.c:801 [inline]
 __se_sys_pwrite64 fs/read_write.c:798 [inline]
 __x64_sys_pwrite64+0x193/0x220 fs/read_write.c:798
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f105318e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1054026038 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f10533b5fa0 RCX: 00007f105318e969
RDX: 000000000000fdef RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007f1053210ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000fecc R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f10533b5fa0 R15: 00007ffeabbc1e38
 </TASK>

Allocated by task 6341:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4376 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __register_sysctl_table+0x72/0x1340 fs/proc/proc_sysctl.c:1379
 __addrconf_sysctl_register+0x328/0x4c0 net/ipv6/addrconf.c:7321
 addrconf_sysctl_register+0x168/0x1c0 net/ipv6/addrconf.c:7369
 ipv6_add_dev+0xd46/0x1370 net/ipv6/addrconf.c:460
 addrconf_notify+0x794/0x1010 net/ipv6/addrconf.c:3650
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 register_netdevice+0x1608/0x1ae0 net/core/dev.c:11244
 register_netdev+0x40/0x60 net/core/dev.c:11322
 sit_init_net+0x228/0x5c0 net/ipv6/sit.c:1867
 ops_init+0x359/0x5c0 net/core/net_namespace.c:137
 setup_net+0xfe/0x320 net/core/net_namespace.c:445
 copy_net_ns+0x34e/0x4e0 net/core/net_namespace.c:580
 create_new_namespaces+0x3f3/0x720 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:218
 ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3132
 __do_sys_unshare kernel/fork.c:3203 [inline]
 __se_sys_unshare kernel/fork.c:3201 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880739bc000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 1504 bytes to the right of
 allocated 2104-byte region [ffff8880739bc000, ffff8880739bc838)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x739b8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888027c52441
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a04b500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000000f5000000 ffff888027c52441
head: 00fff00000000040 ffff88801a04b500 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000000f5000000 ffff888027c52441
head: 00fff00000000003 ffffea0001ce6e01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6341, tgid 6341 (syz-executor), ts 124779228140, free_ts 121882435080
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21d5/0x22b0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2660
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4402
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 snmp6_alloc_dev net/ipv6/addrconf.c:362 [inline]
 ipv6_add_dev+0x6ca/0x1370 net/ipv6/addrconf.c:413
 addrconf_notify+0x794/0x1010 net/ipv6/addrconf.c:3650
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 register_netdevice+0x1608/0x1ae0 net/core/dev.c:11244
 register_netdev+0x40/0x60 net/core/dev.c:11322
 sit_init_net+0x228/0x5c0 net/ipv6/sit.c:1867
 ops_init+0x359/0x5c0 net/core/net_namespace.c:137
 setup_net+0xfe/0x320 net/core/net_namespace.c:445
 copy_net_ns+0x34e/0x4e0 net/core/net_namespace.c:580
page last free pid 6267 tgid 6267 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbb1/0xd20 mm/page_alloc.c:2895
 vfree+0x25a/0x400 mm/vmalloc.c:3434
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:961
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 get_signal+0x125e/0x1310 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880739bcd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880739bcd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880739bce00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                            ^
 ffff8880739bce80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880739bcf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         22bdd6e6 Merge tag 'x86_apic_for_v6.18_rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134485cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6899ea2dd30a3ed1
dashboard link: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=114e8260580000


