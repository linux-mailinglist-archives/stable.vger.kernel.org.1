Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31FB771BE7
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 09:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjHGH5X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 03:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHGH5W (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 03:57:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38B110F4
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 00:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 780B1615C1
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C400C433C8;
        Mon,  7 Aug 2023 07:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691395039;
        bh=GduS/h6j5XpEKFLSfMDyJbf6hIv+MNPT3XU+T7mDQYY=;
        h=Subject:To:Cc:From:Date:From;
        b=C2BW7/dJN48vngCPVp++BJ2pMYSGCZBb7zxXL6gIjwy7kEpt3X5B2Oh6kXMLFdTpH
         To8CTfuzYRZq5iqDdSNPXDTCtHCQqd0bW1f7lTuuZTT2MyrKH6QAkO4rGjX+sVah19
         DE9NjZ5XUJUnNd/6YEnPNeGyDUUAjfLfFaxMqJMk=
Subject: FAILED: patch "[PATCH] net/mlx5: Free IRQ rmap and notifier on kernel shutdown" failed to apply to 5.15-stable tree
To:     saeedm@nvidia.com, shayd@nvidia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 09:57:08 +0200
Message-ID: <2023080708-livable-distress-7173@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 314ded538e5f22e7610b1bf621402024a180ec80
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080708-livable-distress-7173@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

314ded538e5f ("net/mlx5: Free IRQ rmap and notifier on kernel shutdown")
1da438c0ae02 ("net/mlx5: Fix indexing of mlx5_irq")
9c2d08010963 ("net/mlx5: Free irqs only on shutdown callback")
3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
8bebfd767909 ("net/mlx5: Improve naming of pci function vectors")
bbac70c74183 ("net/mlx5: Use newer affinity descriptor")
235a25fe28de ("net/mlx5: Modify struct mlx5_irq to use struct msi_map")
2acda57736de ("net/mlx5e: Improve remote NUMA preferences used for the IRQ affinity hints")
147cc5838c0f ("Merge tag 'irq-core-2022-01-13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 314ded538e5f22e7610b1bf621402024a180ec80 Mon Sep 17 00:00:00 2001
From: Saeed Mahameed <saeedm@nvidia.com>
Date: Thu, 8 Jun 2023 12:00:54 -0700
Subject: [PATCH] net/mlx5: Free IRQ rmap and notifier on kernel shutdown

The kernel IRQ system needs the irq affinity notifier to be clear
before attempting to free the irq, see WARN_ON log below.

On a normal driver unload we don't have this issue since we do the
complete cleanup of the irq resources.

To fix this, put the important resources cleanup in a helper function
and use it in both normal driver unload and shutdown flows.

[ 4497.498434] ------------[ cut here ]------------
[ 4497.498726] WARNING: CPU: 0 PID: 9 at kernel/irq/manage.c:2034 free_irq+0x295/0x340
[ 4497.499193] Modules linked in:
[ 4497.499386] CPU: 0 PID: 9 Comm: kworker/0:1 Tainted: G        W          6.4.0-rc4+ #10
[ 4497.499876] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
[ 4497.500518] Workqueue: events do_poweroff
[ 4497.500849] RIP: 0010:free_irq+0x295/0x340
[ 4497.501132] Code: 85 c0 0f 84 1d ff ff ff 48 89 ef ff d0 0f 1f 00 e9 10 ff ff ff 0f 0b e9 72 ff ff ff 49 8d 7f 28 ff d0 0f 1f 00 e9 df fd ff ff <0f> 0b 48 c7 80 c0 008
[ 4497.502269] RSP: 0018:ffffc90000053da0 EFLAGS: 00010282
[ 4497.502589] RAX: ffff888100949600 RBX: ffff88810330b948 RCX: 0000000000000000
[ 4497.503035] RDX: ffff888100949600 RSI: ffff888100400490 RDI: 0000000000000023
[ 4497.503472] RBP: ffff88810330c7e0 R08: ffff8881004005d0 R09: ffffffff8273a260
[ 4497.503923] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881009ae000
[ 4497.504359] R13: ffff8881009ae148 R14: 0000000000000000 R15: ffff888100949600
[ 4497.504804] FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
[ 4497.505302] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4497.505671] CR2: 00007fce98806298 CR3: 000000000262e005 CR4: 0000000000370ef0
[ 4497.506104] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4497.506540] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4497.507002] Call Trace:
[ 4497.507158]  <TASK>
[ 4497.507299]  ? free_irq+0x295/0x340
[ 4497.507522]  ? __warn+0x7c/0x130
[ 4497.507740]  ? free_irq+0x295/0x340
[ 4497.507963]  ? report_bug+0x171/0x1a0
[ 4497.508197]  ? handle_bug+0x3c/0x70
[ 4497.508417]  ? exc_invalid_op+0x17/0x70
[ 4497.508662]  ? asm_exc_invalid_op+0x1a/0x20
[ 4497.508926]  ? free_irq+0x295/0x340
[ 4497.509146]  mlx5_irq_pool_free_irqs+0x48/0x90
[ 4497.509421]  mlx5_irq_table_free_irqs+0x38/0x50
[ 4497.509714]  mlx5_core_eq_free_irqs+0x27/0x40
[ 4497.509984]  shutdown+0x7b/0x100
[ 4497.510184]  pci_device_shutdown+0x30/0x60
[ 4497.510440]  device_shutdown+0x14d/0x240
[ 4497.510698]  kernel_power_off+0x30/0x70
[ 4497.510938]  process_one_work+0x1e6/0x3e0
[ 4497.511183]  worker_thread+0x49/0x3b0
[ 4497.511407]  ? __pfx_worker_thread+0x10/0x10
[ 4497.511679]  kthread+0xe0/0x110
[ 4497.511879]  ? __pfx_kthread+0x10/0x10
[ 4497.512114]  ret_from_fork+0x29/0x50
[ 4497.512342]  </TASK>

Fixes: 9c2d08010963 ("net/mlx5: Free irqs only on shutdown callback")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 33b9359de53d..98412bd5a696 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -126,14 +126,22 @@ int mlx5_set_msix_vec_count(struct mlx5_core_dev *dev, int function_id,
 	return ret;
 }
 
-static void irq_release(struct mlx5_irq *irq)
+/* mlx5_system_free_irq - Free an IRQ
+ * @irq: IRQ to free
+ *
+ * Free the IRQ and other resources such as rmap from the system.
+ * BUT doesn't free or remove reference from mlx5.
+ * This function is very important for the shutdown flow, where we need to
+ * cleanup system resoruces but keep mlx5 objects alive,
+ * see mlx5_irq_table_free_irqs().
+ */
+static void mlx5_system_free_irq(struct mlx5_irq *irq)
 {
 	struct mlx5_irq_pool *pool = irq->pool;
 #ifdef CONFIG_RFS_ACCEL
 	struct cpu_rmap *rmap;
 #endif
 
-	xa_erase(&pool->irqs, irq->pool_index);
 	/* free_irq requires that affinity_hint and rmap will be cleared before
 	 * calling it. To satisfy this requirement, we call
 	 * irq_cpu_rmap_remove() to remove the notifier
@@ -145,10 +153,18 @@ static void irq_release(struct mlx5_irq *irq)
 		irq_cpu_rmap_remove(rmap, irq->map.virq);
 #endif
 
-	free_cpumask_var(irq->mask);
 	free_irq(irq->map.virq, &irq->nh);
 	if (irq->map.index && pci_msix_can_alloc_dyn(pool->dev->pdev))
 		pci_msix_free_irq(pool->dev->pdev, irq->map);
+}
+
+static void irq_release(struct mlx5_irq *irq)
+{
+	struct mlx5_irq_pool *pool = irq->pool;
+
+	xa_erase(&pool->irqs, irq->pool_index);
+	mlx5_system_free_irq(irq);
+	free_cpumask_var(irq->mask);
 	kfree(irq);
 }
 
@@ -705,7 +721,8 @@ static void mlx5_irq_pool_free_irqs(struct mlx5_irq_pool *pool)
 	unsigned long index;
 
 	xa_for_each(&pool->irqs, index, irq)
-		free_irq(irq->map.virq, &irq->nh);
+		mlx5_system_free_irq(irq);
+
 }
 
 static void mlx5_irq_pools_free_irqs(struct mlx5_irq_table *table)

