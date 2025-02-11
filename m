Return-Path: <stable+bounces-114877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E36A307A8
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE07164AB0
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E271C1F0E35;
	Tue, 11 Feb 2025 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SfTF66q/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A139B1D90CD
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267527; cv=none; b=kuhOU3lHIPzu+SdW5JuvzBtpRSkkYdTb9uTs3+vVRTlLLIS7p/8yacUIvOi5+PIHeydeHgR0MeHtB+aHUusFeKTJ48ciVT/TL1am86g6h9UwJzdkg5QX48nb2iTQ3V1M+OUpgorO+bgOdykGFG/A5ZQGUZayBj0SqafWjuSL6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267527; c=relaxed/simple;
	bh=qGmnZZRgJe0whM5qdwekaMC5Q+DjMsWmldFpJrhozp4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MHvAfku6LIMJvIDhf7vvxz6pFVNKEHFn6wWznXoK5w1oGOrmia6gJV51EPVRHcg3mJS9A/pHKV6mO+p+FCzMIC+dxSKLpbAXWHnVD064g5adSvgmjDTadyiBt4Y0ShmGOz45kNEPLWd7MyN5+w7lIkNUYmUa5G2dKavjwYsYGA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SfTF66q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17F7C4CEDD;
	Tue, 11 Feb 2025 09:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739267527;
	bh=qGmnZZRgJe0whM5qdwekaMC5Q+DjMsWmldFpJrhozp4=;
	h=Subject:To:Cc:From:Date:From;
	b=SfTF66q/gsx+dJC6W+0Tu4hkBJrlmILHuL+fAWYb3jQW846U7Fh9EV5NfMDpr2C1j
	 qmiyCYOuPGf92k3m7+8pnRoYR5HKca6S7HXksUvqsh3KKjwxB0udyjZtt31W7mLn/n
	 soXyMFs2a+1P54c25juwS6IwMZlmLUgJ6eaEx+Bw=
Subject: FAILED: patch "[PATCH] RDMA/mlx5: Fix a race for an ODP MR which leads to CQE with" failed to apply to 6.1-stable tree
To: yishaih@nvidia.com,artemyko@nvidia.com,jgg@nvidia.com,leonro@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 11 Feb 2025 10:51:50 +0100
Message-ID: <2025021150-recent-yen-89d6@gregkh>
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
git cherry-pick -x abb604a1a9c87255c7a6f3b784410a9707baf467
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021150-recent-yen-89d6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From abb604a1a9c87255c7a6f3b784410a9707baf467 Mon Sep 17 00:00:00 2001
From: Yishai Hadas <yishaih@nvidia.com>
Date: Sun, 19 Jan 2025 14:38:25 +0200
Subject: [PATCH] RDMA/mlx5: Fix a race for an ODP MR which leads to CQE with
 error

This patch addresses a race condition for an ODP MR that can result in a
CQE with an error on the UMR QP.

During the __mlx5_ib_dereg_mr() flow, the following sequence of calls
occurs:

mlx5_revoke_mr()
 mlx5r_umr_revoke_mr()
 mlx5r_umr_post_send_wait()

At this point, the lkey is freed from the hardware's perspective.

However, concurrently, mlx5_ib_invalidate_range() might be triggered by
another task attempting to invalidate a range for the same freed lkey.

This task will:
 - Acquire the umem_odp->umem_mutex lock.
 - Call mlx5r_umr_update_xlt() on the UMR QP.
 - Since the lkey has already been freed, this can lead to a CQE error,
   causing the UMR QP to enter an error state [1].

To resolve this race condition, the umem_odp->umem_mutex lock is now also
acquired as part of the mlx5_revoke_mr() scope.  Upon successful revoke,
we set umem_odp->private which points to that MR to NULL, preventing any
further invalidation attempts on its lkey.

[1] From dmesg:

   infiniband rocep8s0f0: dump_cqe:277:(pid 0): WC error: 6, Message: memory bind operation error
   cqe_dump: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   cqe_dump: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   cqe_dump: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   cqe_dump: 00000030: 00 00 00 00 08 00 78 06 25 00 11 b9 00 0e dd d2

   WARNING: CPU: 15 PID: 1506 at drivers/infiniband/hw/mlx5/umr.c:394 mlx5r_umr_post_send_wait+0x15a/0x2b0 [mlx5_ib]
   Modules linked in: ip6table_mangle ip6table_natip6table_filter ip6_tables iptable_mangle xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_umad ib_ipoib ib_cm mlx5_ib ib_uverbs ib_core fuse mlx5_core
   CPU: 15 UID: 0 PID: 1506 Comm: ibv_rc_pingpong Not tainted 6.12.0-rc7+ #1626
   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
   RIP: 0010:mlx5r_umr_post_send_wait+0x15a/0x2b0 [mlx5_ib]
   [..]
   Call Trace:
   <TASK>
   mlx5r_umr_update_xlt+0x23c/0x3e0 [mlx5_ib]
   mlx5_ib_invalidate_range+0x2e1/0x330 [mlx5_ib]
   __mmu_notifier_invalidate_range_start+0x1e1/0x240
   zap_page_range_single+0xf1/0x1a0
   madvise_vma_behavior+0x677/0x6e0
   do_madvise+0x1a2/0x4b0
   __x64_sys_madvise+0x25/0x30
   do_syscall_64+0x6b/0x140
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: e6fb246ccafb ("RDMA/mlx5: Consolidate MR destruction to mlx5_ib_dereg_mr()")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/r/68a1e007c25b2b8fe5d625f238cc3b63e5341f77.1737290229.git.leon@kernel.org
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Artemy Kovalyov <artemyko@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 45d9dc9c6c8f..bb02b6adbf2c 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -2021,6 +2021,11 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 {
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
 	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
+	bool is_odp = is_odp_mr(mr);
+	int ret = 0;
+
+	if (is_odp)
+		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
 
 	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr)) {
 		ent = mr->mmkey.cache_ent;
@@ -2032,7 +2037,7 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 			ent->tmp_cleanup_scheduled = true;
 		}
 		spin_unlock_irq(&ent->mkeys_queue.lock);
-		return 0;
+		goto out;
 	}
 
 	if (ent) {
@@ -2041,7 +2046,15 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 		mr->mmkey.cache_ent = NULL;
 		spin_unlock_irq(&ent->mkeys_queue.lock);
 	}
-	return destroy_mkey(dev, mr);
+	ret = destroy_mkey(dev, mr);
+out:
+	if (is_odp) {
+		if (!ret)
+			to_ib_umem_odp(mr->umem)->private = NULL;
+		mutex_unlock(&to_ib_umem_odp(mr->umem)->umem_mutex);
+	}
+
+	return ret;
 }
 
 static int __mlx5_ib_dereg_mr(struct ib_mr *ibmr)
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index f2eb940bddc8..f655859eec00 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -268,6 +268,8 @@ static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
 	if (!umem_odp->npages)
 		goto out;
 	mr = umem_odp->private;
+	if (!mr)
+		goto out;
 
 	start = max_t(u64, ib_umem_start(umem_odp), range->start);
 	end = min_t(u64, ib_umem_end(umem_odp), range->end);


