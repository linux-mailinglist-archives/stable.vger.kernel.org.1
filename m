Return-Path: <stable+bounces-44860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E438C54BA
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9658228A3A3
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9669312E1DF;
	Tue, 14 May 2024 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1iNMf6Nr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D354903;
	Tue, 14 May 2024 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687386; cv=none; b=tpVr6567FVdZKHJZqDy6xvhfuk0DYM5/bdWU/ZVcP8jW5YXrvS9690t8eOHxu7U/ahEBPKKj9oytzuIKVigAUmtqutyMxzAlY75T1RncooebvAXwMn2VwS8gx49VHnYjHZi9Uec/Tf5wDDCczsz437sYQpMLJ/pzV5X1KbiZSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687386; c=relaxed/simple;
	bh=3SBNEUDi19zXf8A1hSae9Xf31OW3y3d6Dyfk1RHRy1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIOuFXaiXirA+hMsaUTtqN1PA5/WRsnR6+hyHURhVnIarVYlPcgiyPPHpmAVZz5ndVWuvzdLfxdReksHyzqfi8tU2f0DCb8w7cmVNV6WvVUINT3yW2NCFAvBi7mUjchKuYB9a8WVZCAtyNtoqEgFPXe6wu46jJEAClo2eNBMZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1iNMf6Nr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D28C2BD10;
	Tue, 14 May 2024 11:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687386;
	bh=3SBNEUDi19zXf8A1hSae9Xf31OW3y3d6Dyfk1RHRy1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1iNMf6NrIraK5fB84EJWFJQfcMtWD12diruHlRyHZ3pFxoDOmsG9uU9g8N3EZoWBe
	 IAtRTsjNFS3AHs1COZ74/vQRUKyPn2fOT9FieE68UmZR760tqkxCuSijxnEjPxTQTd
	 2Ar5F/uSvEeuW4IX+iXR5JCrMzYzZ+21R8+GKt+E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Duoming Zhou <duoming@zju.edu.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 078/111] Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout
Date: Tue, 14 May 2024 12:20:16 +0200
Message-ID: <20240514101000.097503452@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
References: <20240514100957.114746054@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 483bc08181827fc475643272ffb69c533007e546 ]

When the sco connection is established and then, the sco socket
is releasing, timeout_work will be scheduled to judge whether
the sco disconnection is timeout. The sock will be deallocated
later, but it is dereferenced again in sco_sock_timeout. As a
result, the use-after-free bugs will happen. The root cause is
shown below:

    Cleanup Thread               |      Worker Thread
sco_sock_release                 |
  sco_sock_close                 |
    __sco_sock_close             |
      sco_sock_set_timer         |
        schedule_delayed_work    |
  sco_sock_kill                  |    (wait a time)
    sock_put(sk) //FREE          |  sco_sock_timeout
                                 |    sock_hold(sk) //USE

The KASAN report triggered by POC is shown below:

[   95.890016] ==================================================================
[   95.890496] BUG: KASAN: slab-use-after-free in sco_sock_timeout+0x5e/0x1c0
[   95.890755] Write of size 4 at addr ffff88800c388080 by task kworker/0:0/7
...
[   95.890755] Workqueue: events sco_sock_timeout
[   95.890755] Call Trace:
[   95.890755]  <TASK>
[   95.890755]  dump_stack_lvl+0x45/0x110
[   95.890755]  print_address_description+0x78/0x390
[   95.890755]  print_report+0x11b/0x250
[   95.890755]  ? __virt_addr_valid+0xbe/0xf0
[   95.890755]  ? sco_sock_timeout+0x5e/0x1c0
[   95.890755]  kasan_report+0x139/0x170
[   95.890755]  ? update_load_avg+0xe5/0x9f0
[   95.890755]  ? sco_sock_timeout+0x5e/0x1c0
[   95.890755]  kasan_check_range+0x2c3/0x2e0
[   95.890755]  sco_sock_timeout+0x5e/0x1c0
[   95.890755]  process_one_work+0x561/0xc50
[   95.890755]  worker_thread+0xab2/0x13c0
[   95.890755]  ? pr_cont_work+0x490/0x490
[   95.890755]  kthread+0x279/0x300
[   95.890755]  ? pr_cont_work+0x490/0x490
[   95.890755]  ? kthread_blkcg+0xa0/0xa0
[   95.890755]  ret_from_fork+0x34/0x60
[   95.890755]  ? kthread_blkcg+0xa0/0xa0
[   95.890755]  ret_from_fork_asm+0x11/0x20
[   95.890755]  </TASK>
[   95.890755]
[   95.890755] Allocated by task 506:
[   95.890755]  kasan_save_track+0x3f/0x70
[   95.890755]  __kasan_kmalloc+0x86/0x90
[   95.890755]  __kmalloc+0x17f/0x360
[   95.890755]  sk_prot_alloc+0xe1/0x1a0
[   95.890755]  sk_alloc+0x31/0x4e0
[   95.890755]  bt_sock_alloc+0x2b/0x2a0
[   95.890755]  sco_sock_create+0xad/0x320
[   95.890755]  bt_sock_create+0x145/0x320
[   95.890755]  __sock_create+0x2e1/0x650
[   95.890755]  __sys_socket+0xd0/0x280
[   95.890755]  __x64_sys_socket+0x75/0x80
[   95.890755]  do_syscall_64+0xc4/0x1b0
[   95.890755]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   95.890755]
[   95.890755] Freed by task 506:
[   95.890755]  kasan_save_track+0x3f/0x70
[   95.890755]  kasan_save_free_info+0x40/0x50
[   95.890755]  poison_slab_object+0x118/0x180
[   95.890755]  __kasan_slab_free+0x12/0x30
[   95.890755]  kfree+0xb2/0x240
[   95.890755]  __sk_destruct+0x317/0x410
[   95.890755]  sco_sock_release+0x232/0x280
[   95.890755]  sock_close+0xb2/0x210
[   95.890755]  __fput+0x37f/0x770
[   95.890755]  task_work_run+0x1ae/0x210
[   95.890755]  get_signal+0xe17/0xf70
[   95.890755]  arch_do_signal_or_restart+0x3f/0x520
[   95.890755]  syscall_exit_to_user_mode+0x55/0x120
[   95.890755]  do_syscall_64+0xd1/0x1b0
[   95.890755]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   95.890755]
[   95.890755] The buggy address belongs to the object at ffff88800c388000
[   95.890755]  which belongs to the cache kmalloc-1k of size 1024
[   95.890755] The buggy address is located 128 bytes inside of
[   95.890755]  freed 1024-byte region [ffff88800c388000, ffff88800c388400)
[   95.890755]
[   95.890755] The buggy address belongs to the physical page:
[   95.890755] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88800c38a800 pfn:0xc388
[   95.890755] head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   95.890755] anon flags: 0x100000000000840(slab|head|node=0|zone=1)
[   95.890755] page_type: 0xffffffff()
[   95.890755] raw: 0100000000000840 ffff888006842dc0 0000000000000000 0000000000000001
[   95.890755] raw: ffff88800c38a800 000000000010000a 00000001ffffffff 0000000000000000
[   95.890755] head: 0100000000000840 ffff888006842dc0 0000000000000000 0000000000000001
[   95.890755] head: ffff88800c38a800 000000000010000a 00000001ffffffff 0000000000000000
[   95.890755] head: 0100000000000003 ffffea000030e201 ffffea000030e248 00000000ffffffff
[   95.890755] head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
[   95.890755] page dumped because: kasan: bad access detected
[   95.890755]
[   95.890755] Memory state around the buggy address:
[   95.890755]  ffff88800c387f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   95.890755]  ffff88800c388000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   95.890755] >ffff88800c388080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   95.890755]                    ^
[   95.890755]  ffff88800c388100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   95.890755]  ffff88800c388180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   95.890755] ==================================================================

Fix this problem by adding a check protected by sco_conn_lock to judget
whether the conn->hcon is null. Because the conn->hcon will be set to null,
when the sock is releasing.

Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_work")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/sco.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 2115ca6d7e178..ae788d3e0c53a 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -83,6 +83,10 @@ static void sco_sock_timeout(struct work_struct *work)
 	struct sock *sk;
 
 	sco_conn_lock(conn);
+	if (!conn->hcon) {
+		sco_conn_unlock(conn);
+		return;
+	}
 	sk = conn->sk;
 	if (sk)
 		sock_hold(sk);
-- 
2.43.0




