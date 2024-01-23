Return-Path: <stable+bounces-14025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1595D837F30
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B22C1C23630
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA531292F5;
	Tue, 23 Jan 2024 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XgwwX1uo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CF1292EC;
	Tue, 23 Jan 2024 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970991; cv=none; b=V++0YWDxTDzt6uokF8V4U4IlUWTtrVXP0Xuytt3c1SDQQEgCUcBF3VTJjw1wu2nVeewl7y6uaM4vmS8YWfE+xcQmBRX+b5/t1Mkn8o9MZbZnuX3M1wp1PHCFRmLrk+Bmi5CjusQAT8iCAdaPmpTEmezeUzG+W/lK8nAmDXT7xzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970991; c=relaxed/simple;
	bh=prwFy78Ol7QTX1NglfKCR0Z7NbqkN2Hcmog2LQ0ixUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAIZa51Qcz7qeOL95Ej4Pael1BP86gTO/zaiD5hgSsfEQYNQ1G6ggmv2671l6T1MFaEd4SVET/hCLExrp/De3h0RjHUxDx7BrkHJs40f7pfD2/VR8APAGvHlPUYoP39if9vASShmilfearHL6FbzgDe28pWQBW7EbrXBJ3X4y/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XgwwX1uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50462C43390;
	Tue, 23 Jan 2024 00:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970991;
	bh=prwFy78Ol7QTX1NglfKCR0Z7NbqkN2Hcmog2LQ0ixUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgwwX1uo9Um3uyjijhR03MhqqlnzzDc2/IazDZ+au81qlfjFsxP7WR8sNXk86tqp0
	 E6StMAEn8b4xZxUceJTwP3+2q53TNWzWhEZlX6Ow5fWoXBFeAPBAmewKpKYeeub//F
	 oESfXFIgOlJV2DOGGlfKVhVyBFTlRIwZb0/wCCA0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 157/417] Revert "drm/omapdrm: Annotate dma-fence critical section in commit path"
Date: Mon, 22 Jan 2024 15:55:25 -0800
Message-ID: <20240122235757.289557377@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 9d7c8c066916f231ca0ed4e4fce6c4b58ca3e451 ]

This reverts commit 250aa22920cd5d956a5d3e9c6a43d671c2bae217.

The DMA-fence annotations cause a lockdep warning (see below). As per
https://patchwork.freedesktop.org/patch/462170/ it sounds like the
annotations don't work correctly.

======================================================
WARNING: possible circular locking dependency detected
6.5.0-rc2+ #2 Not tainted
------------------------------------------------------
kmstest/219 is trying to acquire lock:
c4705838 (&hdmi->lock){+.+.}-{3:3}, at: hdmi5_bridge_mode_set+0x1c/0x50

but task is already holding lock:
c11e1128 (dma_fence_map){++++}-{0:0}, at: omap_atomic_commit_tail+0x14/0xbc

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (dma_fence_map){++++}-{0:0}:
       __dma_fence_might_wait+0x48/0xb4
       dma_resv_lockdep+0x1b8/0x2bc
       do_one_initcall+0x68/0x3b0
       kernel_init_freeable+0x260/0x34c
       kernel_init+0x14/0x140
       ret_from_fork+0x14/0x28

-> #1 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire+0x70/0xa8
       __kmem_cache_alloc_node+0x3c/0x368
       kmalloc_trace+0x28/0x58
       _drm_do_get_edid+0x7c/0x35c
       hdmi5_bridge_get_edid+0xc8/0x1ac
       drm_bridge_connector_get_modes+0x64/0xc0
       drm_helper_probe_single_connector_modes+0x170/0x528
       drm_client_modeset_probe+0x208/0x1334
       __drm_fb_helper_initial_config_and_unlock+0x30/0x548
       omap_fbdev_client_hotplug+0x3c/0x6c
       drm_client_register+0x58/0x94
       pdev_probe+0x544/0x6b0
       platform_probe+0x58/0xbc
       really_probe+0xd8/0x3fc
       __driver_probe_device+0x94/0x1f4
       driver_probe_device+0x2c/0xc4
       __device_attach_driver+0xa4/0x11c
       bus_for_each_drv+0x84/0xdc
       __device_attach+0xac/0x20c
       bus_probe_device+0x8c/0x90
       device_add+0x588/0x7e0
       platform_device_add+0x110/0x24c
       platform_device_register_full+0x108/0x15c
       dss_bind+0x90/0xc0
       try_to_bring_up_aggregate_device+0x1e0/0x2c8
       __component_add+0xa4/0x174
       hdmi5_probe+0x1c8/0x270
       platform_probe+0x58/0xbc
       really_probe+0xd8/0x3fc
       __driver_probe_device+0x94/0x1f4
       driver_probe_device+0x2c/0xc4
       __device_attach_driver+0xa4/0x11c
       bus_for_each_drv+0x84/0xdc
       __device_attach+0xac/0x20c
       bus_probe_device+0x8c/0x90
       deferred_probe_work_func+0x8c/0xd8
       process_one_work+0x2ac/0x6e4
       worker_thread+0x30/0x4ec
       kthread+0x100/0x124
       ret_from_fork+0x14/0x28

-> #0 (&hdmi->lock){+.+.}-{3:3}:
       __lock_acquire+0x145c/0x29cc
       lock_acquire.part.0+0xb4/0x258
       __mutex_lock+0x90/0x950
       mutex_lock_nested+0x1c/0x24
       hdmi5_bridge_mode_set+0x1c/0x50
       drm_bridge_chain_mode_set+0x48/0x5c
       crtc_set_mode+0x188/0x1d0
       omap_atomic_commit_tail+0x2c/0xbc
       commit_tail+0x9c/0x188
       drm_atomic_helper_commit+0x158/0x18c
       drm_atomic_commit+0xa4/0xe8
       drm_mode_atomic_ioctl+0x9a4/0xc38
       drm_ioctl+0x210/0x4a8
       sys_ioctl+0x138/0xf00
       ret_fast_syscall+0x0/0x1c

other info that might help us debug this:

Chain exists of:
  &hdmi->lock --> fs_reclaim --> dma_fence_map

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(dma_fence_map);
                               lock(fs_reclaim);
                               lock(dma_fence_map);
  lock(&hdmi->lock);

 *** DEADLOCK ***

3 locks held by kmstest/219:
 #0: f1011de4 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_mode_atomic_ioctl+0xf0/0xc38
 #1: c47059c8 (crtc_ww_class_mutex){+.+.}-{3:3}, at: modeset_lock+0xf8/0x230
 #2: c11e1128 (dma_fence_map){++++}-{0:0}, at: omap_atomic_commit_tail+0x14/0xbc

stack backtrace:
CPU: 1 PID: 219 Comm: kmstest Not tainted 6.5.0-rc2+ #2
Hardware name: Generic DRA74X (Flattened Device Tree)
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x58/0x70
 dump_stack_lvl from check_noncircular+0x164/0x198
 check_noncircular from __lock_acquire+0x145c/0x29cc
 __lock_acquire from lock_acquire.part.0+0xb4/0x258
 lock_acquire.part.0 from __mutex_lock+0x90/0x950
 __mutex_lock from mutex_lock_nested+0x1c/0x24
 mutex_lock_nested from hdmi5_bridge_mode_set+0x1c/0x50
 hdmi5_bridge_mode_set from drm_bridge_chain_mode_set+0x48/0x5c
 drm_bridge_chain_mode_set from crtc_set_mode+0x188/0x1d0
 crtc_set_mode from omap_atomic_commit_tail+0x2c/0xbc
 omap_atomic_commit_tail from commit_tail+0x9c/0x188
 commit_tail from drm_atomic_helper_commit+0x158/0x18c
 drm_atomic_helper_commit from drm_atomic_commit+0xa4/0xe8
 drm_atomic_commit from drm_mode_atomic_ioctl+0x9a4/0xc38
 drm_mode_atomic_ioctl from drm_ioctl+0x210/0x4a8
 drm_ioctl from sys_ioctl+0x138/0xf00
 sys_ioctl from ret_fast_syscall+0x0/0x1c
Exception stack(0xf1011fa8 to 0xf1011ff0)
1fa0:                   00466d58 be9ab510 00000003 c03864bc be9ab510 be9ab4e0
1fc0: 00466d58 be9ab510 c03864bc 00000036 00466ef0 00466fc0 00467020 00466f20
1fe0: b6bc7ef4 be9ab4d0 b6bbbb00 b6cb2cc0

Fixes: 250aa22920cd ("drm/omapdrm: Annotate dma-fence critical section in commit path")
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230920-dma-fence-annotation-revert-v1-2-7ebf6f7f5bf6@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index eaf67b9e5f12..5b6d1668f405 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -68,7 +68,6 @@ static void omap_atomic_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
 	struct omap_drm_private *priv = dev->dev_private;
-	bool fence_cookie = dma_fence_begin_signalling();
 
 	dispc_runtime_get(priv->dispc);
 
@@ -91,6 +90,8 @@ static void omap_atomic_commit_tail(struct drm_atomic_state *old_state)
 		omap_atomic_wait_for_completion(dev, old_state);
 
 		drm_atomic_helper_commit_planes(dev, old_state, 0);
+
+		drm_atomic_helper_commit_hw_done(old_state);
 	} else {
 		/*
 		 * OMAP3 DSS seems to have issues with the work-around above,
@@ -100,11 +101,9 @@ static void omap_atomic_commit_tail(struct drm_atomic_state *old_state)
 		drm_atomic_helper_commit_planes(dev, old_state, 0);
 
 		drm_atomic_helper_commit_modeset_enables(dev, old_state);
-	}
 
-	drm_atomic_helper_commit_hw_done(old_state);
-
-	dma_fence_end_signalling(fence_cookie);
+		drm_atomic_helper_commit_hw_done(old_state);
+	}
 
 	/*
 	 * Wait for completion of the page flips to ensure that old buffers
-- 
2.43.0




