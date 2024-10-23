Return-Path: <stable+bounces-87891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CFA9ACCF6
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537831C217D3
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DCD209F49;
	Wed, 23 Oct 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkPGN1ya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E009209F3B;
	Wed, 23 Oct 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693928; cv=none; b=PsF1RanL48qDKuMzKFkUWIL1tW+C3WzhblD2lnARweoOfDRz1AEqB5xqNiKzRUQ3KB9KndaOtgIwu19CgKkd4eyq5vDR7W1IDV5zo924Tj6SQnQiNrwSXlbBm8hrOmeu187D0LI+xZ1iCv6mq3KW5NEipixhuJD/RxddUZGm7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693928; c=relaxed/simple;
	bh=ilaWD8z20awFYSjc+Et8Z4DRgB0c74MXaUbpcjTL/9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5iN9iciJ/LU32hJ3EsOUjEcFVZmNBn5JDi6dfuPS/eR/WaVu99+kTrY8MAD/1leWSRur2zcMZ0O2kCxxtZ9M9AQB9PMrAP+KzlHqv6G7k6Cs1aNF5zk/cqwLUBjrAuayz/Va00KWj1zCBIUPCt4MjDOhQoW/qgepSXD6r5Ziu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkPGN1ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74A3C4CEE5;
	Wed, 23 Oct 2024 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693927;
	bh=ilaWD8z20awFYSjc+Et8Z4DRgB0c74MXaUbpcjTL/9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkPGN1yag+azFsq4JBcPTvmlqV7t7aQ9CzKOrDDgVTZ+22NUGcK8lX3ApGsNacut5
	 S9U5KwClnz/C7hVDA1kQzLVoHQrWP/yakhlJg/bftZCAYiLZaJODGipPotQx4UBScL
	 ZLTJF4mBVFh+oc6lTHJkE5Nf/VsBTM4+6NpmnZYHSqxfs6sWi90mMB9gSYnJ22WJul
	 EOBdFo1WKjkug2Eu1+mMkRXysXC/23o3sjP9v4HmYIuGpFRdlKHzt8obPpDEYxCxdX
	 qasu8JIX4/t0c6y25kSdJ9w766MFchpv5ySy9m2BBXZ7pG7OEYz+obT+0w5FZkapin
	 lGqiZjP/UoN0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 03/17] nvme: tcp: avoid race between queue_lock lock and destroy
Date: Wed, 23 Oct 2024 10:31:42 -0400
Message-ID: <20241023143202.2981992-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143202.2981992-1-sashal@kernel.org>
References: <20241023143202.2981992-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
Content-Transfer-Encoding: 8bit

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


