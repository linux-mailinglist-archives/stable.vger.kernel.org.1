Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C9F7A3D61
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241273AbjIQUmL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241339AbjIQUlu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:41:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D0C118
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:41:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAB2C433C8;
        Sun, 17 Sep 2023 20:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983304;
        bh=4KTDu8oG/KdDFNCJVscdnWRz/F0R+mFlYt+oMgrbpVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCBaAk88FTBMlxiMyOAR5Ob7tqXBcJuvXwgta76sFdAZ4ghHGx+HN2q6WqKl8siwV
         RB8l8nnEhjvJLiGqpqMbuNPLuVHE03RqGAaqwm3/rGL8QBlzpdNDV3HJJPIN4Isl9X
         yQ2rOA7mdwAcJgVb7yo2RcjXM361sTVT13RzZOKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Saeed Mahameed <saeedm@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Mathieu Tortuyaux <mtortuyaux@microsoft.com>
Subject: [PATCH 5.15 463/511] net/mlx5: Free IRQ rmap and notifier on kernel shutdown
Date:   Sun, 17 Sep 2023 21:14:50 +0200
Message-ID: <20230917191124.933072594@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saeed Mahameed <saeedm@nvidia.com>

commit 314ded538e5f22e7610b1bf621402024a180ec80 upstream.

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
Signed-off-by: Mathieu Tortuyaux <mtortuyaux@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -138,18 +138,23 @@ out:
 	return ret;
 }
 
-static void irq_release(struct mlx5_irq *irq)
+static void mlx5_system_free_irq(struct mlx5_irq *irq)
 {
-	struct mlx5_irq_pool *pool = irq->pool;
-
-	xa_erase(&pool->irqs, irq->index);
 	/* free_irq requires that affinity and rmap will be cleared
 	 * before calling it. This is why there is asymmetry with set_rmap
 	 * which should be called after alloc_irq but before request_irq.
 	 */
 	irq_set_affinity_hint(irq->irqn, NULL);
-	free_cpumask_var(irq->mask);
 	free_irq(irq->irqn, &irq->nh);
+}
+
+static void irq_release(struct mlx5_irq *irq)
+{
+	struct mlx5_irq_pool *pool = irq->pool;
+
+	xa_erase(&pool->irqs, irq->index);
+	mlx5_system_free_irq(irq);
+	free_cpumask_var(irq->mask);
 	kfree(irq);
 }
 
@@ -556,7 +561,7 @@ static void mlx5_irq_pool_free_irqs(stru
 	unsigned long index;
 
 	xa_for_each(&pool->irqs, index, irq)
-		free_irq(irq->irqn, &irq->nh);
+		mlx5_system_free_irq(irq);
 }
 
 static void mlx5_irq_pools_free_irqs(struct mlx5_irq_table *table)


