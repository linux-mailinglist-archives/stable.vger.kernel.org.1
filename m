Return-Path: <stable+bounces-34151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEFD893E1A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C97E1C21B41
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923C045BE4;
	Mon,  1 Apr 2024 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CLXip2Nj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5052447A55;
	Mon,  1 Apr 2024 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987165; cv=none; b=LXyzdP19fe/KTFgROacSUgbg5mFlvhH3qk7rWSvxaq0ZuDSgR3sKcnvTqNPgcIV7eX0oxeuXgEpt9bnTXW6ecZ8RaAmejunazuyPK2/YTs/ObWUEzbo9YUud5rVZZN3Im6Nbg1pX57btugHn2XlQ6u0G0nDaZ7JBJmND87+gZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987165; c=relaxed/simple;
	bh=UId+cSejJ7mZJ02ieOZPcft9alG4qMifqA9QRd4wjx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ex4b7gGBSAHUKXev/tJk4QEdVoE0iimOLecYSg1iI7TDB7aQw6dSXesVkel1Qat8sQfxSq4UUWZ5SEaxzhXsVhBA8jCSIwnDsso34muScpz5TARNf4lPYoSO6J94odqblO6M6UPdvUi6BPAYOVAoNpNSXO0phaWIurm7X43pmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CLXip2Nj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2762C433C7;
	Mon,  1 Apr 2024 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987165;
	bh=UId+cSejJ7mZJ02ieOZPcft9alG4qMifqA9QRd4wjx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLXip2NjEGu8SRxC4tQlP7cv1R9BWJyqD+7hABh6UR83WTylJRnGvJ2D5Kf+rKtlp
	 lijlw4IxW4KTRKsjKGWZqRXUrsFaGkIXuOupvHVXDfqI3eRviUQbZ63TinP9+uJhjz
	 KnMVk2Ahx+pWxBWjM66mUsa9Ltsbd35QXrJrZ0TM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 164/399] s390/zcrypt: fix reference counting on zcrypt card objects
Date: Mon,  1 Apr 2024 17:42:10 +0200
Message-ID: <20240401152554.077368212@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harald Freudenberger <freude@linux.ibm.com>

[ Upstream commit 50ed48c80fecbe17218afed4f8bed005c802976c ]

Tests with hot-plugging crytpo cards on KVM guests with debug
kernel build revealed an use after free for the load field of
the struct zcrypt_card. The reason was an incorrect reference
handling of the zcrypt card object which could lead to a free
of the zcrypt card object while it was still in use.

This is an example of the slab message:

    kernel: 0x00000000885a7512-0x00000000885a7513 @offset=1298. First byte 0x68 instead of 0x6b
    kernel: Allocated in zcrypt_card_alloc+0x36/0x70 [zcrypt] age=18046 cpu=3 pid=43
    kernel:  kmalloc_trace+0x3f2/0x470
    kernel:  zcrypt_card_alloc+0x36/0x70 [zcrypt]
    kernel:  zcrypt_cex4_card_probe+0x26/0x380 [zcrypt_cex4]
    kernel:  ap_device_probe+0x15c/0x290
    kernel:  really_probe+0xd2/0x468
    kernel:  driver_probe_device+0x40/0xf0
    kernel:  __device_attach_driver+0xc0/0x140
    kernel:  bus_for_each_drv+0x8c/0xd0
    kernel:  __device_attach+0x114/0x198
    kernel:  bus_probe_device+0xb4/0xc8
    kernel:  device_add+0x4d2/0x6e0
    kernel:  ap_scan_adapter+0x3d0/0x7c0
    kernel:  ap_scan_bus+0x5a/0x3b0
    kernel:  ap_scan_bus_wq_callback+0x40/0x60
    kernel:  process_one_work+0x26e/0x620
    kernel:  worker_thread+0x21c/0x440
    kernel: Freed in zcrypt_card_put+0x54/0x80 [zcrypt] age=9024 cpu=3 pid=43
    kernel:  kfree+0x37e/0x418
    kernel:  zcrypt_card_put+0x54/0x80 [zcrypt]
    kernel:  ap_device_remove+0x4c/0xe0
    kernel:  device_release_driver_internal+0x1c4/0x270
    kernel:  bus_remove_device+0x100/0x188
    kernel:  device_del+0x164/0x3c0
    kernel:  device_unregister+0x30/0x90
    kernel:  ap_scan_adapter+0xc8/0x7c0
    kernel:  ap_scan_bus+0x5a/0x3b0
    kernel:  ap_scan_bus_wq_callback+0x40/0x60
    kernel:  process_one_work+0x26e/0x620
    kernel:  worker_thread+0x21c/0x440
    kernel:  kthread+0x150/0x168
    kernel:  __ret_from_fork+0x3c/0x58
    kernel:  ret_from_fork+0xa/0x30
    kernel: Slab 0x00000372022169c0 objects=20 used=18 fp=0x00000000885a7c88 flags=0x3ffff00000000a00(workingset|slab|node=0|zone=1|lastcpupid=0x1ffff)
    kernel: Object 0x00000000885a74b8 @offset=1208 fp=0x00000000885a7c88
    kernel: Redzone  00000000885a74b0: bb bb bb bb bb bb bb bb                          ........
    kernel: Object   00000000885a74b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
    kernel: Object   00000000885a74c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
    kernel: Object   00000000885a74d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
    kernel: Object   00000000885a74e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
    kernel: Object   00000000885a74f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
    kernel: Object   00000000885a7508: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 68 4b 6b 6b 6b a5  kkkkkkkkkkhKkkk.
    kernel: Redzone  00000000885a7518: bb bb bb bb bb bb bb bb                          ........
    kernel: Padding  00000000885a756c: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a              ZZZZZZZZZZZZ
    kernel: CPU: 0 PID: 387 Comm: systemd-udevd Not tainted 6.8.0-HF #2
    kernel: Hardware name: IBM 3931 A01 704 (KVM/Linux)
    kernel: Call Trace:
    kernel:  [<00000000ca5ab5b8>] dump_stack_lvl+0x90/0x120
    kernel:  [<00000000c99d78bc>] check_bytes_and_report+0x114/0x140
    kernel:  [<00000000c99d53cc>] check_object+0x334/0x3f8
    kernel:  [<00000000c99d820c>] alloc_debug_processing+0xc4/0x1f8
    kernel:  [<00000000c99d852e>] get_partial_node.part.0+0x1ee/0x3e0
    kernel:  [<00000000c99d94ec>] ___slab_alloc+0xaf4/0x13c8
    kernel:  [<00000000c99d9e38>] __slab_alloc.constprop.0+0x78/0xb8
    kernel:  [<00000000c99dc8dc>] __kmalloc+0x434/0x590
    kernel:  [<00000000c9b4c0ce>] ext4_htree_store_dirent+0x4e/0x1c0
    kernel:  [<00000000c9b908a2>] htree_dirblock_to_tree+0x17a/0x3f0
    kernel:  [<00000000c9b919dc>] ext4_htree_fill_tree+0x134/0x400
    kernel:  [<00000000c9b4b3d0>] ext4_dx_readdir+0x160/0x2f0
    kernel:  [<00000000c9b4bedc>] ext4_readdir+0x5f4/0x760
    kernel:  [<00000000c9a7efc4>] iterate_dir+0xb4/0x280
    kernel:  [<00000000c9a7f1ea>] __do_sys_getdents64+0x5a/0x120
    kernel:  [<00000000ca5d6946>] __do_syscall+0x256/0x310
    kernel:  [<00000000ca5eea10>] system_call+0x70/0x98
    kernel: INFO: lockdep is turned off.
    kernel: FIX kmalloc-96: Restoring Poison 0x00000000885a7512-0x00000000885a7513=0x6b
    kernel: FIX kmalloc-96: Marking all objects used

The fix is simple: Before use of the queue not only the queue object
but also the card object needs to increase it's reference count
with a call to zcrypt_card_get(). Similar after use of the queue
not only the queue but also the card object's reference count is
decreased with zcrypt_card_put().

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/zcrypt_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 74200f54dfff7..53ddae5ad890b 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -579,6 +579,7 @@ static inline struct zcrypt_queue *zcrypt_pick_queue(struct zcrypt_card *zc,
 {
 	if (!zq || !try_module_get(zq->queue->ap_dev.device.driver->owner))
 		return NULL;
+	zcrypt_card_get(zc);
 	zcrypt_queue_get(zq);
 	get_device(&zq->queue->ap_dev.device);
 	atomic_add(weight, &zc->load);
@@ -598,6 +599,7 @@ static inline void zcrypt_drop_queue(struct zcrypt_card *zc,
 	atomic_sub(weight, &zq->load);
 	put_device(&zq->queue->ap_dev.device);
 	zcrypt_queue_put(zq);
+	zcrypt_card_put(zc);
 	module_put(mod);
 }
 
-- 
2.43.0




