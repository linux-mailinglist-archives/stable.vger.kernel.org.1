Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB4D7ED0ED
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343924AbjKOT62 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbjKOT61 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:58:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF6AF
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:58:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CC9C433C9;
        Wed, 15 Nov 2023 19:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078303;
        bh=Lusyc2F+D4ECUNaYoTK2zoNuOMpT4mgQ+I0HzYbOaRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HgQWqDkTOcHrubMhfuBBVgnIVMCO2PTK4QIJT04YyL26DdLPPE5/gQCKaN6+V9oMK
         Y0U2ciWjYu5B+dXFkEKuKckntOwRvWXDhILmefDgVSOpHBe/4hArUdFcehUmkIasUz
         il4yOmyhMXaVmf8PT8HM4xI05gzrd98/yTYL0LK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leon Romanovsky <leon@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 239/379] IB/mlx5: Fix init stage error handling to avoid double free of same QP and UAF
Date:   Wed, 15 Nov 2023 14:25:14 -0500
Message-ID: <20231115192659.263454915@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: George Kennedy <george.kennedy@oracle.com>

[ Upstream commit 2ef422f063b74adcc4a4a9004b0a87bb55e0a836 ]

In the unlikely event that workqueue allocation fails and returns NULL in
mlx5_mkey_cache_init(), delete the call to
mlx5r_umr_resource_cleanup() (which frees the QP) in
mlx5_ib_stage_post_ib_reg_umr_init().  This will avoid attempted double
free of the same QP when __mlx5_ib_add() does its cleanup.

Resolves a splat:

   Syzkaller reported a UAF in ib_destroy_qp_user

   workqueue: Failed to create a rescuer kthread for wq "mkey_cache": -EINTR
   infiniband mlx5_0: mlx5_mkey_cache_init:981:(pid 1642):
   failed to create work queue
   infiniband mlx5_0: mlx5_ib_stage_post_ib_reg_umr_init:4075:(pid 1642):
   mr cache init failed -12
   ==================================================================
   BUG: KASAN: slab-use-after-free in ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2073)
   Read of size 8 at addr ffff88810da310a8 by task repro_upstream/1642

   Call Trace:
   <TASK>
   kasan_report (mm/kasan/report.c:590)
   ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2073)
   mlx5r_umr_resource_cleanup (drivers/infiniband/hw/mlx5/umr.c:198)
   __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4178)
   mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
   ...
   </TASK>

   Allocated by task 1642:
   __kmalloc (./include/linux/kasan.h:198 mm/slab_common.c:1026
   mm/slab_common.c:1039)
   create_qp (./include/linux/slab.h:603 ./include/linux/slab.h:720
   ./include/rdma/ib_verbs.h:2795 drivers/infiniband/core/verbs.c:1209)
   ib_create_qp_kernel (drivers/infiniband/core/verbs.c:1347)
   mlx5r_umr_resource_init (drivers/infiniband/hw/mlx5/umr.c:164)
   mlx5_ib_stage_post_ib_reg_umr_init (drivers/infiniband/hw/mlx5/main.c:4070)
   __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4168)
   mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
   ...

   Freed by task 1642:
   __kmem_cache_free (mm/slub.c:1826 mm/slub.c:3809 mm/slub.c:3822)
   ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2112)
   mlx5r_umr_resource_cleanup (drivers/infiniband/hw/mlx5/umr.c:198)
   mlx5_ib_stage_post_ib_reg_umr_init (drivers/infiniband/hw/mlx5/main.c:4076
   drivers/infiniband/hw/mlx5/main.c:4065)
   __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4168)
   mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
   ...

Fixes: 04876c12c19e ("RDMA/mlx5: Move init and cleanup of UMR to umr.c")
Link: https://lore.kernel.org/r/1698170518-4006-1-git-send-email-george.kennedy@oracle.com
Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 0baf3b5518b46..bce31e28eb303 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4027,10 +4027,8 @@ static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 		return ret;
 
 	ret = mlx5_mkey_cache_init(dev);
-	if (ret) {
+	if (ret)
 		mlx5_ib_warn(dev, "mr cache init failed %d\n", ret);
-		mlx5r_umr_resource_cleanup(dev);
-	}
 	return ret;
 }
 
-- 
2.42.0



