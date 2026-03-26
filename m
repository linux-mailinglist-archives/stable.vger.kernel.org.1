Return-Path: <stable+bounces-230411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIPhCGOfxGki1gQAu9opvQ
	(envelope-from <stable+bounces-230411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 03:52:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ACD32E839
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 03:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FEFE30413BA
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0D9391839;
	Thu, 26 Mar 2026 02:46:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F9391845
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774493169; cv=none; b=Nl0SqLH3mwkxtDGgkjwHj1BxmYciaxQe60403b5qYHCMEQ6RO0tQhx3wch42JhscfIvUjz3qqtQTYLiVN+DyvmVRuP3QSUkZ1mvdyqc7GcXcQ9tSKYp7SXndkTvYO0NbQQ4EG66+RzSU6jO9Zxq6FKttgzif3+ldnjAH2qIBlLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774493169; c=relaxed/simple;
	bh=Qup0viGMrtZwi+cZYhQLwOFvKYBPQtTyLWNvylCourA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YwsAR+YFuOPN9yvvix+aV0ElusaZSVxBv/11OjhvflxEdDcvcqhM6JsSnBDrrrKTpi5cy+BgoyLW848D4lZVsgwzN1JkBv8auhkvQOYsjLUfAkUJ1t1YFahATNQOGesmvJQw7wWOKyxxxA67kxUc9C6KXVzXsxRM+pp7p7xTqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67c30448569so1008470eaf.3
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 19:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774493162; x=1775097962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rogzNrUW3j49RE/xVBLpLgthwWopxtioe/Kz0A9iJ94=;
        b=iI3P3DAYosPQru+VMo5Q9E4BXd5iHOlc84+5GVbyNa3L0KtLuCTh65Eqae/hMNI1Ns
         sqS1OMOVdI089WBtZODQ7ZAynGRbRZBVcVyp3yOT0E4qR+cgAOieHbHHXm2L5DvcLInS
         YGAWNTPb31c83bEPafgFaXoeskceL91ZnqCd61mmfvMeLx5uyeyBmnJ3RssxPptJszjL
         5ol8lyhMOfFdlro+uyj0a580Eyg54KfJYdR6N/uCX0l0pfES71jrXYl1AdOm3NCFEbOf
         qe4TztxWybhDsORjfygvRuzk5v0wiDc2ilAwxDM8FXG84D2D7nIOXXAoNajxPKEht4zD
         fjHw==
X-Forwarded-Encrypted: i=1; AJvYcCVDkqd3Qh+nf9JM1q/TvgkaorsSddlzmllMd0PJRc2EnK3/vI94gkrzQvJ4xPv+kOPalRgkKkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLgr22phMp/f3BvZVdrLYbYviylUrIBYyZ9BOblr2SZn0/0OR
	y8Fqa3WuwJroUSl1FLqjlHPkKTFvUOJXyguUKXEP5fgDO//fp4chUYWHAVdd959p7EfIeCpszlX
	3HmS1wYj67TtWdtJhUusbWyoGtdjdm4ZkUh3UeJTcYuf+Q6gyX5xpVBy7YrE=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:82c:b0:67c:2bc1:6d87 with SMTP id
 006d021491bc7-67dff564974mr3013667eaf.52.1774493161851; Wed, 25 Mar 2026
 19:46:01 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:46:01 -0700
In-Reply-To: <20260326014953.16727-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c49de9.050a0220.abc16.001c.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] INFO: task hung in btrfs_invalidate_folio (3)
From: syzbot <syzbot+63056bf627663701bbbf@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-230411-lists,stable=lfdr.de,63056bf627663701bbbf];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79ACD32E839
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in btrfs_invalidate_folio

INFO: task kworker/u8:7:151 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:7    state:D stack:21504 pid:151   tgid:151   ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: writeback wb_workfn (flush-btrfs-6)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5298 [inline]
 __schedule+0x1553/0x5240 kernel/sched/core.c:6911
 __schedule_loop kernel/sched/core.c:6993 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7008
 wait_extent_bit fs/btrfs/extent-io-tree.c:811 [inline]
 btrfs_lock_extent_bits+0x59c/0x700 fs/btrfs/extent-io-tree.c:1914
 btrfs_lock_extent fs/btrfs/extent-io-tree.h:152 [inline]
 btrfs_invalidate_folio+0x43d/0xc40 fs/btrfs/inode.c:7718
 extent_writepage fs/btrfs/extent_io.c:1852 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2580 [inline]
 btrfs_writepages+0x1369/0x24a0 fs/btrfs/extent_io.c:2746
 do_writepages+0x32e/0x550 mm/page-writeback.c:2554
 __writeback_single_inode+0x133/0x11a0 fs/fs-writeback.c:1750
 writeback_sb_inodes+0x995/0x19d0 fs/fs-writeback.c:2042
 wb_writeback+0x456/0xb70 fs/fs-writeback.c:2227
 wb_do_writeback fs/fs-writeback.c:2374 [inline]
 wb_workfn+0x41a/0xf60 fs/fs-writeback.c:2414
 process_one_work kernel/workqueue.c:3276 [inline]
 process_scheduled_works+0xb6e/0x18c0 kernel/workqueue.c:3359
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3440
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.0.22:6562 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.22        state:D stack:22752 pid:6562  tgid:6561  ppid:6245   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5298 [inline]
 __schedule+0x1553/0x5240 kernel/sched/core.c:6911
 __schedule_loop kernel/sched/core.c:6993 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7008
 wait_current_trans+0x39f/0x590 fs/btrfs/transaction.c:535
 start_transaction+0x6a7/0x1650 fs/btrfs/transaction.c:705
 clone_copy_inline_extent fs/btrfs/reflink.c:299 [inline]
 btrfs_clone+0x128a/0x24d0 fs/btrfs/reflink.c:529
 btrfs_clone_files+0x271/0x3f0 fs/btrfs/reflink.c:750
 btrfs_remap_file_range+0x76b/0x1320 fs/btrfs/reflink.c:903
 vfs_copy_file_range+0xda7/0x1390 fs/read_write.c:1600
 __do_sys_copy_file_range fs/read_write.c:1683 [inline]
 __se_sys_copy_file_range+0x2fb/0x480 fs/read_write.c:1650
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faf436fc799
RSP: 002b:00007faf42d56028 EFLAGS: 00000246 ORIG_RAX: 0000000000000146
RAX: ffffffffffffffda RBX: 00007faf43975fa0 RCX: 00007faf436fc799
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007faf43792c99 R08: 0000000000000863 R09: 0000000000000000
R10: 00002000000000c0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007faf43976038 R14: 00007faf43975fa0 R15: 00007fffc650d9b8
 </TASK>
INFO: task syz.0.22:6632 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.22        state:D stack:24736 pid:6632  tgid:6561  ppid:6245   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5298 [inline]
 __schedule+0x1553/0x5240 kernel/sched/core.c:6911
 __schedule_loop kernel/sched/core.c:6993 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7008
 wb_wait_for_completion+0x3e8/0x790 fs/fs-writeback.c:227
 __writeback_inodes_sb_nr+0x24c/0x2d0 fs/fs-writeback.c:2838
 try_to_writeback_inodes_sb+0x9a/0xc0 fs/fs-writeback.c:2886
 btrfs_start_delalloc_flush fs/btrfs/transaction.c:2175 [inline]
 btrfs_commit_transaction+0x82e/0x31a0 fs/btrfs/transaction.c:2364
 btrfs_ioctl+0xca7/0xd00 fs/btrfs/ioctl.c:5212
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faf436fc799
RSP: 002b:00007faf42d35028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007faf43976090 RCX: 00007faf436fc799
RDX: 0000000000000000 RSI: 0000000000009408 RDI: 0000000000000004
RBP: 00007faf43792c99 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007faf43976128 R14: 00007faf43976090 R15: 00007fffc650d9b8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/38:
 #0: ffffffff8ddcba00 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8ddcba00 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8ddcba00 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by kworker/u8:7/151:
 #0: ffff88801aac4138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3251 [inline]
 #0: ffff88801aac4138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0xa52/0x18c0 kernel/workqueue.c:3359
 #1: ffffc90003a97c40 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3252 [inline]
 #1: ffffc90003a97c40 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa8d/0x18c0 kernel/workqueue.c:3359
2 locks held by getty/5555:
 #0: ffff8880377e50a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e7e2e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x462/0x13c0 drivers/tty/n_tty.c:2211
3 locks held by syz-executor/6249:
4 locks held by syz.0.22/6562:
 #0: ffff8880625fe480 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2710 [inline]
 #0: ffff8880625fe480 (sb_writers#12){.+.+}-{0:0}, at: vfs_copy_file_range+0x9bb/0x1390 fs/read_write.c:1588
 #1: ffff888058eed8c8 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #1: ffff888058eed8c8 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: btrfs_inode_lock+0x51/0xe0 fs/btrfs/inode.c:369
 #2: ffff888058eed728 (&ei->i_mmap_lock){++++}-{4:4}, at: btrfs_inode_lock+0xcb/0xe0 fs/btrfs/inode.c:372
 #3: ffff8880625fe770 (sb_internal#2){.+.+}-{0:0}, at: clone_copy_inline_extent fs/btrfs/reflink.c:299 [inline]
 #3: ffff8880625fe770 (sb_internal#2){.+.+}-{0:0}, at: btrfs_clone+0x128a/0x24d0 fs/btrfs/reflink.c:529
3 locks held by syz.0.22/6632:
 #0: ffff888045007118 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x41b/0xc90 fs/btrfs/transaction.c:298
 #1: ffff888045007140 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x41b/0xc90 fs/btrfs/transaction.c:298
 #2: ffff8880625fe0d0 (&type->s_umount_key#56){++++}-{4:4}, at: try_to_writeback_inodes_sb+0x22/0xc0 fs/fs-writeback.c:2883
1 lock held by udevd/6608:
 #0: ffff8880226e58b0 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:1043 [inline]
 #0: ffff8880226e58b0 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: blkdev_read_iter+0x2ff/0x440 block/fops.c:854
1 lock held by btrfs-transacti/6627:
 #0: ffff888045004d98 (&fs_info->transaction_kthread_mutex){+.+.}-{4:4}, at: transaction_kthread+0xe4/0x450 fs/btrfs/disk-io.c:1515
2 locks held by syz.3.215/10113:
3 locks held by syz.5.214/10126:
3 locks held by syz.4.216/10132:
2 locks held by udevadm/10146:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 38 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xfd9/0x1030 kernel/hung_task.c:515
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 10146 Comm: udevadm Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:__lock_acquire+0xa9d/0x2cf0 kernel/locking/lockdep.c:5234
Code: fa 02 85 c0 74 1c 83 3d d4 21 ca 0d 00 75 13 48 8d 3d a7 32 cd 0d 48 c7 c6 65 71 67 8d 67 48 0f b9 3a 90 31 c0 48 83 78 40 00 <0f> 84 5a 1b 00 00 48 09 dd 41 8b 45 20 89 c1 81 e1 00 80 04 00 81
RSP: 0018:ffffc90006b9f6f8 EFLAGS: 00000082
RAX: ffffffff92f73c88 RBX: 00000000e60eadd5 RCX: 0000000010530efd
RDX: 000000005f479b93 RSI: 0000000099d18f2c RDI: ffff88802864db80
RBP: c57865e900000000 R08: ffffffff81767e65 R09: ffffffff8ddcba00
R10: ffffc90006b9f9d8 R11: ffffffff81af90c0 R12: ffff88802864e738
R13: ffff88802864e738 R14: ffff88802864db80 R15: 0000000000000000
FS:  00007f1e8ff33880(0000) GS:ffff888126339000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555d4ad6a5f8 CR3: 0000000064d0e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
 rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 rcu_read_lock include/linux/rcupdate.h:850 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1193 [inline]
 unwind_next_frame+0xc2/0x23c0 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kmem_cache_free+0x185/0x6b0 mm/slub.c:6295
 file_free fs/file_table.c:71 [inline]
 __fput+0x6d7/0xa90 fs/file_table.c:482
 fput_close_sync+0x11f/0x240 fs/file_table.c:574
 __do_sys_close fs/open.c:1509 [inline]
 __se_sys_close fs/open.c:1494 [inline]
 __x64_sys_close+0x7e/0x110 fs/open.c:1494
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1e9008fa67
Code: 44 00 00 48 83 ec 10 48 63 ff 45 31 c9 45 31 c0 6a 01 31 c9 e8 ca 19 f9 ff 48 83 c4 18 c3 0f 1f 44 00 00 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 61 b3 0d 00 f7 d8 64 89 02 b8
RSP: 002b:00007fff339659e8 EFLAGS: 00000297 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000555d4ad572a0 RCX: 00007f1e9008fa67
RDX: 00007f1e90169ea0 RSI: 0000555d4ad68be0 RDI: 0000000000000005
RBP: 00007f1e90169ff0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000000
R13: 3d45505954564544 R14: 3d5845444e494649 R15: 3d454d414e564544
 </TASK>


Tested on:

commit:         0138af24 Merge tag 'erofs-for-7.0-rc6-fixes' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1049a1d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27
dashboard link: https://syzkaller.appspot.com/bug?extid=63056bf627663701bbbf
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b16a06580000


