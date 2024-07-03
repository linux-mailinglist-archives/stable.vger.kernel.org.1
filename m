Return-Path: <stable+bounces-57127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F396925B21
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31FA286AA9
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A31A17279B;
	Wed,  3 Jul 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u+Eb7KRK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC017C221;
	Wed,  3 Jul 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003929; cv=none; b=FWWkd9U7b22dR1+FIOQdzgvzqwoeXqYkDbg8ueHz3O2kRe3bHC4yZpKaNLG6YIwELWr7pOye9JgdR2anWvq0HCfjYYDkRBj16+RHdbMdvqJBKOrlZ5J5PpUrMobJA1MjFEkTWclBG6nS1GWbr9QSYgLwHybcyWAw0OgqWGJYPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003929; c=relaxed/simple;
	bh=ZnIo+IBhKq++EkBhd5TEg136FIcFmNMlH0E5VcFeG0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LT+Ffc8iqG9KHixWk4LpgI9NsN9J4MeK8nPCu34Ah8TEh/y4KhJ7ENDFJOt07pbCOO8rEk1cbOzBIv7nZ7n5cf475nfmAfdX31Ry4jszrEQe3NMT0r54uywRXlwNuFw0pdQmE2RtvFqxLqyurynqlwVio3Z7+QPG0TO2ZCZH5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u+Eb7KRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90D2C2BD10;
	Wed,  3 Jul 2024 10:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003929;
	bh=ZnIo+IBhKq++EkBhd5TEg136FIcFmNMlH0E5VcFeG0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+Eb7KRKhA0lL5jZWFQNyDXACA62Uj35VonHr24Oxf2X6QtSWINWLMQMGi94GyGY0
	 lG92mtSbVZxPG3dQdcaNo8Kubl7VO8fh9v1OSd4VwK3ZAKtRNAh0SrBQMr5khbvZEf
	 6uetvv71VInVZUF05KAGbx3oO7xPTSj1NuAzRrfE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Inki Dae <inki.dae@samsung.com>
Subject: [PATCH 5.4 068/189] drm/exynos: hdmi: report safe 640x480 mode as a fallback when no EDID found
Date: Wed,  3 Jul 2024 12:38:49 +0200
Message-ID: <20240703102844.074720147@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 799d4b392417ed6889030a5b2335ccb6dcf030ab upstream.

When reading EDID fails and driver reports no modes available, the DRM
core adds an artificial 1024x786 mode to the connector. Unfortunately
some variants of the Exynos HDMI (like the one in Exynos4 SoCs) are not
able to drive such mode, so report a safe 640x480 mode instead of nothing
in case of the EDID reading failure.

This fixes the following issue observed on Trats2 board since commit
13d5b040363c ("drm/exynos: do not return negative values from .get_modes()"):

[drm] Exynos DRM: using 11c00000.fimd device for DMA mapping operations
exynos-drm exynos-drm: bound 11c00000.fimd (ops fimd_component_ops)
exynos-drm exynos-drm: bound 12c10000.mixer (ops mixer_component_ops)
exynos-dsi 11c80000.dsi: [drm:samsung_dsim_host_attach] Attached s6e8aa0 device (lanes:4 bpp:24 mode-flags:0x10b)
exynos-drm exynos-drm: bound 11c80000.dsi (ops exynos_dsi_component_ops)
exynos-drm exynos-drm: bound 12d00000.hdmi (ops hdmi_component_ops)
[drm] Initialized exynos 1.1.0 20180330 for exynos-drm on minor 1
exynos-hdmi 12d00000.hdmi: [drm:hdmiphy_enable.part.0] *ERROR* PLL could not reach steady state
panel-samsung-s6e8aa0 11c80000.dsi.0: ID: 0xa2, 0x20, 0x8c
exynos-mixer 12c10000.mixer: timeout waiting for VSYNC
------------[ cut here ]------------
WARNING: CPU: 1 PID: 11 at drivers/gpu/drm/drm_atomic_helper.c:1682 drm_atomic_helper_wait_for_vblanks.part.0+0x2b0/0x2b8
[CRTC:70:crtc-1] vblank wait timed out
Modules linked in:
CPU: 1 PID: 11 Comm: kworker/u16:0 Not tainted 6.9.0-rc5-next-20240424 #14913
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
Call trace:
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x68/0x88
 dump_stack_lvl from __warn+0x7c/0x1c4
 __warn from warn_slowpath_fmt+0x11c/0x1a8
 warn_slowpath_fmt from drm_atomic_helper_wait_for_vblanks.part.0+0x2b0/0x2b8
 drm_atomic_helper_wait_for_vblanks.part.0 from drm_atomic_helper_commit_tail_rpm+0x7c/0x8c
 drm_atomic_helper_commit_tail_rpm from commit_tail+0x9c/0x184
 commit_tail from drm_atomic_helper_commit+0x168/0x190
 drm_atomic_helper_commit from drm_atomic_commit+0xb4/0xe0
 drm_atomic_commit from drm_client_modeset_commit_atomic+0x23c/0x27c
 drm_client_modeset_commit_atomic from drm_client_modeset_commit_locked+0x60/0x1cc
 drm_client_modeset_commit_locked from drm_client_modeset_commit+0x24/0x40
 drm_client_modeset_commit from __drm_fb_helper_restore_fbdev_mode_unlocked+0x9c/0xc4
 __drm_fb_helper_restore_fbdev_mode_unlocked from drm_fb_helper_set_par+0x2c/0x3c
 drm_fb_helper_set_par from fbcon_init+0x3d8/0x550
 fbcon_init from visual_init+0xc0/0x108
 visual_init from do_bind_con_driver+0x1b8/0x3a4
 do_bind_con_driver from do_take_over_console+0x140/0x1ec
 do_take_over_console from do_fbcon_takeover+0x70/0xd0
 do_fbcon_takeover from fbcon_fb_registered+0x19c/0x1ac
 fbcon_fb_registered from register_framebuffer+0x190/0x21c
 register_framebuffer from __drm_fb_helper_initial_config_and_unlock+0x350/0x574
 __drm_fb_helper_initial_config_and_unlock from exynos_drm_fbdev_client_hotplug+0x6c/0xb0
 exynos_drm_fbdev_client_hotplug from drm_client_register+0x58/0x94
 drm_client_register from exynos_drm_bind+0x160/0x190
 exynos_drm_bind from try_to_bring_up_aggregate_device+0x200/0x2d8
 try_to_bring_up_aggregate_device from __component_add+0xb0/0x170
 __component_add from mixer_probe+0x74/0xcc
 mixer_probe from platform_probe+0x5c/0xb8
 platform_probe from really_probe+0xe0/0x3d8
 really_probe from __driver_probe_device+0x9c/0x1e4
 __driver_probe_device from driver_probe_device+0x30/0xc0
 driver_probe_device from __device_attach_driver+0xa8/0x120
 __device_attach_driver from bus_for_each_drv+0x80/0xcc
 bus_for_each_drv from __device_attach+0xac/0x1fc
 __device_attach from bus_probe_device+0x8c/0x90
 bus_probe_device from deferred_probe_work_func+0x98/0xe0
 deferred_probe_work_func from process_one_work+0x240/0x6d0
 process_one_work from worker_thread+0x1a0/0x3f4
 worker_thread from kthread+0x104/0x138
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xf0895fb0 to 0xf0895ff8)
...
irq event stamp: 82357
hardirqs last  enabled at (82363): [<c01a96e8>] vprintk_emit+0x308/0x33c
hardirqs last disabled at (82368): [<c01a969c>] vprintk_emit+0x2bc/0x33c
softirqs last  enabled at (81614): [<c0101644>] __do_softirq+0x320/0x500
softirqs last disabled at (81609): [<c012dfe0>] __irq_exit_rcu+0x130/0x184
---[ end trace 0000000000000000 ]---
exynos-drm exynos-drm: [drm] *ERROR* flip_done timed out
exynos-drm exynos-drm: [drm] *ERROR* [CRTC:70:crtc-1] commit wait timed out
exynos-drm exynos-drm: [drm] *ERROR* flip_done timed out
exynos-drm exynos-drm: [drm] *ERROR* [CONNECTOR:74:HDMI-A-1] commit wait timed out
exynos-drm exynos-drm: [drm] *ERROR* flip_done timed out
exynos-drm exynos-drm: [drm] *ERROR* [PLANE:56:plane-5] commit wait timed out
exynos-mixer 12c10000.mixer: timeout waiting for VSYNC

Cc: stable@vger.kernel.org
Fixes: 13d5b040363c ("drm/exynos: do not return negative values from .get_modes()")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -876,11 +876,11 @@ static int hdmi_get_modes(struct drm_con
 	int ret;
 
 	if (!hdata->ddc_adpt)
-		return 0;
+		goto no_edid;
 
 	edid = drm_get_edid(connector, hdata->ddc_adpt);
 	if (!edid)
-		return 0;
+		goto no_edid;
 
 	hdata->dvi_mode = !drm_detect_hdmi_monitor(edid);
 	DRM_DEV_DEBUG_KMS(hdata->dev, "%s : width[%d] x height[%d]\n",
@@ -895,6 +895,9 @@ static int hdmi_get_modes(struct drm_con
 	kfree(edid);
 
 	return ret;
+
+no_edid:
+	return drm_add_modes_noedid(connector, 640, 480);
 }
 
 static int hdmi_find_phy_conf(struct hdmi_context *hdata, u32 pixel_clock)



