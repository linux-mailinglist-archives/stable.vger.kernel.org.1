Return-Path: <stable+bounces-203146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C09ECD32FB
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 17:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE11530206BF
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289602D8792;
	Sat, 20 Dec 2025 16:00:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3E2D593E
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766246433; cv=none; b=TAwwoKfV62/BklxNbfXMz/nAL1AEFnKb+F+00LvQ12iKer/t4J5LMkEM8Oyfk1Rg/YO4kN+LHEaSdIop7dkaRxNXTKq3D9+lOXwqAq0swx7cSi5kDGVyUoIxtBSfXQQc3VQFqELzSJtVJoH9ghKWBfokDWdTOINuRvvZvteQ2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766246433; c=relaxed/simple;
	bh=1OL1eqj8HoVIjLIyUb30+BrxQWHr6UQhlRc7+uK2SjA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=X8/eZtqk/T4G29HviWn7MVHSnWGYEXVXMN7GdNB14MRO7z1lOH1bFuhZdFaBDIvPlwSb5B4Iwpka9ao0gfhzLN81bS/h1RuaDw6ArcXoUKdKwZNQ8ARehJZ05NVimpA+OF8dfQVlC1/eQQFA+nIZrkud5BTVY48J+fGLiM7TB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7c7542602a7so4964245a34.2
        for <stable@vger.kernel.org>; Sat, 20 Dec 2025 08:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766246430; x=1766851230;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7SqT+yNRhkPZ0TwvpPyQ7+AiEKwn1SwkM+MBUYkzeQ=;
        b=hsQwMzkSw/k34G+ARAyj3hV5Xlu1aVyEr7ZtfkZAbRelwTEVrmXpk+t0/uBzcAv/kc
         9LhhjRD3Sw2fACMgyVWdTZ46glGgof/8VESPP0SI26S44U1G9jfHFoSHvjARS3DYz6LX
         KA25RdT5SeGMdTm1OZULrfjQ4j1IEhsD0ER3WesPAydLVOb9KGP/CXTSjUQvBg+kagLs
         woVbNTZzQfnL7Jw7FTv4x9pdMowMz5IGkLYTUPNLX6JFPSfzEp9tALnTwFty7f/HexgB
         wiXllKmy5Af0ANO1Ho6RVsUAr0u6JT7gbZadYn86l39ZsdYOT+xP+c9V7nyH7yF6uKrJ
         gyjA==
X-Forwarded-Encrypted: i=1; AJvYcCUsL4qPmrwrTktmugoLTtvvxWpWNHh8327uh3wNdW/nXESSuvtCxtm+9/CnFYVJ3dXDeBTIOh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgbEq7cWf+8f0CHrtLLQs0lVWdWB5VB2LbzVcOmJxUd93NdNT
	L/te/Z1B4qJE/WZIoNTF59il4XG/xk4Yvh4NKLm3pvmfhgbwbfmH8GxTM+0GIEsWu2mBHoOH8CB
	bu7byPzbReFuh3tEAJTOkswr1bCd2UGkHaWY/YzTWBaRp2S7czNssMnXHxoo=
X-Google-Smtp-Source: AGHT+IFaLI8u4Bd7SjOx4K0e5dAzsFc4LnHQPEtoFG/dNplb1HXtK6D7L7lg+QRoNvgT7u2AjJ2sIE1Gi9xmr8EP3qinuZo259Nv
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1691:b0:659:9a49:8f6b with SMTP id
 006d021491bc7-65d0ea9a1e5mr2458037eaf.48.1766246430220; Sat, 20 Dec 2025
 08:00:30 -0800 (PST)
Date: Sat, 20 Dec 2025 08:00:30 -0800
In-Reply-To: <20251220110241.8435-1-ionut.nechita@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6946c81e.a70a0220.207337.013a.GAE@google.com>
Subject: [syzbot ci] Re: block/blk-mq: fix RT kernel performance regressions
From: syzbot ci <syzbot+ci366dec97baf89841@syzkaller.appspotmail.com>
To: axboe@kernel.dk, djiony2011@gmail.com, gregkh@linuxfoundation.org, 
	ionut.nechita@windriver.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, muchun.song@linux.dev, 
	sashal@kernel.org, stable@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] block/blk-mq: fix RT kernel performance regressions
https://lore.kernel.org/all/20251220110241.8435-1-ionut.nechita@windriver.com
* [PATCH 1/2] block/blk-mq: fix RT kernel regression with queue_lock in hot path
* [PATCH 2/2] block/blk-mq: convert blk_mq_cpuhp_lock to raw_spinlock for RT

and found the following issues:
* BUG: sleeping function called from invalid context in __cpuhp_state_add_instance
* BUG: sleeping function called from invalid context in __cpuhp_state_remove_instance

Full report is available here:
https://ci.syzbot.org/series/632f4721-6256-44fd-83f5-bf439d5f33f9

***

BUG: sleeping function called from invalid context in __cpuhp_state_add_instance

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      dd9b004b7ff3289fb7bae35130c0a5c0537266af
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/9ad1c682-13b1-4626-b61a-a2156384698d/config
C repro:   https://ci.syzbot.org/findings/f999a055-07f3-4d7a-acfd-8bc0be61e2ec/c_repro
syz repro: https://ci.syzbot.org/findings/f999a055-07f3-4d7a-acfd-8bc0be61e2ec/syz_repro

BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:51
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5982, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 UID: 0 PID: 5982 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x495/0x610 kernel/sched/core.c:8827
 percpu_down_read_internal include/linux/percpu-rwsem.h:51 [inline]
 percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
 cpus_read_lock+0x1b/0x160 kernel/cpu.c:491
 __cpuhp_state_add_instance+0x19/0x40 kernel/cpu.c:2454
 cpuhp_state_add_instance_nocalls include/linux/cpuhotplug.h:401 [inline]
 __blk_mq_add_cpuhp block/blk-mq.c:3858 [inline]
 blk_mq_add_hw_queues_cpuhp+0x19a/0x250 block/blk-mq.c:3906
 blk_mq_realloc_hw_ctxs block/blk-mq.c:4611 [inline]
 blk_mq_init_allocated_queue+0x366/0x1350 block/blk-mq.c:4635
 blk_mq_alloc_queue block/blk-mq.c:4416 [inline]
 __blk_mq_alloc_disk+0x1f0/0x340 block/blk-mq.c:4459
 loop_add+0x411/0xad0 drivers/block/loop.c:2050
 loop_control_ioctl+0x128/0x5a0 drivers/block/loop.c:2216
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1dc598f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff2134d08 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1dc5be5fa0 RCX: 00007f1dc598f7c9
RDX: 00000000004080f9 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007f1dc59f297f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1dc5be5fa0 R14: 00007f1dc5be5fa0 R15: 0000000000000003
 </TASK>


***

BUG: sleeping function called from invalid context in __cpuhp_state_remove_instance

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      dd9b004b7ff3289fb7bae35130c0a5c0537266af
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/9ad1c682-13b1-4626-b61a-a2156384698d/config
C repro:   https://ci.syzbot.org/findings/f39691bc-570a-4163-9791-31ce10e18fb6/c_repro
syz repro: https://ci.syzbot.org/findings/f39691bc-570a-4163-9791-31ce10e18fb6/syz_repro

BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:51
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5975, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 5975 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x495/0x610 kernel/sched/core.c:8827
 percpu_down_read_internal include/linux/percpu-rwsem.h:51 [inline]
 percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
 cpus_read_lock+0x1b/0x160 kernel/cpu.c:491
 __cpuhp_state_remove_instance+0x77/0x2e0 kernel/cpu.c:2565
 cpuhp_state_remove_instance_nocalls include/linux/cpuhotplug.h:502 [inline]
 __blk_mq_remove_cpuhp+0x140/0x1a0 block/blk-mq.c:3835
 blk_mq_remove_cpuhp block/blk-mq.c:3844 [inline]
 blk_mq_exit_hw_queues block/blk-mq.c:3974 [inline]
 blk_mq_exit_queue+0xe8/0x380 block/blk-mq.c:4670
 __del_gendisk+0x832/0x9e0 block/genhd.c:774
 del_gendisk+0xe8/0x160 block/genhd.c:823
 loop_remove+0x42/0xc0 drivers/block/loop.c:2121
 loop_control_remove drivers/block/loop.c:2180 [inline]
 loop_control_ioctl+0x4ac/0x5a0 drivers/block/loop.c:2218
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f911d78f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd4f0e1fb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f911d9e5fa0 RCX: 00007f911d78f7c9
RDX: 0000000000000006 RSI: 0000000000004c81 RDI: 0000000000000003
RBP: 00007f911d7f297f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f911d9e5fa0 R14: 00007f911d9e5fa0 R15: 0000000000000003
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

