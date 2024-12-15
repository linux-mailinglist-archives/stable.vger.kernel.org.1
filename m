Return-Path: <stable+bounces-104266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16E59F22BE
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0411886A1E
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D6A13E043;
	Sun, 15 Dec 2024 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G00Io4Kx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250413D28F
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734253015; cv=none; b=DyKtIHygE6hZ9co/XD8jTa2gYBrGJYFL3CZjSesvdOGTCToPwNjyvQeewUiATcutu3ppyhJy+PTn3MvOHD7ZOqeYKu504cosVmxQgSMMSf8dlrBkkIRkJl6v9WwvFRcYohRvSDDo+gYyZb4NjUOZOwK4PWuUVlor/XHLBi5XHeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734253015; c=relaxed/simple;
	bh=LM2SpLYQaWBuEI6jEB+juctbH9X2eu0G3xGZf9DDJEU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HEbac0ssS3VpUVyx03HDV9Lz5oA3UjH8Y3CaKrAxH7p6kX5DXmeypllHCKahhaU7zLGJaXD8MRB0spLNVrED+E8FL/KD5Hfco03z0Azltc15PUSHkyI4KAo9leRu9ModUYOs0+xaw45WG3EBbFp/l+gohJ7ZzFhD2LvDmhShh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G00Io4Kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646BEC4CECE;
	Sun, 15 Dec 2024 08:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734253014;
	bh=LM2SpLYQaWBuEI6jEB+juctbH9X2eu0G3xGZf9DDJEU=;
	h=Subject:To:Cc:From:Date:From;
	b=G00Io4Kx1Ct7z3r7Lxtwa3Vx8T/Ufu1UJvNfV1kGqx3NU0hp6jcUnjjiLwSEcgFSf
	 klVG8CEvY2oEIU5DE4FkK3D3rA9u/2i/BO0kYAlzpxtUhUP66JfxCCmoFmNJcscgNu
	 kTvcvK5vuy7OUJkC1xYd7z3/S1OZ2j8asRtWd874=
Subject: FAILED: patch "[PATCH] bpf, sockmap: Fix race between element replace and close()" failed to apply to 6.1-stable tree
To: mhal@rbox.co,daniel@iogearbox.net,john.fastabend@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:56:51 +0100
Message-ID: <2024121551-chasing-tilt-a0c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ed1fc5d76b81a4d681211333c026202cad4d5649
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121551-chasing-tilt-a0c8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ed1fc5d76b81a4d681211333c026202cad4d5649 Mon Sep 17 00:00:00 2001
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 2 Dec 2024 12:29:25 +0100
Subject: [PATCH] bpf, sockmap: Fix race between element replace and close()

Element replace (with a socket different from the one stored) may race
with socket's close() link popping & unlinking. __sock_map_delete()
unconditionally unrefs the (wrong) element:

// set map[0] = s0
map_update_elem(map, 0, s0)

// drop fd of s0
close(s0)
  sock_map_close()
    lock_sock(sk)               (s0!)
    sock_map_remove_links(sk)
      link = sk_psock_link_pop()
      sock_map_unlink(sk, link)
        sock_map_delete_from_link
                                        // replace map[0] with s1
                                        map_update_elem(map, 0, s1)
                                          sock_map_update_elem
                                (s1!)       lock_sock(sk)
                                            sock_map_update_common
                                              psock = sk_psock(sk)
                                              spin_lock(&stab->lock)
                                              osk = stab->sks[idx]
                                              sock_map_add_link(..., &stab->sks[idx])
                                              sock_map_unref(osk, &stab->sks[idx])
                                                psock = sk_psock(osk)
                                                sk_psock_put(sk, psock)
                                                  if (refcount_dec_and_test(&psock))
                                                    sk_psock_drop(sk, psock)
                                              spin_unlock(&stab->lock)
                                            unlock_sock(sk)
          __sock_map_delete
            spin_lock(&stab->lock)
            sk = *psk                        // s1 replaced s0; sk == s1
            if (!sk_test || sk_test == sk)   // sk_test (s0) != sk (s1); no branch
              sk = xchg(psk, NULL)
            if (sk)
              sock_map_unref(sk, psk)        // unref s1; sks[idx] will dangle
                psock = sk_psock(sk)
                sk_psock_put(sk, psock)
                  if (refcount_dec_and_test())
                    sk_psock_drop(sk, psock)
            spin_unlock(&stab->lock)
    release_sock(sk)

Then close(map) enqueues bpf_map_free_deferred, which finally calls
sock_map_free(). This results in some refcount_t warnings along with
a KASAN splat [1].

Fix __sock_map_delete(), do not allow sock_map_unref() on elements that
may have been replaced.

[1]:
BUG: KASAN: slab-use-after-free in sock_map_free+0x10e/0x330
Write of size 4 at addr ffff88811f5b9100 by task kworker/u64:12/1063

CPU: 14 UID: 0 PID: 1063 Comm: kworker/u64:12 Not tainted 6.12.0+ #125
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Workqueue: events_unbound bpf_map_free_deferred
Call Trace:
 <TASK>
 dump_stack_lvl+0x68/0x90
 print_report+0x174/0x4f6
 kasan_report+0xb9/0x190
 kasan_check_range+0x10f/0x1e0
 sock_map_free+0x10e/0x330
 bpf_map_free_deferred+0x173/0x320
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 1202:
 kasan_save_stack+0x1e/0x40
 kasan_save_track+0x10/0x30
 __kasan_slab_alloc+0x85/0x90
 kmem_cache_alloc_noprof+0x131/0x450
 sk_prot_alloc+0x5b/0x220
 sk_alloc+0x2c/0x870
 unix_create1+0x88/0x8a0
 unix_create+0xc5/0x180
 __sock_create+0x241/0x650
 __sys_socketpair+0x1ce/0x420
 __x64_sys_socketpair+0x92/0x100
 do_syscall_64+0x93/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 46:
 kasan_save_stack+0x1e/0x40
 kasan_save_track+0x10/0x30
 kasan_save_free_info+0x37/0x60
 __kasan_slab_free+0x4b/0x70
 kmem_cache_free+0x1a1/0x590
 __sk_destruct+0x388/0x5a0
 sk_psock_destroy+0x73e/0xa50
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30

The buggy address belongs to the object at ffff88811f5b9080
 which belongs to the cache UNIX-STREAM of size 1984
The buggy address is located 128 bytes inside of
 freed 1984-byte region [ffff88811f5b9080, ffff88811f5b9840)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11f5b8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888127d49401
flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
page_type: f5(slab)
raw: 0017ffffc0000040 ffff8881042e4500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800f000f 00000001f5000000 ffff888127d49401
head: 0017ffffc0000040 ffff8881042e4500 dead000000000122 0000000000000000
head: 0000000000000000 00000000800f000f 00000001f5000000 ffff888127d49401
head: 0017ffffc0000003 ffffea00047d6e01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88811f5b9000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88811f5b9080: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88811f5b9180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88811f5b9200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Disabling lock debugging due to kernel taint

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 14 PID: 1063 at lib/refcount.c:25 refcount_warn_saturate+0xce/0x150
CPU: 14 UID: 0 PID: 1063 Comm: kworker/u64:12 Tainted: G    B              6.12.0+ #125
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Workqueue: events_unbound bpf_map_free_deferred
RIP: 0010:refcount_warn_saturate+0xce/0x150
Code: 34 73 eb 03 01 e8 82 53 ad fe 0f 0b eb b1 80 3d 27 73 eb 03 00 75 a8 48 c7 c7 80 bd 95 84 c6 05 17 73 eb 03 01 e8 62 53 ad fe <0f> 0b eb 91 80 3d 06 73 eb 03 00 75 88 48 c7 c7 e0 bd 95 84 c6 05
RSP: 0018:ffff88815c49fc70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88811f5b9100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed10bcde6349
R10: ffff8885e6f31a4b R11: 0000000000000000 R12: ffff88813be0b000
R13: ffff88811f5b9100 R14: ffff88811f5b9080 R15: ffff88813be0b024
FS:  0000000000000000(0000) GS:ffff8885e6f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dda99b0250 CR3: 000000015dbac000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn.cold+0x5f/0x1ff
 ? refcount_warn_saturate+0xce/0x150
 ? report_bug+0x1ec/0x390
 ? handle_bug+0x58/0x90
 ? exc_invalid_op+0x13/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? refcount_warn_saturate+0xce/0x150
 sock_map_free+0x2e5/0x330
 bpf_map_free_deferred+0x173/0x320
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>
irq event stamp: 10741
hardirqs last  enabled at (10741): [<ffffffff84400ec6>] asm_sysvec_apic_timer_interrupt+0x16/0x20
hardirqs last disabled at (10740): [<ffffffff811e532d>] handle_softirqs+0x60d/0x770
softirqs last  enabled at (10506): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210
softirqs last disabled at (10301): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210

refcount_t: underflow; use-after-free.
WARNING: CPU: 14 PID: 1063 at lib/refcount.c:28 refcount_warn_saturate+0xee/0x150
CPU: 14 UID: 0 PID: 1063 Comm: kworker/u64:12 Tainted: G    B   W          6.12.0+ #125
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Workqueue: events_unbound bpf_map_free_deferred
RIP: 0010:refcount_warn_saturate+0xee/0x150
Code: 17 73 eb 03 01 e8 62 53 ad fe 0f 0b eb 91 80 3d 06 73 eb 03 00 75 88 48 c7 c7 e0 bd 95 84 c6 05 f6 72 eb 03 01 e8 42 53 ad fe <0f> 0b e9 6e ff ff ff 80 3d e6 72 eb 03 00 0f 85 61 ff ff ff 48 c7
RSP: 0018:ffff88815c49fc70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88811f5b9100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: 0000000000000003 R08: 0000000000000001 R09: ffffed10bcde6349
R10: ffff8885e6f31a4b R11: 0000000000000000 R12: ffff88813be0b000
R13: ffff88811f5b9100 R14: ffff88811f5b9080 R15: ffff88813be0b024
FS:  0000000000000000(0000) GS:ffff8885e6f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dda99b0250 CR3: 000000015dbac000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn.cold+0x5f/0x1ff
 ? refcount_warn_saturate+0xee/0x150
 ? report_bug+0x1ec/0x390
 ? handle_bug+0x58/0x90
 ? exc_invalid_op+0x13/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? refcount_warn_saturate+0xee/0x150
 sock_map_free+0x2d3/0x330
 bpf_map_free_deferred+0x173/0x320
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>
irq event stamp: 10741
hardirqs last  enabled at (10741): [<ffffffff84400ec6>] asm_sysvec_apic_timer_interrupt+0x16/0x20
hardirqs last disabled at (10740): [<ffffffff811e532d>] handle_softirqs+0x60d/0x770
softirqs last  enabled at (10506): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210
softirqs last disabled at (10301): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20241202-sockmap-replace-v1-3-1e88579e7bd5@rbox.co

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 20b348b1964a..f1b9b3958792 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -412,12 +412,11 @@ static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
 static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 			     struct sock **psk)
 {
-	struct sock *sk;
+	struct sock *sk = NULL;
 	int err = 0;
 
 	spin_lock_bh(&stab->lock);
-	sk = *psk;
-	if (!sk_test || sk_test == sk)
+	if (!sk_test || sk_test == *psk)
 		sk = xchg(psk, NULL);
 
 	if (likely(sk))


