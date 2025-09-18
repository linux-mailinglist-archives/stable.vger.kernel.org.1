Return-Path: <stable+bounces-168151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C09B2334E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B355E7A8809
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757502FF174;
	Tue, 12 Aug 2025 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ao0D+mb7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C0D2FE588;
	Tue, 12 Aug 2025 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023215; cv=none; b=RUPqSi0O7FGpj9CHrX5WKe6uD1a2obcfi+SfknTi4soE3vs3IQ8mPSD0OpLVmbt7Fl+ahjIdV09d/VwueLFbon8pM5vULn3hn46t7n6MBM8OZ38cUA8ApBU4JnxQmveAGnSY+4eXA8u16UqUlB4WNTybS4oePqRglGUH0jQl7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023215; c=relaxed/simple;
	bh=3Js755tg5S1AI3ho1msMhaoZlbpBVwj2nZMswmOOMJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZqiSQT/IpXfSSG3tFORtuOwhKWielhGvEysoVA+VAceoarxKJzGAxf9M2vZ6lmd3AWYwTJWb3VS/VmyNL1I2ElcBjmPD11g9TZkQkBcU7d4YqkG+LoqNdwU1tpXSsoDCnhHk5cnMzptCBTqJ+gKXw+I5qHaEFLDxJI62e3w9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ao0D+mb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A395C4CEF0;
	Tue, 12 Aug 2025 18:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023215;
	bh=3Js755tg5S1AI3ho1msMhaoZlbpBVwj2nZMswmOOMJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ao0D+mb7Exaqs/pr0pnQvo0WzIvPYlXLHE+2wOIrxmLljysGm+pgCuUMZfjHVTkdW
	 T8vgKFI2KSjDgRJUqv8UxOpf8aLhHcC0iIdRHZyHkoF7l+27maI2/kBwbqDt5x7Sln
	 yyc2l52k2feMfM7cmWL7UpoXj5rx9WlNfnZYOM9c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com,
	Yu Kuai <yukuai3@huawei.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 015/627] nbd: fix lockdep deadlock warning
Date: Tue, 12 Aug 2025 19:25:10 +0200
Message-ID: <20250812173419.902700321@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 8b428f42f3edfd62422aa7ad87049ab232a2eaa9 ]

nbd grabs device lock nbd->config_lock for updating nr_hw_queues, this
ways cause the following lock dependency:

-> #2 (&disk->open_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
       mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
       __del_gendisk+0x132/0xac6 block/genhd.c:706
       del_gendisk+0xf6/0x19a block/genhd.c:819
       nbd_dev_remove+0x3c/0xf2 drivers/block/nbd.c:268
       nbd_dev_remove_work+0x1c/0x26 drivers/block/nbd.c:284
       process_one_work+0x96a/0x1f32 kernel/workqueue.c:3238
       process_scheduled_works kernel/workqueue.c:3321 [inline]
       worker_thread+0x5ce/0xde8 kernel/workqueue.c:3402
       kthread+0x39c/0x7d4 kernel/kthread.c:464
       ret_from_fork_kernel+0x2a/0xbb2 arch/riscv/kernel/process.c:214
       ret_from_fork_kernel_asm+0x16/0x18 arch/riscv/kernel/entry.S:327

-> #1 (&set->update_nr_hwq_lock){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       down_write+0x9c/0x19a kernel/locking/rwsem.c:1577
       blk_mq_update_nr_hw_queues+0x3e/0xb86 block/blk-mq.c:5041
       nbd_start_device+0x140/0xb2c drivers/block/nbd.c:1476
       nbd_genl_connect+0xae0/0x1b24 drivers/block/nbd.c:2201
       genl_family_rcv_msg_doit+0x206/0x2e6 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x514/0x78e net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x206/0x3be net/netlink/af_netlink.c:2534
       genl_rcv+0x36/0x4c net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x4f0/0x82c net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x85e/0xdd6 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:712 [inline]
       __sock_sendmsg+0xcc/0x160 net/socket.c:727
       ____sys_sendmsg+0x63e/0x79c net/socket.c:2566
       ___sys_sendmsg+0x144/0x1e6 net/socket.c:2620
       __sys_sendmsg+0x188/0x246 net/socket.c:2652
       __do_sys_sendmsg net/socket.c:2657 [inline]
       __se_sys_sendmsg net/socket.c:2655 [inline]
       __riscv_sys_sendmsg+0x70/0xa2 net/socket.c:2655
       syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
       do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:341
       handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197

-> #0 (&nbd->config_lock){+.+.}-{4:4}:
       check_noncircular+0x132/0x146 kernel/locking/lockdep.c:2178
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x12b2/0x24ea kernel/locking/lockdep.c:5240
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
       mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
       refcount_dec_and_mutex_lock+0x60/0xd8 lib/refcount.c:118
       nbd_config_put+0x3a/0x610 drivers/block/nbd.c:1423
       nbd_release+0x94/0x15c drivers/block/nbd.c:1735
       blkdev_put_whole+0xac/0xee block/bdev.c:721
       bdev_release+0x3fe/0x600 block/bdev.c:1144
       blkdev_release+0x1a/0x26 block/fops.c:684
       __fput+0x382/0xa8c fs/file_table.c:465
       ____fput+0x1c/0x26 fs/file_table.c:493
       task_work_run+0x16a/0x25e kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop+0x118/0x134 kernel/entry/common.c:114
       exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
       syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
       do_trap_ecall_u+0x3f0/0x530 arch/riscv/kernel/traps.c:355
       handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197

Also it isn't necessary to require nbd->config_lock, because
blk_mq_update_nr_hw_queues() does grab tagset lock for sync everything.

Fixes the issue by releasing ->config_lock & retry in case of concurrent
updating nr_hw_queues.

Fixes: 98e68f67020c ("block: prevent adding/deleting disk during updating nr_hw_queues")
Reported-by: syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6855034f.a00a0220.137b3.0031.GAE@google.com
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Link: https://lore.kernel.org/r/20250709111744.2353050-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2592bd19ebc1..6463d0e8d0ce 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1473,7 +1473,17 @@ static int nbd_start_device(struct nbd_device *nbd)
 		return -EINVAL;
 	}
 
-	blk_mq_update_nr_hw_queues(&nbd->tag_set, config->num_connections);
+retry:
+	mutex_unlock(&nbd->config_lock);
+	blk_mq_update_nr_hw_queues(&nbd->tag_set, num_connections);
+	mutex_lock(&nbd->config_lock);
+
+	/* if another code path updated nr_hw_queues, retry until succeed */
+	if (num_connections != config->num_connections) {
+		num_connections = config->num_connections;
+		goto retry;
+	}
+
 	nbd->pid = task_pid_nr(current);
 
 	nbd_parse_flags(nbd);
-- 
2.39.5




