Return-Path: <stable+bounces-112208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B9CA278FD
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB00E3A2AAA
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73FF21639E;
	Tue,  4 Feb 2025 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TtSmJz3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DD14A0B5
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691545; cv=none; b=Iao8bgNX1Rqs+1IomOC3ZY8SHzw5HjfpdNTCLUDj4tXr/XNEJksPAhORgnuyMWRErf8KmSYLhxezeztwUqVlxVmAlIje/Rct+ELsl5DGdIUnu/fJ8YgUXcDT43nSDjaJJcXSCrDmGVj1DAteDSUg8LbaQH85iMg78NxVGiW6nbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691545; c=relaxed/simple;
	bh=cj9n7Yayd9JkJr3Fcr8zf1BE/Z8NHtAslsniqDBt0zk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NjwDffwH8oL45xeJZJjMJNYXgsGNcg4L1od1DZ3r06GbJyqFsmjPuKWb5yODJKfGaOmile+qedLjraDPmbN6ELYxbxMN5T7AGbT6G07bTU3ZQ1loKU6CuiyzeevHBGJJYx+TL5tsQ5iOxT7oMOsldDwfKDtjGr+KJasrQbmR/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TtSmJz3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9FCC4CEDF;
	Tue,  4 Feb 2025 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738691545;
	bh=cj9n7Yayd9JkJr3Fcr8zf1BE/Z8NHtAslsniqDBt0zk=;
	h=Subject:To:Cc:From:Date:From;
	b=TtSmJz3n7bJvTNQtLhd4rQwTI/SXA0SRajwcQ+9Fijr6aGShZenN6kqGULuX4u2Zp
	 XHhQS+jA0ZuTE9CuWYvz8tz17rBMWqJi9LCrWcE5TlWY9DNPpvLuC7MD140vjJZDkZ
	 hYiN2VKbKwqmoctx7NSsYYtQpHEg6vvgmFy85g6I=
Subject: FAILED: patch "[PATCH] RDMA/mlx5: Fix implicit ODP use after free" failed to apply to 5.15-stable tree
To: phaddad@nvidia.com,jgg@nvidia.com,leonro@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Feb 2025 18:52:11 +0100
Message-ID: <2025020411-unwritten-anvil-1852@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d3d930411ce390e532470194296658a960887773
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020411-unwritten-anvil-1852@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d3d930411ce390e532470194296658a960887773 Mon Sep 17 00:00:00 2001
From: Patrisious Haddad <phaddad@nvidia.com>
Date: Sun, 19 Jan 2025 10:21:41 +0200
Subject: [PATCH] RDMA/mlx5: Fix implicit ODP use after free

Prevent double queueing of implicit ODP mr destroy work by using
__xa_cmpxchg() to make sure this is the only time we are destroying this
specific mr.

Without this change, we could try to invalidate this mr twice, which in
turn could result in queuing a MR work destroy twice, and eventually the
second work could execute after the MR was freed due to the first work,
causing a user after free and trace below.

   refcount_t: underflow; use-after-free.
   WARNING: CPU: 2 PID: 12178 at lib/refcount.c:28 refcount_warn_saturate+0x12b/0x130
   Modules linked in: bonding ib_ipoib vfio_pci ip_gre geneve nf_tables ip6_gre gre ip6_tunnel tunnel6 ipip tunnel4 ib_umad rdma_ucm mlx5_vfio_pci vfio_pci_core vfio_iommu_type1 mlx5_ib vfio ib_uverbs mlx5_core iptable_raw openvswitch nsh rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay zram zsmalloc fuse [last unloaded: ib_uverbs]
   CPU: 2 PID: 12178 Comm: kworker/u20:5 Not tainted 6.5.0-rc1_net_next_mlx5_58c644e #1
   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
   Workqueue: events_unbound free_implicit_child_mr_work [mlx5_ib]
   RIP: 0010:refcount_warn_saturate+0x12b/0x130
   Code: 48 c7 c7 38 95 2a 82 c6 05 bc c6 fe 00 01 e8 0c 66 aa ff 0f 0b 5b c3 48 c7 c7 e0 94 2a 82 c6 05 a7 c6 fe 00 01 e8 f5 65 aa ff <0f> 0b 5b c3 90 8b 07 3d 00 00 00 c0 74 12 83 f8 01 74 13 8d 50 ff
   RSP: 0018:ffff8881008e3e40 EFLAGS: 00010286
   RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
   RDX: ffff88852c91b5c8 RSI: 0000000000000001 RDI: ffff88852c91b5c0
   RBP: ffff8881dacd4e00 R08: 00000000ffffffff R09: 0000000000000019
   R10: 000000000000072e R11: 0000000063666572 R12: ffff88812bfd9e00
   R13: ffff8881c792d200 R14: ffff88810011c005 R15: ffff8881002099c0
   FS:  0000000000000000(0000) GS:ffff88852c900000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 00007f5694b5e000 CR3: 00000001153f6003 CR4: 0000000000370ea0
   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   Call Trace:
    <TASK>
    ? refcount_warn_saturate+0x12b/0x130
    free_implicit_child_mr_work+0x180/0x1b0 [mlx5_ib]
    process_one_work+0x1cc/0x3c0
    worker_thread+0x218/0x3c0
    kthread+0xc6/0xf0
    ret_from_fork+0x1f/0x30
    </TASK>

Fixes: 5256edcb98a1 ("RDMA/mlx5: Rework implicit ODP destroy")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/r/c96b8645a81085abff739e6b06e286a350d1283d.1737274283.git.leon@kernel.org
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index f655859eec00..f1e23583e6c0 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -228,13 +228,27 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 	unsigned long idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
 	struct mlx5_ib_mr *imr = mr->parent;
 
+	/*
+	 * If userspace is racing freeing the parent implicit ODP MR then we can
+	 * loose the race with parent destruction. In this case
+	 * mlx5_ib_free_odp_mr() will free everything in the implicit_children
+	 * xarray so NOP is fine. This child MR cannot be destroyed here because
+	 * we are under its umem_mutex.
+	 */
 	if (!refcount_inc_not_zero(&imr->mmkey.usecount))
 		return;
 
-	xa_erase(&imr->implicit_children, idx);
+	xa_lock(&imr->implicit_children);
+	if (__xa_cmpxchg(&imr->implicit_children, idx, mr, NULL, GFP_KERNEL) !=
+	    mr) {
+		xa_unlock(&imr->implicit_children);
+		return;
+	}
+
 	if (MLX5_CAP_ODP(mr_to_mdev(mr)->mdev, mem_page_fault))
-		xa_erase(&mr_to_mdev(mr)->odp_mkeys,
-			 mlx5_base_mkey(mr->mmkey.key));
+		__xa_erase(&mr_to_mdev(mr)->odp_mkeys,
+			   mlx5_base_mkey(mr->mmkey.key));
+	xa_unlock(&imr->implicit_children);
 
 	/* Freeing a MR is a sleeping operation, so bounce to a work queue */
 	INIT_WORK(&mr->odp_destroy.work, free_implicit_child_mr_work);
@@ -502,18 +516,18 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 		refcount_inc(&ret->mmkey.usecount);
 		goto out_lock;
 	}
-	xa_unlock(&imr->implicit_children);
 
 	if (MLX5_CAP_ODP(dev->mdev, mem_page_fault)) {
-		ret = xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
-			       &mr->mmkey, GFP_KERNEL);
+		ret = __xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
+				 &mr->mmkey, GFP_KERNEL);
 		if (xa_is_err(ret)) {
 			ret = ERR_PTR(xa_err(ret));
-			xa_erase(&imr->implicit_children, idx);
-			goto out_mr;
+			__xa_erase(&imr->implicit_children, idx);
+			goto out_lock;
 		}
 		mr->mmkey.type = MLX5_MKEY_IMPLICIT_CHILD;
 	}
+	xa_unlock(&imr->implicit_children);
 	mlx5_ib_dbg(mr_to_mdev(imr), "key %x mr %p\n", mr->mmkey.key, mr);
 	return mr;
 


