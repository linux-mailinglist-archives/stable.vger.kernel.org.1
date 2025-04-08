Return-Path: <stable+bounces-130773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CAEA8068B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF164C1559
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9CC26A1A7;
	Tue,  8 Apr 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="07U6p5q/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30F2676FA;
	Tue,  8 Apr 2025 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114613; cv=none; b=EMEKoXTfsXVYeKg93PcO4bYVbEV4lSUiny6LyGuaVjNLGtdU/dSPOdMBP55HVosByMa/DhywfZdiMHR0hjfy/dfQg/clE/yUsl/CiG2wFCDFxdrbUi8RM4njo2vQEWNFE6mOkdagIg97PD2mc0W6ART/0AVdyLHTw/fr2KRyNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114613; c=relaxed/simple;
	bh=RQ/PNgGZMllNllMbP/ErSt8frRHSATHD6r6/8Yc9SCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kajSsjbF+sDWG7cwgbWi1FxKckDyBw5vgrPr+AlpFH5xu7JzZictwRHYDOmuUWPD1/ltshha3KDBfZ8qzO5gjihTLTNqWQp8ZJU0R/Lnipj6bnj+CFirPC3fA+dEpnco1oZK4J3qHwsh/PCH855sYo0b2WSalbwAP261BS1SlHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=07U6p5q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6443CC4CEE5;
	Tue,  8 Apr 2025 12:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114612;
	bh=RQ/PNgGZMllNllMbP/ErSt8frRHSATHD6r6/8Yc9SCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=07U6p5q/TKoUuboEtVWsfS1kcbziJJ/d3pYMrNHFk5teVL/oVGw3izofXRb5FsM9A
	 QiIu7GGWgP0RFwhFN6WBNZjsVfFZkfdhU47sp8Q8ViYGOUM++klB/a+8mj3j2Y1VsE
	 Tp1wb+diP1YdiHpNpYUKjqHFOF7lEqT8iIy7ELHA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Guralnik <michaelgur@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 132/499] RDMA/mlx5: Fix page_size variable overflow
Date: Tue,  8 Apr 2025 12:45:44 +0200
Message-ID: <20250408104854.485729191@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Guralnik <michaelgur@nvidia.com>

[ Upstream commit f0c2427412b43cdf1b7b0944749ea17ddb97d5a5 ]

Change all variables storing mlx5_umem_mkc_find_best_pgsz() result to
unsigned long to support values larger than 31 and avoid overflow.

For example: If we try to register 4GB of memory that is contiguous in
physical memory, the driver will optimize the page_size and try to use
an mkey with 4GB entity size. The 'unsigned int' page_size variable will
overflow to '0' and we'll hit the WARN_ON() in alloc_cacheable_mr().

WARNING: CPU: 2 PID: 1203 at drivers/infiniband/hw/mlx5/mr.c:1124 alloc_cacheable_mr+0x22/0x580 [mlx5_ib]
Modules linked in: mlx5_ib mlx5_core bonding ip6_gre ip6_tunnel tunnel6 ip_gre gre rdma_rxe rdma_ucm ib_uverbs ib_ipoib ib_umad rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm fuse ib_core [last unloaded: mlx5_core]
CPU: 2 UID: 70878 PID: 1203 Comm: rdma_resource_l Tainted: G        W          6.14.0-rc4-dirty #43
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:alloc_cacheable_mr+0x22/0x580 [mlx5_ib]
Code: 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 41 52 53 48 83 ec 30 f6 46 28 04 4c 8b 77 08 75 21 <0f> 0b 49 c7 c2 ea ff ff ff 48 8d 65 d0 4c 89 d0 5b 41 5a 41 5c 41
RSP: 0018:ffffc900006ffac8 EFLAGS: 00010246
RAX: 0000000004c0d0d0 RBX: ffff888217a22000 RCX: 0000000000100001
RDX: 00007fb7ac480000 RSI: ffff8882037b1240 RDI: ffff8882046f0600
RBP: ffffc900006ffb28 R08: 0000000000000001 R09: 0000000000000000
R10: 00000000000007e0 R11: ffffea0008011d40 R12: ffff8882037b1240
R13: ffff8882046f0600 R14: ffff888217a22000 R15: ffffc900006ffe00
FS:  00007fb7ed013340(0000) GS:ffff88885fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb7ed1d8000 CR3: 00000001fd8f6006 CR4: 0000000000772eb0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn+0x81/0x130
 ? alloc_cacheable_mr+0x22/0x580 [mlx5_ib]
 ? report_bug+0xfc/0x1e0
 ? handle_bug+0x55/0x90
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? alloc_cacheable_mr+0x22/0x580 [mlx5_ib]
 create_real_mr+0x54/0x150 [mlx5_ib]
 ib_uverbs_reg_mr+0x17f/0x2a0 [ib_uverbs]
 ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xca/0x140 [ib_uverbs]
 ib_uverbs_run_method+0x6d0/0x780 [ib_uverbs]
 ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
 ib_uverbs_cmd_verbs+0x19b/0x360 [ib_uverbs]
 ? walk_system_ram_range+0x79/0xd0
 ? ___pte_offset_map+0x1b/0x110
 ? __pte_offset_map_lock+0x80/0x100
 ib_uverbs_ioctl+0xac/0x110 [ib_uverbs]
 __x64_sys_ioctl+0x94/0xb0
 do_syscall_64+0x50/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fb7ecf0737b
Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 7d 2a 0f 00 f7 d8 64 89 01 48
RSP: 002b:00007ffdbe03ecc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffdbe03edb8 RCX: 00007fb7ecf0737b
RDX: 00007ffdbe03eda0 RSI: 00000000c0181b01 RDI: 0000000000000003
RBP: 00007ffdbe03ed80 R08: 00007fb7ecc84010 R09: 00007ffdbe03eed4
R10: 0000000000000009 R11: 0000000000000246 R12: 00007ffdbe03eed4
R13: 000000000000000c R14: 000000000000000c R15: 00007fb7ecc84150
 </TASK>

Fixes: cef7dde8836a ("net/mlx5: Expand mkey page size to support 6 bits")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Link: https://patch.msgid.link/2479a4a3f6fd9bd032e1b6d396274a89c4c5e22f.1741875692.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/mr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 753faa9ad06a8..eeb94d1ae60d9 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -56,7 +56,7 @@ static void
 create_mkey_callback(int status, struct mlx5_async_work *context);
 static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 				     u64 iova, int access_flags,
-				     unsigned int page_size, bool populate,
+				     unsigned long page_size, bool populate,
 				     int access_mode);
 static int __mlx5_ib_dereg_mr(struct ib_mr *ibmr);
 
@@ -1115,7 +1115,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	struct mlx5r_cache_rb_key rb_key = {};
 	struct mlx5_cache_ent *ent;
 	struct mlx5_ib_mr *mr;
-	unsigned int page_size;
+	unsigned long page_size;
 
 	if (umem->is_dmabuf)
 		page_size = mlx5_umem_dmabuf_default_pgsz(umem, iova);
@@ -1219,7 +1219,7 @@ reg_create_crossing_vhca_mr(struct ib_pd *pd, u64 iova, u64 length, int access_f
  */
 static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 				     u64 iova, int access_flags,
-				     unsigned int page_size, bool populate,
+				     unsigned long page_size, bool populate,
 				     int access_mode)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
@@ -1425,7 +1425,7 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd, struct ib_umem *umem,
 		mr = alloc_cacheable_mr(pd, umem, iova, access_flags,
 					MLX5_MKC_ACCESS_MODE_MTT);
 	} else {
-		unsigned int page_size =
+		unsigned long page_size =
 			mlx5_umem_mkc_find_best_pgsz(dev, umem, iova);
 
 		mutex_lock(&dev->slow_path_mutex);
-- 
2.39.5




