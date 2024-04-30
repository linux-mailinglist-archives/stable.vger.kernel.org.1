Return-Path: <stable+bounces-42176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CD08B71BC
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46DA81C224D6
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D27F12C530;
	Tue, 30 Apr 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uaClkFDe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499EF7464;
	Tue, 30 Apr 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474814; cv=none; b=HfqYCisWOve72nIfIZu9cyDiW2oF/ev9/ixT/8+8CSes4bydAMvnXS7DxTx5mgyFFFKSXunAdgEeBn4IQ65dqKWnaCKJ9A2RpRq/T3mqQH8Oo12BuwxZqAU+J6PzXIU9lVaf2oZ0+JfwyQaPMjN97LEIW39R6lsngVR61WlBLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474814; c=relaxed/simple;
	bh=rQxxVGW39TOdfMCHqD5Td8oIjpAaK782iO2crxgWhy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myjpn0e6Lz0mfakvFN4TERg0PBXmN+DTbsbrku3vGmdOomTGiepvAIkl14vgtaLI4ScZIALj31+cJAQbXI1KGoQTSNYsaSColSOptv+9ux2jpMv860pgxRyTzqKFU2O0ED8FS5Xl3eO4MqGTDl+jAitFkq4vjwcYybIYutmczas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uaClkFDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2C0C2BBFC;
	Tue, 30 Apr 2024 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474814;
	bh=rQxxVGW39TOdfMCHqD5Td8oIjpAaK782iO2crxgWhy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uaClkFDe/VQuI6/o06vcPp9exjkvhhkQ6ByhVMhErPr7lW/NtPiIk5D2zBG/Goaqj
	 CijA1W5AsLCMdNQvJziavno8mwVJI3n6YzosYcXtu+EsbOfbIWTxwjG6OV6bLToh+R
	 eE3X78jrqSCo/7eXKqjz7Ra7BeBUso7DyqtgtQiI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 007/138] xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING
Date: Tue, 30 Apr 2024 12:38:12 +0200
Message-ID: <20240430103049.641845071@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103049.422035273@linuxfoundation.org>
References: <20240430103049.422035273@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 237f3cf13b20db183d3706d997eedc3c49eacd44 ]

syzbot reported an illegal copy in xsk_setsockopt() [1]

Make sure to validate setsockopt() @optlen parameter.

[1]

 BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
 BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
 BUG: KASAN: slab-out-of-bounds in xsk_setsockopt+0x909/0xa40 net/xdp/xsk.c:1420
Read of size 4 at addr ffff888028c6cde3 by task syz-executor.0/7549

CPU: 0 PID: 7549 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  print_address_description mm/kasan/report.c:377 [inline]
  print_report+0x169/0x550 mm/kasan/report.c:488
  kasan_report+0x143/0x180 mm/kasan/report.c:601
  copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
  copy_from_sockptr include/linux/sockptr.h:55 [inline]
  xsk_setsockopt+0x909/0xa40 net/xdp/xsk.c:1420
  do_sock_setsockopt+0x3af/0x720 net/socket.c:2311
  __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
  __do_sys_setsockopt net/socket.c:2343 [inline]
  __se_sys_setsockopt net/socket.c:2340 [inline]
  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fb40587de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb40665a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007fb4059abf80 RCX: 00007fb40587de69
RDX: 0000000000000005 RSI: 000000000000011b RDI: 0000000000000006
RBP: 00007fb4058ca47a R08: 0000000000000002 R09: 0000000000000000
R10: 0000000020001980 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fb4059abf80 R15: 00007fff57ee4d08
 </TASK>

Allocated by task 7549:
  kasan_save_stack mm/kasan/common.c:47 [inline]
  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
  kasan_kmalloc include/linux/kasan.h:211 [inline]
  __do_kmalloc_node mm/slub.c:3966 [inline]
  __kmalloc+0x233/0x4a0 mm/slub.c:3979
  kmalloc include/linux/slab.h:632 [inline]
  __cgroup_bpf_run_filter_setsockopt+0xd2f/0x1040 kernel/bpf/cgroup.c:1869
  do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
  __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
  __do_sys_setsockopt net/socket.c:2343 [inline]
  __se_sys_setsockopt net/socket.c:2340 [inline]
  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff888028c6cde0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 1 bytes to the right of
 allocated 2-byte region [ffff888028c6cde0, ffff888028c6cde2)

The buggy address belongs to the physical page:
page:ffffea0000a31b00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888028c6c9c0 pfn:0x28c6c
anon flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c41280 0000000000000000 dead000000000001
raw: ffff888028c6c9c0 0000000080800057 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 6648, tgid 6644 (syz-executor.0), ts 133906047828, free_ts 133859922223
  set_page_owner include/linux/page_owner.h:31 [inline]
  post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
  prep_new_page mm/page_alloc.c:1540 [inline]
  get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
  __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
  __alloc_pages_node include/linux/gfp.h:238 [inline]
  alloc_pages_node include/linux/gfp.h:261 [inline]
  alloc_slab_page+0x5f/0x160 mm/slub.c:2175
  allocate_slab mm/slub.c:2338 [inline]
  new_slab+0x84/0x2f0 mm/slub.c:2391
  ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
  __slab_alloc mm/slub.c:3610 [inline]
  __slab_alloc_node mm/slub.c:3663 [inline]
  slab_alloc_node mm/slub.c:3835 [inline]
  __do_kmalloc_node mm/slub.c:3965 [inline]
  __kmalloc_node+0x2db/0x4e0 mm/slub.c:3973
  kmalloc_node include/linux/slab.h:648 [inline]
  __vmalloc_area_node mm/vmalloc.c:3197 [inline]
  __vmalloc_node_range+0x5f9/0x14a0 mm/vmalloc.c:3392
  __vmalloc_node mm/vmalloc.c:3457 [inline]
  vzalloc+0x79/0x90 mm/vmalloc.c:3530
  bpf_check+0x260/0x19010 kernel/bpf/verifier.c:21162
  bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
  __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
page last free pid 6650 tgid 6647 stack trace:
  reset_page_owner include/linux/page_owner.h:24 [inline]
  free_pages_prepare mm/page_alloc.c:1140 [inline]
  free_unref_page_prepare+0x95d/0xa80 mm/page_alloc.c:2346
  free_unref_page_list+0x5a3/0x850 mm/page_alloc.c:2532
  release_pages+0x2117/0x2400 mm/swap.c:1042
  tlb_batch_pages_flush mm/mmu_gather.c:98 [inline]
  tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
  tlb_flush_mmu+0x34d/0x4e0 mm/mmu_gather.c:300
  tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:392
  exit_mmap+0x4b6/0xd40 mm/mmap.c:3300
  __mmput+0x115/0x3c0 kernel/fork.c:1345
  exit_mm+0x220/0x310 kernel/exit.c:569
  do_exit+0x99e/0x27e0 kernel/exit.c:865
  do_group_exit+0x207/0x2c0 kernel/exit.c:1027
  get_signal+0x176e/0x1850 kernel/signal.c:2907
  arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
  exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
  __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
  syscall_exit_to_user_mode+0xc9/0x360 kernel/entry/common.c:212
  do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Memory state around the buggy address:
 ffff888028c6cc80: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff888028c6cd00: fa fc fc fc fa fc fc fc 00 fc fc fc 06 fc fc fc
>ffff888028c6cd80: fa fc fc fc fa fc fc fc fa fc fc fc 02 fc fc fc
                                                       ^
 ffff888028c6ce00: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff888028c6ce80: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc

Fixes: 423f38329d26 ("xsk: add umem fill queue support and mmap")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: "Björn Töpel" <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20240404202738.3634547-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index d04f91f4d09df..562d69f17b4c0 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -895,6 +895,8 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		struct xsk_queue **q;
 		int entries;
 
+		if (optlen < sizeof(entries))
+			return -EINVAL;
 		if (copy_from_sockptr(&entries, optval, sizeof(entries)))
 			return -EFAULT;
 
-- 
2.43.0




