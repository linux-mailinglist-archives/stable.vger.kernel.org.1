Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC37A1FDF
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 15:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjIONcj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 09:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjIONci (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 09:32:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B9E19AE
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 06:32:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so23288235e9.1
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694784751; x=1695389551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3XgW+IacAvazLOecGefgyANJIlYYQ15oISXzxazq2k=;
        b=TkSnOlfIBgpWxzEsbPN/3e/wRJ+ZvubT3Qcl3dnswl+ofAHJGH43k26N3KqcflIXfR
         pCMWEhcMiok2DTFdzO4vnA3Jjhp12WL6k53RQgHs4vBerQALcDkX25JmLSBaNrb46M9E
         QAycZ+4sDKYxSAP+R4OKTVURS/RIlyyEewJdE5IHkhpu6tpuXEySz+aXLoM4e4LvnMmY
         0es6Dq1klNUOKdwduzaHMc6tlHRsb0ppKICWD1dmtKW5XwWJrHYyRnC3/1lGe1i6skra
         UHOKvkW0JBri0etp1THnMaBqQdmSO7Q1uOBFRxLOmDSUNEbqD3jdypLwKvZiN2HnKjlm
         lRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784751; x=1695389551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3XgW+IacAvazLOecGefgyANJIlYYQ15oISXzxazq2k=;
        b=gx8Tz/S4Rjx/Vimxx7fX+rbxWSROinbGFx2rfAGQpALdQ5VdfkRxfw9f72di+yfM3R
         2TqTR9R8edi0YhvdHENY2V7hW3FlritZIt2nQpiz2SXPf5Kv7HNV0sIzEQQZ8debqO3W
         42Or55MDKxpj2Kv9MT5G9q6IPguDFPwrOWjdWGuzhzzdM0eKrSARJEsqmWMVkfZKe3xA
         0PHcwFEM3ESDtLaNvW1W9DxgDcyrZ4ilswWToXumqaXgwsA6hFZQZP0x9o1/zO5fKjUl
         HSMgaplGSTRAxmN3rfK5zQfHdMnDpN4j8F7dysbMTk+6FpUfj/HjR816CXTykMiH/ab3
         DljQ==
X-Gm-Message-State: AOJu0YxlWgH2wosaHVxJyG/R5pb7nbVHC5aEMsA/alBEoLywani68pUt
        0+FkvEkSov4nJJcj+QyROD//FUgVGCEBIhIN
X-Google-Smtp-Source: AGHT+IHfEdAtl6zEnZ0rIlhicmS3nN++NMDa+Pz51ggm1hWV04dWgXQYrm9UGpoMeN8+Rzo0h0IQoA==
X-Received: by 2002:a1c:6a1a:0:b0:401:aa8f:7562 with SMTP id f26-20020a1c6a1a000000b00401aa8f7562mr1636879wmc.11.1694784750532;
        Fri, 15 Sep 2023 06:32:30 -0700 (PDT)
Received: from orchid.. ([2a01:cb14:499:e600:1a5e:fff:fe3d:95be])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bc8c2000000b003fed70fb09dsm4690286wml.26.2023.09.15.06.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 06:32:30 -0700 (PDT)
From:   mathieu.tortuyaux@gmail.com
To:     stable@vger.kernel.org
Cc:     jpiotrowski@linux.microsoft.com,
        Saeed Mahameed <saeedm@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Mathieu Tortuyaux <mtortuyaux@microsoft.com>
Subject: [PATCH 6.1.y] net/mlx5: Free IRQ rmap and notifier on kernel shutdown
Date:   Fri, 15 Sep 2023 15:32:18 +0200
Message-ID: <20230915133218.100668-1-mathieu.tortuyaux@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023080706-enclosure-disobey-0b27@gregkh>
References: <2023080706-enclosure-disobey-0b27@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Saeed Mahameed <saeedm@nvidia.com>

commit 314ded538e5f22e7610b1bf621402024a180ec80 upstream

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
(cherry picked from commit 314ded538e5f22e7610b1bf621402024a180ec80)
Signed-off-by: Mathieu Tortuyaux <mtortuyaux@microsoft.com>
---
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 26 ++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 5e0f7d96aac5..d136360ac6a9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -123,18 +123,32 @@ int mlx5_set_msix_vec_count(struct mlx5_core_dev *dev, int function_id,
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
-	struct mlx5_irq_pool *pool = irq->pool;
-
-	xa_erase(&pool->irqs, irq->index);
 	/* free_irq requires that affinity_hint and rmap will be cleared
 	 * before calling it. This is why there is asymmetry with set_rmap
 	 * which should be called after alloc_irq but before request_irq.
 	 */
 	irq_update_affinity_hint(irq->irqn, NULL);
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
 
@@ -597,7 +611,7 @@ static void mlx5_irq_pool_free_irqs(struct mlx5_irq_pool *pool)
 	unsigned long index;
 
 	xa_for_each(&pool->irqs, index, irq)
-		free_irq(irq->irqn, &irq->nh);
+		mlx5_system_free_irq(irq);
 }
 
 static void mlx5_irq_pools_free_irqs(struct mlx5_irq_table *table)
-- 
2.41.0

