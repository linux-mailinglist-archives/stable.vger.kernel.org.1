Return-Path: <stable+bounces-161024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDE3AFD2B2
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676777AD95F
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A57257459;
	Tue,  8 Jul 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jkDGTGhv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50BB1B4153;
	Tue,  8 Jul 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993378; cv=none; b=eFnYa90ZaRpLXpNOkphuAvLtK1kmbVtCNdUcAWVN+55jckL/6uwDb12igB9KYKk7kWd2rhZlcYS+QQXj0gHaXU+Lh8Mi2Pw7UfFiKJnNnxrBAMqrUcKthBrpCDbyzP8i6Oc3u6d+UhcIZ9WsvhcRkEuZLClo0UomPcm3Xmx7JJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993378; c=relaxed/simple;
	bh=8J6ldsDoKL+pgHts/dNClSH58OhQD+pjLsCVyGYBvRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsijSR6qrkTs0xfCQCuRrc/iOiQp8HCiYquFQHwK+iUPjrGN+nHTf7Nz/Yap+PdWiAhNdJFjQV7Z02jrDLlkYfOM/bf+9tA1U6u4STmUgYSzKR41F9WXf7GQMZVCy+VtWHJsrNRMhKKBhXBDKhAm954T+GU6Ps8pAaAcsBhrr1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jkDGTGhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6ACC4CEED;
	Tue,  8 Jul 2025 16:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993378;
	bh=8J6ldsDoKL+pgHts/dNClSH58OhQD+pjLsCVyGYBvRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkDGTGhvYFFomi1TenxmB1+f+8r+d/EI8xcJx2oUY/ScTR5jLC+TLdelNBCVw+pNk
	 seOFXdJqMegRQUf+xr1WBMyepjs7by91Dv4FHaMie75aK6RgkttixrpguubV99BUy7
	 W7G/FMntm0tzlbnRuKnga/FiGqCblILf1ZS1rjuQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Or Har-Toov <ohartoov@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 054/178] IB/mlx5: Fix potential deadlock in MR deregistration
Date: Tue,  8 Jul 2025 18:21:31 +0200
Message-ID: <20250708162238.093252742@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Or Har-Toov <ohartoov@nvidia.com>

[ Upstream commit 2ed25aa7f7711f508b6120e336f05cd9d49943c0 ]

The issue arises when kzalloc() is invoked while holding umem_mutex or
any other lock acquired under umem_mutex. This is problematic because
kzalloc() can trigger fs_reclaim_aqcuire(), which may, in turn, invoke
mmu_notifier_invalidate_range_start(). This function can lead to
mlx5_ib_invalidate_range(), which attempts to acquire umem_mutex again,
resulting in a deadlock.

The problematic flow:
             CPU0                      |              CPU1
---------------------------------------|------------------------------------------------
mlx5_ib_dereg_mr()                     |
 → revoke_mr()                         |
   → mutex_lock(&umem_odp->umem_mutex) |
                                       | mlx5_mkey_cache_init()
                                       |  → mutex_lock(&dev->cache.rb_lock)
                                       |  → mlx5r_cache_create_ent_locked()
                                       |    → kzalloc(GFP_KERNEL)
                                       |      → fs_reclaim()
                                       |        → mmu_notifier_invalidate_range_start()
                                       |          → mlx5_ib_invalidate_range()
                                       |            → mutex_lock(&umem_odp->umem_mutex)
   → cache_ent_find_and_store()        |
     → mutex_lock(&dev->cache.rb_lock) |

Additionally, when kzalloc() is called from within
cache_ent_find_and_store(), we encounter the same deadlock due to
re-acquisition of umem_mutex.

Solve by releasing umem_mutex in dereg_mr() after umr_revoke_mr()
and before acquiring rb_lock. This ensures that we don't hold
umem_mutex while performing memory allocations that could trigger
the reclaim path.

This change prevents the deadlock by ensuring proper lock ordering and
avoiding holding locks during memory allocation operations that could
trigger the reclaim path.

The following lockdep warning demonstrates the deadlock:

 python3/20557 is trying to acquire lock:
 ffff888387542128 (&umem_odp->umem_mutex){+.+.}-{4:4}, at:
 mlx5_ib_invalidate_range+0x5b/0x550 [mlx5_ib]

 but task is already holding lock:
 ffffffff82f6b840 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at:
 unmap_vmas+0x7b/0x1a0

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #3 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
       fs_reclaim_acquire+0x60/0xd0
       mem_cgroup_css_alloc+0x6f/0x9b0
       cgroup_init_subsys+0xa4/0x240
       cgroup_init+0x1c8/0x510
       start_kernel+0x747/0x760
       x86_64_start_reservations+0x25/0x30
       x86_64_start_kernel+0x73/0x80
       common_startup_64+0x129/0x138

 -> #2 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire+0x91/0xd0
       __kmalloc_cache_noprof+0x4d/0x4c0
       mlx5r_cache_create_ent_locked+0x75/0x620 [mlx5_ib]
       mlx5_mkey_cache_init+0x186/0x360 [mlx5_ib]
       mlx5_ib_stage_post_ib_reg_umr_init+0x3c/0x60 [mlx5_ib]
       __mlx5_ib_add+0x4b/0x190 [mlx5_ib]
       mlx5r_probe+0xd9/0x320 [mlx5_ib]
       auxiliary_bus_probe+0x42/0x70
       really_probe+0xdb/0x360
       __driver_probe_device+0x8f/0x130
       driver_probe_device+0x1f/0xb0
       __driver_attach+0xd4/0x1f0
       bus_for_each_dev+0x79/0xd0
       bus_add_driver+0xf0/0x200
       driver_register+0x6e/0xc0
       __auxiliary_driver_register+0x6a/0xc0
       do_one_initcall+0x5e/0x390
       do_init_module+0x88/0x240
       init_module_from_file+0x85/0xc0
       idempotent_init_module+0x104/0x300
       __x64_sys_finit_module+0x68/0xc0
       do_syscall_64+0x6d/0x140
       entry_SYSCALL_64_after_hwframe+0x4b/0x53

 -> #1 (&dev->cache.rb_lock){+.+.}-{4:4}:
       __mutex_lock+0x98/0xf10
       __mlx5_ib_dereg_mr+0x6f2/0x890 [mlx5_ib]
       mlx5_ib_dereg_mr+0x21/0x110 [mlx5_ib]
       ib_dereg_mr_user+0x85/0x1f0 [ib_core]
       uverbs_free_mr+0x19/0x30 [ib_uverbs]
       destroy_hw_idr_uobject+0x21/0x80 [ib_uverbs]
       uverbs_destroy_uobject+0x60/0x3d0 [ib_uverbs]
       uobj_destroy+0x57/0xa0 [ib_uverbs]
       ib_uverbs_cmd_verbs+0x4d5/0x1210 [ib_uverbs]
       ib_uverbs_ioctl+0x129/0x230 [ib_uverbs]
       __x64_sys_ioctl+0x596/0xaa0
       do_syscall_64+0x6d/0x140
       entry_SYSCALL_64_after_hwframe+0x4b/0x53

 -> #0 (&umem_odp->umem_mutex){+.+.}-{4:4}:
       __lock_acquire+0x1826/0x2f00
       lock_acquire+0xd3/0x2e0
       __mutex_lock+0x98/0xf10
       mlx5_ib_invalidate_range+0x5b/0x550 [mlx5_ib]
       __mmu_notifier_invalidate_range_start+0x18e/0x1f0
       unmap_vmas+0x182/0x1a0
       exit_mmap+0xf3/0x4a0
       mmput+0x3a/0x100
       do_exit+0x2b9/0xa90
       do_group_exit+0x32/0xa0
       get_signal+0xc32/0xcb0
       arch_do_signal_or_restart+0x29/0x1d0
       syscall_exit_to_user_mode+0x105/0x1d0
       do_syscall_64+0x79/0x140
       entry_SYSCALL_64_after_hwframe+0x4b/0x53

 Chain exists of:
 &dev->cache.rb_lock --> mmu_notifier_invalidate_range_start -->
 &umem_odp->umem_mutex

 Possible unsafe locking scenario:

       CPU0                        CPU1
       ----                        ----
   lock(&umem_odp->umem_mutex);
                                lock(mmu_notifier_invalidate_range_start);
                                lock(&umem_odp->umem_mutex);
   lock(&dev->cache.rb_lock);

 *** DEADLOCK ***

Fixes: abb604a1a9c8 ("RDMA/mlx5: Fix a race for an ODP MR which leads to CQE with error")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Link: https://patch.msgid.link/3c8f225a8a9fade647d19b014df1172544643e4a.1750061612.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/mr.c | 61 +++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 5fbebafc87742..cb403134eeaea 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -2027,23 +2027,50 @@ void mlx5_ib_revoke_data_direct_mrs(struct mlx5_ib_dev *dev)
 	}
 }
 
-static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
+static int mlx5_umr_revoke_mr_with_lock(struct mlx5_ib_mr *mr)
 {
-	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
-	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
-	bool is_odp = is_odp_mr(mr);
 	bool is_odp_dma_buf = is_dmabuf_mr(mr) &&
-			!to_ib_umem_dmabuf(mr->umem)->pinned;
-	bool from_cache = !!ent;
-	int ret = 0;
+			      !to_ib_umem_dmabuf(mr->umem)->pinned;
+	bool is_odp = is_odp_mr(mr);
+	int ret;
 
 	if (is_odp)
 		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
 
 	if (is_odp_dma_buf)
-		dma_resv_lock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv, NULL);
+		dma_resv_lock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv,
+			      NULL);
+
+	ret = mlx5r_umr_revoke_mr(mr);
+
+	if (is_odp) {
+		if (!ret)
+			to_ib_umem_odp(mr->umem)->private = NULL;
+		mutex_unlock(&to_ib_umem_odp(mr->umem)->umem_mutex);
+	}
+
+	if (is_odp_dma_buf) {
+		if (!ret)
+			to_ib_umem_dmabuf(mr->umem)->private = NULL;
+		dma_resv_unlock(
+			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
+	}
 
-	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr)) {
+	return ret;
+}
+
+static int mlx5r_handle_mkey_cleanup(struct mlx5_ib_mr *mr)
+{
+	bool is_odp_dma_buf = is_dmabuf_mr(mr) &&
+			      !to_ib_umem_dmabuf(mr->umem)->pinned;
+	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
+	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
+	bool is_odp = is_odp_mr(mr);
+	bool from_cache = !!ent;
+	int ret;
+
+	if (mr->mmkey.cacheable && !mlx5_umr_revoke_mr_with_lock(mr) &&
+	    !cache_ent_find_and_store(dev, mr)) {
 		ent = mr->mmkey.cache_ent;
 		/* upon storing to a clean temp entry - schedule its cleanup */
 		spin_lock_irq(&ent->mkeys_queue.lock);
@@ -2055,7 +2082,7 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 			ent->tmp_cleanup_scheduled = true;
 		}
 		spin_unlock_irq(&ent->mkeys_queue.lock);
-		goto out;
+		return 0;
 	}
 
 	if (ent) {
@@ -2064,8 +2091,14 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 		mr->mmkey.cache_ent = NULL;
 		spin_unlock_irq(&ent->mkeys_queue.lock);
 	}
+
+	if (is_odp)
+		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
+
+	if (is_odp_dma_buf)
+		dma_resv_lock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv,
+			      NULL);
 	ret = destroy_mkey(dev, mr);
-out:
 	if (is_odp) {
 		if (!ret)
 			to_ib_umem_odp(mr->umem)->private = NULL;
@@ -2075,9 +2108,9 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 	if (is_odp_dma_buf) {
 		if (!ret)
 			to_ib_umem_dmabuf(mr->umem)->private = NULL;
-		dma_resv_unlock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
+		dma_resv_unlock(
+			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
 	}
-
 	return ret;
 }
 
@@ -2126,7 +2159,7 @@ static int __mlx5_ib_dereg_mr(struct ib_mr *ibmr)
 	}
 
 	/* Stop DMA */
-	rc = mlx5_revoke_mr(mr);
+	rc = mlx5r_handle_mkey_cleanup(mr);
 	if (rc)
 		return rc;
 
-- 
2.39.5




