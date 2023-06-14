Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E094D72C1EA
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbjFLLB1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236960AbjFLLBD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:01:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E621910CB
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:48:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82E9B624B0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959B0C433EF;
        Mon, 12 Jun 2023 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566887;
        bh=O2SMwIigMRuGd2AqCNVrq2RDZqggPIswy6Z/ONzdNvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Ia0NzWgQ/mw3joOxgRdGm+r0c+J5TnUWIJ7pZE85LQFNMeFckEBNOoBKt9eOlwfu
         TTdP6DGw5uh7RjCYm625YNyNJRoYSz9QEZbiqEKZEvGNObzpJ40MCajBdqWGgIa9Yl
         luaIzJ2RZGcbTwekuKjUgiyhFZecN6eE48TL/Ops=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 069/160] drm/msm/a6xx: initialize GMU mutex earlier
Date:   Mon, 12 Jun 2023 12:26:41 +0200
Message-ID: <20230612101718.171055770@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 12abd735f0300600bfc01b2a3832b966312df205 ]

Move GMU mutex initialization earlier to make sure that it is always
initialized. a6xx_destroy can be called from ther failure path before
GMU initialization.

This fixes the following backtrace:

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 58 at kernel/locking/mutex.c:582 __mutex_lock+0x1ec/0x3d0
Modules linked in:
CPU: 0 PID: 58 Comm: kworker/u16:1 Not tainted 6.3.0-rc5-00155-g187c06436519 #565
Hardware name: Qualcomm Technologies, Inc. SM8350 HDK (DT)
Workqueue: events_unbound deferred_probe_work_func
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock+0x1ec/0x3d0
lr : __mutex_lock+0x1ec/0x3d0
sp : ffff800008993620
x29: ffff800008993620 x28: 0000000000000002 x27: ffff47b253c52800
x26: 0000000001000606 x25: ffff47b240bb2810 x24: fffffffffffffff4
x23: 0000000000000000 x22: ffffc38bba15ac14 x21: 0000000000000002
x20: ffff800008993690 x19: ffff47b2430cc668 x18: fffffffffffe98f0
x17: 6f74616c75676572 x16: 20796d6d75642067 x15: 0000000000000038
x14: 0000000000000000 x13: ffffc38bbba050b8 x12: 0000000000000666
x11: 0000000000000222 x10: ffffc38bbba603e8 x9 : ffffc38bbba050b8
x8 : 00000000ffffefff x7 : ffffc38bbba5d0b8 x6 : 0000000000000222
x5 : 000000000000bff4 x4 : 40000000fffff222 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff47b240cb1880
Call trace:
 __mutex_lock+0x1ec/0x3d0
 mutex_lock_nested+0x2c/0x38
 a6xx_destroy+0xa0/0x138
 a6xx_gpu_init+0x41c/0x618
 adreno_bind+0x188/0x290
 component_bind_all+0x118/0x248
 msm_drm_bind+0x1c0/0x670
 try_to_bring_up_aggregate_device+0x164/0x1d0
 __component_add+0xa8/0x16c
 component_add+0x14/0x20
 dsi_dev_attach+0x20/0x2c
 dsi_host_attach+0x9c/0x144
 devm_mipi_dsi_attach+0x34/0xac
 lt9611uxc_attach_dsi.isra.0+0x84/0xfc
 lt9611uxc_probe+0x5b8/0x67c
 i2c_device_probe+0x1ac/0x358
 really_probe+0x148/0x2ac
 __driver_probe_device+0x78/0xe0
 driver_probe_device+0x3c/0x160
 __device_attach_driver+0xb8/0x138
 bus_for_each_drv+0x84/0xe0
 __device_attach+0x9c/0x188
 device_initial_probe+0x14/0x20
 bus_probe_device+0xac/0xb0
 deferred_probe_work_func+0x8c/0xc8
 process_one_work+0x2bc/0x594
 worker_thread+0x228/0x438
 kthread+0x108/0x10c
 ret_from_fork+0x10/0x20
irq event stamp: 299345
hardirqs last  enabled at (299345): [<ffffc38bb9ba61e4>] put_cpu_partial+0x1c8/0x22c
hardirqs last disabled at (299344): [<ffffc38bb9ba61dc>] put_cpu_partial+0x1c0/0x22c
softirqs last  enabled at (296752): [<ffffc38bb9890434>] _stext+0x434/0x4e8
softirqs last disabled at (296741): [<ffffc38bb989669c>] ____do_softirq+0x10/0x1c
---[ end trace 0000000000000000 ]---

Fixes: 4cd15a3e8b36 ("drm/msm/a6xx: Make GPU destroy a bit safer")
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Patchwork: https://patchwork.freedesktop.org/patch/531540/
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 --
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 7f5bc73b20402..611311b65b168 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1514,8 +1514,6 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	if (!pdev)
 		return -ENODEV;
 
-	mutex_init(&gmu->lock);
-
 	gmu->dev = &pdev->dev;
 
 	of_dma_configure(gmu->dev, node, true);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 6faea5049f765..2942d2548ce69 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1998,6 +1998,8 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	adreno_gpu = &a6xx_gpu->base;
 	gpu = &adreno_gpu->base;
 
+	mutex_init(&a6xx_gpu->gmu.lock);
+
 	adreno_gpu->registers = NULL;
 
 	/*
-- 
2.39.2



