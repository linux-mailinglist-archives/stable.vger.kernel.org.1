Return-Path: <stable+bounces-192712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7A5C3FA50
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 12:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF34F3B6A58
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 11:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB10531C58A;
	Fri,  7 Nov 2025 11:06:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715F31AF1D
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513579; cv=none; b=CJJAfb2vlT+Yl3HHWgOtbPIbtF6vt4ZLNWLJy7ZVZehQyDVwn+niMadQ/CevAt6I8b6F4GomoMS+vcauRDf07tuJGP0smGJBvaPc+Fdsb0vBEzxrfX3gKKLqfTN1fOfl7AWfaS3/fvJIyi4Xq8XXeuV4HtRfxMk2nsBsdDQh05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513579; c=relaxed/simple;
	bh=3vB+SlHxUbkkRzKoqMns9VRF4uBIh29actxYlHhBAMI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Ti6uCv+MN1XzNSaTHU3Sh87bZc44C5qcUOzICfiLKZWw0UGIXI0M5Dcm3pOa+keJl2jU5oei2gycQbIbrbNksvjawimX3xnh6pJ7wXfM60yBKNkvKFrByEvVJEN/3UqOLZSzjPBtTW2+JoNHGZafaJrBqnAqfHK0JnpQh5PxiRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e8839f138so49567639f.2
        for <stable@vger.kernel.org>; Fri, 07 Nov 2025 03:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762513576; x=1763118376;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlZiSo9idK2j7S97qoxkiQFU6gD7Ty00a+sM4XvvUvQ=;
        b=QaBNF74UlOFd6kw3Yh7H1iEgONYPvbcP6D56UMqfFrYEuh/c1GsDNt5ztnpp++OUku
         O55/JbmIoa4WK/rAbxY63/rQh6jbG3H1WEQk3LJDVj8FA8UKW9HCOXP5BkZxPBZLaBhn
         KNTAAALI8cR9Mt1K7Z/vg+N4bOFHgwitW3tJXPSR4grQxA+lCBpCaXTi0rDj0N1yvjiS
         mZmcsVkKeH9xwhr0Pj5SavFx0gRXBo5B9B+oJ+Vzk40zKQZSXpite9syhxGDA6N6xUPY
         d0574cFJ8kIwekEy+CcQw3S6s43lEMN7AOt3oYalwqMZuz0KqQeJBWIPVrpm5zXUCvEQ
         4ctw==
X-Forwarded-Encrypted: i=1; AJvYcCXpvJUyqsykOUie9sG0Lk8obpZEFLu3OT6scf9enVN2VQN5VsFCjHh74iZE+wKIyCQE/Ab5e4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpsFlqHYbbvRiJ7aiGODA1Ce/lOjZfCfBGO7edVEy2khlShaNA
	Tf+k9GZj9KRpaB5Z431aG/5kLN1TcHR7R9CDO05dtVIeVzp6oNMl8q4Dx9vyhmkj16xXoYzHKwI
	8jWcqLk5aO+JUsd/QCf4X5P56q4FilBOL0ofUpF5yVqO8hqPqeLwyfJYKTY8=
X-Google-Smtp-Source: AGHT+IFtq8vti0VVMqqLFM0bv4gUTSBe4hTPp5evTjvIF5wiTxqgsOFnnguZogDuOBM7v8Hwi4ZtDTN1tvpIai1XWk5jXBtYFQJY
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3485:b0:433:2943:3a78 with SMTP id
 e9e14a558f8ab-4335f478e35mr38087315ab.31.1762513576045; Fri, 07 Nov 2025
 03:06:16 -0800 (PST)
Date: Fri, 07 Nov 2025 03:06:16 -0800
In-Reply-To: <20251107080117.15099-1-make24@iscas.ac.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dd2a8.a70a0220.22f260.003d.GAE@google.com>
Subject: [syzbot ci] Re: net: Fix error handling in netdev_register_kobject
From: syzbot ci <syzbot+ci348771c1c9b7511f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, atenart@kernel.org, davem@davemloft.net, 
	ebiederm@xmission.com, edumazet@google.com, gregkh@suse.de, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	make24@iscas.ac.cn, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, stable@vger.kernel.org, yajun.deng@linux.dev
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] net: Fix error handling in netdev_register_kobject
https://lore.kernel.org/all/20251107080117.15099-1-make24@iscas.ac.cn
* [PATCH] net: Fix error handling in netdev_register_kobject

and found the following issue:
KASAN: slab-use-after-free Read in netdev_run_todo

Full report is available here:
https://ci.syzbot.org/series/29bd058e-ea85-48e2-9bb9-ff9c0214f12e

***

KASAN: slab-use-after-free Read in netdev_run_todo

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      8a25a2e34157d882032112e4194ccdfb29c499e8
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/2f985280-f9ef-47c8-b4ec-80d44968222b/config

==================================================================
BUG: KASAN: slab-use-after-free in kobject_put+0x2ab/0x480
Read of size 1 at addr ffff888113992714 by task kworker/u8:0/12

CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250
 print_report+0xca/0x240
 kasan_report+0x118/0x150
 kobject_put+0x2ab/0x480
 netdev_run_todo+0xd2e/0xea0
 ops_undo_list+0x3e1/0x990
 cleanup_net+0x4d8/0x820
 process_scheduled_works+0xae1/0x17b0
 worker_thread+0x8a0/0xda0
 kthread+0x711/0x8a0
 ret_from_fork+0x4bc/0x870
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 5810:
 kasan_save_track+0x3e/0x80
 __kasan_kmalloc+0x93/0xb0
 __kvmalloc_node_noprof+0x5cd/0x910
 alloc_netdev_mqs+0xa6/0x11b0
 ip6gre_init_net+0xb5/0x3c0
 ops_init+0x35c/0x5c0
 setup_net+0xfe/0x320
 copy_net_ns+0x34e/0x4e0
 create_new_namespaces+0x3f3/0x720
 unshare_nsproxy_namespaces+0x11c/0x170
 ksys_unshare+0x4c8/0x8c0
 __x64_sys_unshare+0x38/0x50
 do_syscall_64+0xfa/0xfa0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 12:
 kasan_save_track+0x3e/0x80
 __kasan_save_free_info+0x46/0x50
 __kasan_slab_free+0x5c/0x80
 kfree+0x19a/0x6d0
 device_release+0x9c/0x1c0
 kobject_put+0x22b/0x480
 netdev_run_todo+0xd0c/0xea0
 ops_undo_list+0x3e1/0x990
 cleanup_net+0x4d8/0x820
 process_scheduled_works+0xae1/0x17b0
 worker_thread+0x8a0/0xda0
 kthread+0x711/0x8a0
 ret_from_fork+0x4bc/0x870
 ret_from_fork_asm+0x1a/0x30

The buggy address belongs to the object at ffff888113992000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 1812 bytes inside of
 freed 4096-byte region [ffff888113992000, ffff888113993000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x113990
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000040 ffff88810004b500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 017ff00000000040 ffff88810004b500 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 017ff00000000003 ffffea00044e6401 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5810, tgid 5810 (syz-executor), ts 65154411256, free_ts 60842795356
 post_alloc_hook+0x240/0x2a0
 get_page_from_freelist+0x2365/0x2440
 __alloc_frozen_pages_noprof+0x181/0x370
 alloc_pages_mpol+0x232/0x4a0
 allocate_slab+0x96/0x350
 ___slab_alloc+0xe94/0x18a0
 __slab_alloc+0x65/0x100
 __kmalloc_noprof+0x471/0x7f0
 __register_sysctl_table+0x72/0x1340
 __addrconf_sysctl_register+0x328/0x4c0
 addrconf_sysctl_register+0x168/0x1c0
 ipv6_add_dev+0xd46/0x1370
 addrconf_notify+0x794/0x1010
 notifier_call_chain+0x1b6/0x3e0
 register_netdevice+0x1608/0x1ae0
 register_netdev+0x40/0x60
page last free pid 15 tgid 15 stack trace:
 __free_frozen_pages+0xbc4/0xd30
 __folio_put+0x21b/0x2c0
 skb_release_data+0x49a/0x7c0
 napi_consume_skb+0x158/0x1e0
 skb_defer_free_flush+0x18f/0x250
 net_rx_action+0x804/0xe50
 handle_softirqs+0x286/0x870
 run_ksoftirqd+0x9b/0x100
 smpboot_thread_fn+0x542/0xa60
 kthread+0x711/0x8a0
 ret_from_fork+0x4bc/0x870
 ret_from_fork_asm+0x1a/0x30

Memory state around the buggy address:
 ffff888113992600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888113992680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888113992700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888113992780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888113992800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

