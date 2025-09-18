Return-Path: <stable+bounces-167999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437D9B232F1
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2E63AC3A6
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9292EAB97;
	Tue, 12 Aug 2025 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RXiYWllf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C233F9D2;
	Tue, 12 Aug 2025 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022702; cv=none; b=tdbtCgJ26YDPfYv7C/bedjqbW98BpAd+mUAOWb4JDDI+YGuHY5Ovoktx+Ll0DgBsR7hIAnKnqQmStCg+BvE7cRett6+i0luoeYK1VHgB+mCjIu2sPcX5dvoFO3kP43OqqO0teE1Su+crLSNRxwQt3m7LrI/kWz9MPHucU5NfGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022702; c=relaxed/simple;
	bh=MllYGKZS1k3oh1wAZCIJ/oLfafE0DffHJprD9cW26Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7Anf8pz2ZdFtuS6isZVjAt3ED+A4gCQIWvAAYdm7lHc1i7kcMXIOByCj1V4Mq0s9XSMiRMjCkMOVC1A+48S1ujKPAs1OHoGGXNFpgSeYMS3WdBLqMZ5d/BcFmofz4P3XqIqYj/sSNnwH32I5ir8i8U3HVNPimFUp5qIY9Rktb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RXiYWllf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF3EC4CEF6;
	Tue, 12 Aug 2025 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022702;
	bh=MllYGKZS1k3oh1wAZCIJ/oLfafE0DffHJprD9cW26Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXiYWllf2tqWfykjc8rWKWvPi1Hqf1FpfoYeppzXv+TNa6FFuNHC7twpRz3ho8TCi
	 pWQB9eggBcyYBrP6YIHYJriXAt2KKWADwRhiEfm9o4OeGmY6dHIJo3JWrq072Ekspy
	 4Q2XgJLVETsfcqZcltDbHIhJGYAeJ8ia0NnANS8A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Wenli Quan <wquan@redhat.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 233/369] vdpa/mlx5: Fix release of uninitialized resources on error path
Date: Tue, 12 Aug 2025 19:28:50 +0200
Message-ID: <20250812173023.536097189@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit cc51a66815999afb7e9cd845968de4fdf07567b7 ]

The commit in the fixes tag made sure that mlx5_vdpa_free()
is the single entrypoint for removing the vdpa device resources
added in mlx5_vdpa_dev_add(), even in the cleanup path of
mlx5_vdpa_dev_add().

This means that all functions from mlx5_vdpa_free() should be able to
handle uninitialized resources. This was not the case though:
mlx5_vdpa_destroy_mr_resources() and mlx5_cmd_cleanup_async_ctx()
were not able to do so. This caused the splat below when adding
a vdpa device without a MAC address.

This patch fixes these remaining issues:

- Makes mlx5_vdpa_destroy_mr_resources() return early if called on
  uninitialized resources.

- Moves mlx5_cmd_init_async_ctx() early on during device addition
  because it can't fail. This means that mlx5_cmd_cleanup_async_ctx()
  also can't fail. To mirror this, move the call site of
  mlx5_cmd_cleanup_async_ctx() in mlx5_vdpa_free().

An additional comment was added in mlx5_vdpa_free() to document
the expectations of functions called from this context.

Splat:

  mlx5_core 0000:b5:03.2: mlx5_vdpa_dev_add:3950:(pid 2306) warning: No mac address provisioned?
  ------------[ cut here ]------------
  WARNING: CPU: 13 PID: 2306 at kernel/workqueue.c:4207 __flush_work+0x9a/0xb0
  [...]
  Call Trace:
   <TASK>
   ? __try_to_del_timer_sync+0x61/0x90
   ? __timer_delete_sync+0x2b/0x40
   mlx5_vdpa_destroy_mr_resources+0x1c/0x40 [mlx5_vdpa]
   mlx5_vdpa_free+0x45/0x160 [mlx5_vdpa]
   vdpa_release_dev+0x1e/0x50 [vdpa]
   device_release+0x31/0x90
   kobject_cleanup+0x37/0x130
   mlx5_vdpa_dev_add+0x327/0x890 [mlx5_vdpa]
   vdpa_nl_cmd_dev_add_set_doit+0x2c1/0x4d0 [vdpa]
   genl_family_rcv_msg_doit+0xd8/0x130
   genl_family_rcv_msg+0x14b/0x220
   ? __pfx_vdpa_nl_cmd_dev_add_set_doit+0x10/0x10 [vdpa]
   genl_rcv_msg+0x47/0xa0
   ? __pfx_genl_rcv_msg+0x10/0x10
   netlink_rcv_skb+0x53/0x100
   genl_rcv+0x24/0x40
   netlink_unicast+0x27b/0x3b0
   netlink_sendmsg+0x1f7/0x430
   __sys_sendto+0x1fa/0x210
   ? ___pte_offset_map+0x17/0x160
   ? next_uptodate_folio+0x85/0x2b0
   ? percpu_counter_add_batch+0x51/0x90
   ? filemap_map_pages+0x515/0x660
   __x64_sys_sendto+0x20/0x30
   do_syscall_64+0x7b/0x2c0
   ? do_read_fault+0x108/0x220
   ? do_pte_missing+0x14a/0x3e0
   ? __handle_mm_fault+0x321/0x730
   ? count_memcg_events+0x13f/0x180
   ? handle_mm_fault+0x1fb/0x2d0
   ? do_user_addr_fault+0x20c/0x700
   ? syscall_exit_work+0x104/0x140
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f0c25b0feca
  [...]
  ---[ end trace 0000000000000000 ]---

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Fixes: 83e445e64f48 ("vdpa/mlx5: Fix error path during device add")
Reported-by: Wenli Quan <wquan@redhat.com>
Closes: https://lore.kernel.org/virtualization/CADZSLS0r78HhZAStBaN1evCSoPqRJU95Lt8AqZNJ6+wwYQ6vPQ@mail.gmail.com/
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Message-Id: <20250708120424.2363354-2-dtatulea@nvidia.com>
Tested-by: Wenli Quan <wquan@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/mlx5/core/mr.c       |  3 +++
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 61424342c096..c7a20278bc3c 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -908,6 +908,9 @@ void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
 {
 	struct mlx5_vdpa_mr_resources *mres = &mvdev->mres;
 
+	if (!mres->wq_gc)
+		return;
+
 	atomic_set(&mres->shutdown, 1);
 
 	flush_delayed_work(&mres->gc_dwork_ent);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 0e7b5147ffba..2e0b8c5bec8d 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3432,15 +3432,17 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 
+	/* Functions called here should be able to work with
+	 * uninitialized resources.
+	 */
 	free_fixed_resources(ndev);
 	mlx5_vdpa_clean_mrs(mvdev);
 	mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
-	mlx5_cmd_cleanup_async_ctx(&mvdev->async_ctx);
-
 	if (!is_zero_ether_addr(ndev->config.mac)) {
 		pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
 		mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
 	}
+	mlx5_cmd_cleanup_async_ctx(&mvdev->async_ctx);
 	mlx5_vdpa_free_resources(&ndev->mvdev);
 	free_irqs(ndev);
 	kfree(ndev->event_cbs);
@@ -3888,6 +3890,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	mvdev->actual_features =
 			(device_features & BIT_ULL(VIRTIO_F_VERSION_1));
 
+	mlx5_cmd_init_async_ctx(mdev, &mvdev->async_ctx);
+
 	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
 	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
 	if (!ndev->vqs || !ndev->event_cbs) {
@@ -3960,8 +3964,6 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		ndev->rqt_size = 1;
 	}
 
-	mlx5_cmd_init_async_ctx(mdev, &mvdev->async_ctx);
-
 	ndev->mvdev.mlx_features = device_features;
 	mvdev->vdev.dma_dev = &mdev->pdev->dev;
 	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
-- 
2.39.5




