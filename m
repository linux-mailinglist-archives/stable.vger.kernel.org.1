Return-Path: <stable+bounces-93353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78559CD8C3
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4907EB260B4
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76AF186294;
	Fri, 15 Nov 2024 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ALGQrao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C62BB1B;
	Fri, 15 Nov 2024 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653637; cv=none; b=t/O0mYddjzv5J/pPvhx8ozbD56QzyMyQOCn6dePNtH08o5K5Iff/Cq1RtsbyJHlxpV2t4paPmSqF0407NMb2NT72SM2V867r+juOCuZD/qS0qutNJKJ03wrIw26JXiVUjmW1FumoN4kTejbwLGJVH1E6nTmYlyHduEj8MWSmtH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653637; c=relaxed/simple;
	bh=4pCU5IeOGGxg1VBSJaP+CA4BAWmyCyX9XQPtjHofC+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtWhQplG3Fu2cL/e9r6vZ1OalCuR/q4H3zAGlnN1vjgVVvBUJMo/hnRwluTHivHPDYIJS06RsTG98XDwS9rdSLFBz+Lwg+RJZcR46VWIkWyNLMgmmv48TB/VhiwF8bUgcMC5iOaY6Do9dANvdY08nwxeqaIUtKiWldaCrloGtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ALGQrao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BFCC4CED0;
	Fri, 15 Nov 2024 06:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653637;
	bh=4pCU5IeOGGxg1VBSJaP+CA4BAWmyCyX9XQPtjHofC+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1ALGQraop1wlgvv3fi18R5XZZmb+Rop6qFDNPZJIQDPMVGPvbxUvXRmnPjWxqbID2
	 FyynW/kzIVT41+HrlaIp5FmWxfxWRl+JDDHpfYoIhyhhBc0FpIr8h72YBtb/v94HcW
	 cf9hNc/Lh86R6uT+a88P6vfzXsAD5gvCy2TqWNGE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 08/39] nvme: tcp: avoid race between queue_lock lock and destroy
Date: Fri, 15 Nov 2024 07:38:18 +0100
Message-ID: <20241115063722.910540713@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.599985562@linuxfoundation.org>
References: <20241115063722.599985562@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 782373ba27660ba7d330208cf5509ece6feb4545 ]

Commit 76d54bf20cdc ("nvme-tcp: don't access released socket during
error recovery") added a mutex_lock() call for the queue->queue_lock
in nvme_tcp_get_address(). However, the mutex_lock() races with
mutex_destroy() in nvme_tcp_free_queue(), and causes the WARN below.

DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 3 PID: 34077 at kernel/locking/mutex.c:587 __mutex_lock+0xcf0/0x1220
Modules linked in: nvmet_tcp nvmet nvme_tcp nvme_fabrics iw_cm ib_cm ib_core pktcdvd nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr sunrpc ppdev 9pnet_virtio 9pnet pcspkr netfs parport_pc parport e1000 i2c_piix4 i2c_smbus loop fuse nfnetlink zram bochs drm_vram_helper drm_ttm_helper ttm drm_kms_helper xfs drm sym53c8xx floppy nvme scsi_transport_spi nvme_core nvme_auth serio_raw ata_generic pata_acpi dm_multipath qemu_fw_cfg [last unloaded: ib_uverbs]
CPU: 3 UID: 0 PID: 34077 Comm: udisksd Not tainted 6.11.0-rc7 #319
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
RIP: 0010:__mutex_lock+0xcf0/0x1220
Code: 08 84 d2 0f 85 c8 04 00 00 8b 15 ef b6 c8 01 85 d2 0f 85 78 f4 ff ff 48 c7 c6 20 93 ee af 48 c7 c7 60 91 ee af e8 f0 a7 6d fd <0f> 0b e9 5e f4 ff ff 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1
RSP: 0018:ffff88811305f760 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88812c652058 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff88811305f8b0 R08: 0000000000000001 R09: ffffed1075c36341
R10: ffff8883ae1b1a0b R11: 0000000000010498 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88812c652058
FS:  00007f9713ae4980(0000) GS:ffff8883ae180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcd78483c7c CR3: 0000000122c38000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __warn.cold+0x5b/0x1af
 ? __mutex_lock+0xcf0/0x1220
 ? report_bug+0x1ec/0x390
 ? handle_bug+0x3c/0x80
 ? exc_invalid_op+0x13/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? __mutex_lock+0xcf0/0x1220
 ? nvme_tcp_get_address+0xc2/0x1e0 [nvme_tcp]
 ? __pfx___mutex_lock+0x10/0x10
 ? __lock_acquire+0xd6a/0x59e0
 ? nvme_tcp_get_address+0xc2/0x1e0 [nvme_tcp]
 nvme_tcp_get_address+0xc2/0x1e0 [nvme_tcp]
 ? __pfx_nvme_tcp_get_address+0x10/0x10 [nvme_tcp]
 nvme_sysfs_show_address+0x81/0xc0 [nvme_core]
 dev_attr_show+0x42/0x80
 ? __asan_memset+0x1f/0x40
 sysfs_kf_seq_show+0x1f0/0x370
 seq_read_iter+0x2cb/0x1130
 ? rw_verify_area+0x3b1/0x590
 ? __mutex_lock+0x433/0x1220
 vfs_read+0x6a6/0xa20
 ? lockdep_hardirqs_on+0x78/0x100
 ? __pfx_vfs_read+0x10/0x10
 ksys_read+0xf7/0x1d0
 ? __pfx_ksys_read+0x10/0x10
 ? __x64_sys_openat+0x105/0x1d0
 do_syscall_64+0x93/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? __pfx_ksys_read+0x10/0x10
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? do_syscall_64+0x9f/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f9713f55cfa
Code: 55 48 89 e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8 e8 e8 74 f8 ff 48 8b 55 e8 48 8b 75 f0 41 89 c0 8b 7d f8 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 2e 44 89 c7 48 89 45 f8 e8 42 75 f8 ff 48 8b
RSP: 002b:00007ffd7f512e70 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055c38f316859 RCX: 00007f9713f55cfa
RDX: 0000000000000fff RSI: 00007ffd7f512eb0 RDI: 0000000000000011
RBP: 00007ffd7f512e90 R08: 0000000000000000 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 000055c38f317148
R13: 0000000000000000 R14: 00007f96f4004f30 R15: 000055c3b6b623c0
 </TASK>

The WARN is observed when the blktests test case nvme/014 is repeated
with tcp transport. It is rare, and 200 times repeat is required to
recreate in some test environments.

To avoid the WARN, check the NVME_TCP_Q_LIVE flag before locking
queue->queue_lock. The flag is cleared long time before the lock gets
destroyed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f2fedd25915f9..29489c2c52fb9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2495,10 +2495,11 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 
 	len = nvmf_get_address(ctrl, buf, size);
 
+	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		return len;
+
 	mutex_lock(&queue->queue_lock);
 
-	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
-		goto done;
 	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
 	if (ret > 0) {
 		if (len > 0)
@@ -2506,7 +2507,7 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 		len += scnprintf(buf + len, size - len, "%ssrc_addr=%pISc\n",
 				(len) ? "," : "", &src_addr);
 	}
-done:
+
 	mutex_unlock(&queue->queue_lock);
 
 	return len;
-- 
2.43.0




