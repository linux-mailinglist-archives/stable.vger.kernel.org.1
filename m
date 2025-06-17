Return-Path: <stable+bounces-153341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F62DADD3F7
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F160B405D97
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75FF2EE617;
	Tue, 17 Jun 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gGaCfwJw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B22E92BC;
	Tue, 17 Jun 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175636; cv=none; b=S8z81mqG7nq5mL+dX5WmMbvoLG9vr81vx+yveQMtBFvT3dC0tN5pD/zf0RyMKnH+uWxN6xgOJDhglsvf41AX9F2tafwNyG3MXf3aEOx6iJfSY2gPHvDUrR5e/bYMIXJZhoK0HWcEzlPNH3Ycyj8zlRAOAsqdgUSL6r5K7Z6zQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175636; c=relaxed/simple;
	bh=hMyfcaJhP0+S6MaS+DNgOMtU2u4mFMVDy72wURu3ONg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnX+HTxgOfV3PH91jCVMT2yPljwF5ysmMAHvjC9sQv/L+4Yzpz9W8G8otvbOPJhYadjhKpHnyNKK5nSjEvrIP5C2xXwBG0L6ywygqNI2D/Xq1/oE9h2yzlTHFe8u9HW4A3Vh6SiLOjAy7pxG6hz4ho0uSc2RQV9u9fAtobortn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gGaCfwJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55BFC4CEF1;
	Tue, 17 Jun 2025 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175636;
	bh=hMyfcaJhP0+S6MaS+DNgOMtU2u4mFMVDy72wURu3ONg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gGaCfwJwo7YHuhtBTWjxU6VdyBwlErlpli703hPBpvVIVwunEb3Rjkyj4KOS+SYUg
	 VA4Wi4EngEcqd/8JKECUWUfdme+jLvzDY7gxD/PnlkopeDYw2KAelNNYFkpV3Mv5Xs
	 gWobdBg+MpVgN7xYjV5Ui4gOi9EdlouUYCjdlDqY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 149/512] RDMA/mlx5: Fix error flow upon firmware failure for RQ destruction
Date: Tue, 17 Jun 2025 17:21:55 +0200
Message-ID: <20250617152425.644153756@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrisious Haddad <phaddad@nvidia.com>

[ Upstream commit 5d2ea5aebbb2f3ebde4403f9c55b2b057e5dd2d6 ]

Upon RQ destruction if the firmware command fails which is the
last resource to be destroyed some SW resources were already cleaned
regardless of the failure.

Now properly rollback the object to its original state upon such failure.

In order to avoid a use-after free in case someone tries to destroy the
object again, which results in the following kernel trace:
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 37589 at lib/refcount.c:28 refcount_warn_saturate+0xf4/0x148
Modules linked in: rdma_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(OE) ib_cm(OE) ib_umad(OE) mlx5_ib(OE) rfkill mlx5_core(OE) mlxdevm(OE) ib_uverbs(OE) ib_core(OE) psample mlxfw(OE) mlx_compat(OE) macsec tls pci_hyperv_intf sunrpc vfat fat virtio_net net_failover failover fuse loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_console virtio_gpu virtio_blk virtio_dma_buf virtio_mmio dm_mirror dm_region_hash dm_log dm_mod xpmem(OE)
CPU: 0 UID: 0 PID: 37589 Comm: python3 Kdump: loaded Tainted: G           OE     -------  ---  6.12.0-54.el10.aarch64 #1
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0xf4/0x148
lr : refcount_warn_saturate+0xf4/0x148
sp : ffff80008b81b7e0
x29: ffff80008b81b7e0 x28: ffff000133d51600 x27: 0000000000000001
x26: 0000000000000000 x25: 00000000ffffffea x24: ffff00010ae80f00
x23: ffff00010ae80f80 x22: ffff0000c66e5d08 x21: 0000000000000000
x20: ffff0000c66e0000 x19: ffff00010ae80340 x18: 0000000000000006
x17: 0000000000000000 x16: 0000000000000020 x15: ffff80008b81b37f
x14: 0000000000000000 x13: 2e656572662d7265 x12: ffff80008283ef78
x11: ffff80008257efd0 x10: ffff80008283efd0 x9 : ffff80008021ed90
x8 : 0000000000000001 x7 : 00000000000bffe8 x6 : c0000000ffff7fff
x5 : ffff0001fb8e3408 x4 : 0000000000000000 x3 : ffff800179993000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000133d51600
Call trace:
 refcount_warn_saturate+0xf4/0x148
 mlx5_core_put_rsc+0x88/0xa0 [mlx5_ib]
 mlx5_core_destroy_rq_tracked+0x64/0x98 [mlx5_ib]
 mlx5_ib_destroy_wq+0x34/0x80 [mlx5_ib]
 ib_destroy_wq_user+0x30/0xc0 [ib_core]
 uverbs_free_wq+0x28/0x58 [ib_uverbs]
 destroy_hw_idr_uobject+0x34/0x78 [ib_uverbs]
 uverbs_destroy_uobject+0x48/0x240 [ib_uverbs]
 __uverbs_cleanup_ufile+0xd4/0x1a8 [ib_uverbs]
 uverbs_destroy_ufile_hw+0x48/0x120 [ib_uverbs]
 ib_uverbs_close+0x2c/0x100 [ib_uverbs]
 __fput+0xd8/0x2f0
 __fput_sync+0x50/0x70
 __arm64_sys_close+0x40/0x90
 invoke_syscall.constprop.0+0x74/0xd0
 do_el0_svc+0x48/0xe8
 el0_svc+0x44/0x1d0
 el0t_64_sync_handler+0x120/0x130
 el0t_64_sync+0x1a4/0x1a8

Fixes: e2013b212f9f ("net/mlx5_core: Add RQ and SQ event handling")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Link: https://patch.msgid.link/3181433ccdd695c63560eeeb3f0c990961732101.1745839855.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/qpc.c | 30 ++++++++++++++++++++++++++++--
 include/linux/mlx5/driver.h      |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qpc.c b/drivers/infiniband/hw/mlx5/qpc.c
index d3dcc272200af..146d03ae40bd9 100644
--- a/drivers/infiniband/hw/mlx5/qpc.c
+++ b/drivers/infiniband/hw/mlx5/qpc.c
@@ -21,8 +21,10 @@ mlx5_get_rsc(struct mlx5_qp_table *table, u32 rsn)
 	spin_lock_irqsave(&table->lock, flags);
 
 	common = radix_tree_lookup(&table->tree, rsn);
-	if (common)
+	if (common && !common->invalid)
 		refcount_inc(&common->refcount);
+	else
+		common = NULL;
 
 	spin_unlock_irqrestore(&table->lock, flags);
 
@@ -178,6 +180,18 @@ static int create_resource_common(struct mlx5_ib_dev *dev,
 	return 0;
 }
 
+static void modify_resource_common_state(struct mlx5_ib_dev *dev,
+					 struct mlx5_core_qp *qp,
+					 bool invalid)
+{
+	struct mlx5_qp_table *table = &dev->qp_table;
+	unsigned long flags;
+
+	spin_lock_irqsave(&table->lock, flags);
+	qp->common.invalid = invalid;
+	spin_unlock_irqrestore(&table->lock, flags);
+}
+
 static void destroy_resource_common(struct mlx5_ib_dev *dev,
 				    struct mlx5_core_qp *qp)
 {
@@ -609,8 +623,20 @@ int mlx5_core_create_rq_tracked(struct mlx5_ib_dev *dev, u32 *in, int inlen,
 int mlx5_core_destroy_rq_tracked(struct mlx5_ib_dev *dev,
 				 struct mlx5_core_qp *rq)
 {
+	int ret;
+
+	/* The rq destruction can be called again in case it fails, hence we
+	 * mark the common resource as invalid and only once FW destruction
+	 * is completed successfully we actually destroy the resources.
+	 */
+	modify_resource_common_state(dev, rq, true);
+	ret = destroy_rq_tracked(dev, rq->qpn, rq->uid);
+	if (ret) {
+		modify_resource_common_state(dev, rq, false);
+		return ret;
+	}
 	destroy_resource_common(dev, rq);
-	return destroy_rq_tracked(dev, rq->qpn, rq->uid);
+	return 0;
 }
 
 static void destroy_sq_tracked(struct mlx5_ib_dev *dev, u32 sqn, u16 uid)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index d4b2c09cd5fec..da9749739abde 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -395,6 +395,7 @@ struct mlx5_core_rsc_common {
 	enum mlx5_res_type	res;
 	refcount_t		refcount;
 	struct completion	free;
+	bool			invalid;
 };
 
 struct mlx5_uars_page {
-- 
2.39.5




