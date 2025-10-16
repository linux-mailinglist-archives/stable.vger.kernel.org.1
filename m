Return-Path: <stable+bounces-185980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C01BE2611
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2633BA3D5
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499012FF669;
	Thu, 16 Oct 2025 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u4b3oIhC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071ED2D3A7B
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606877; cv=none; b=K3H/OqjYBfpyGQ+CGoeyV7jWnHExPB1Zdz0qDoj2kaHilsi+O3147hGw+1Y/J4J6jBx/ce0SPMgqCnO6UZBikq47DWxsH6SBXyltUYkdDS6I7XSNgewyilteI9rGO3d509bzx/6Fxkn7+/ZwVBSvdaHtX0aK2mzy0L7cN+IozDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606877; c=relaxed/simple;
	bh=qZiqkd5kT2A05RQPAKWQNR2ayCmfUONHzsuql0bBGpI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XRHP5nBO6cQcMQUsHl8D7/tmBvCMF6c73WZ5DdH16xyri7d3Mn0BfrJe+csU4f4mFC7NVKME9+PtDdrQNoas5sYj4OIJEIpRmLtjDMqfNwbKadv2zHQ2G7eFrVcy5ba04ylmPu9D3duyRDLRVsQLsUlRJLRRtwvJewkQDN52nOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u4b3oIhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B30C4CEF1;
	Thu, 16 Oct 2025 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760606876;
	bh=qZiqkd5kT2A05RQPAKWQNR2ayCmfUONHzsuql0bBGpI=;
	h=Subject:To:Cc:From:Date:From;
	b=u4b3oIhCQWcRPdMdsH8crHvNmx2NpH6gRw4AASg00T8XXeJV/ua8omPrv/KJ0QPn7
	 5ZKlD/yw1trlB7Rdp6Df+l+bzLXfyPdIHnbR9ppmph3fmRxWg2PVsyTALpMo6L2fQG
	 YXEpviZ/zUEjs90q/a0I0I6JlLtoScmJL+LNP6eg=
Subject: FAILED: patch "[PATCH] drm/exynos: exynos7_drm_decon: remove ctx->suspended" failed to apply to 6.1-stable tree
To: kauschluss@disroot.org,inki.dae@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:27:40 +0200
Message-ID: <2025101640-sprig-fifth-f5a1@gregkh>
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
git cherry-pick -x e1361a4f1be9cb69a662c6d7b5ce218007d6e82b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101640-sprig-fifth-f5a1@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e1361a4f1be9cb69a662c6d7b5ce218007d6e82b Mon Sep 17 00:00:00 2001
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sun, 6 Jul 2025 22:59:46 +0530
Subject: [PATCH] drm/exynos: exynos7_drm_decon: remove ctx->suspended

Condition guards are found to be redundant, as the call flow is properly
managed now, as also observed in the Exynos5433 DECON driver. Since
state checking is no longer necessary, remove it.

This also fixes an issue which prevented decon_commit() from
decon_atomic_enable() due to an incorrect state change setting.

Fixes: 96976c3d9aff ("drm/exynos: Add DECON driver")
Cc: stable@vger.kernel.org
Suggested-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Signed-off-by: Inki Dae <inki.dae@samsung.com>

diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 805aa28c1723..b8d9b7251319 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -69,7 +69,6 @@ struct decon_context {
 	void __iomem			*regs;
 	unsigned long			irq_flags;
 	bool				i80_if;
-	bool				suspended;
 	wait_queue_head_t		wait_vsync_queue;
 	atomic_t			wait_vsync_event;
 
@@ -132,9 +131,6 @@ static void decon_shadow_protect_win(struct decon_context *ctx,
 
 static void decon_wait_for_vblank(struct decon_context *ctx)
 {
-	if (ctx->suspended)
-		return;
-
 	atomic_set(&ctx->wait_vsync_event, 1);
 
 	/*
@@ -210,9 +206,6 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 	struct drm_display_mode *mode = &crtc->base.state->adjusted_mode;
 	u32 val, clkdiv;
 
-	if (ctx->suspended)
-		return;
-
 	/* nothing to do if we haven't set the mode yet */
 	if (mode->htotal == 0 || mode->vtotal == 0)
 		return;
@@ -274,9 +267,6 @@ static int decon_enable_vblank(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	u32 val;
 
-	if (ctx->suspended)
-		return -EPERM;
-
 	if (!test_and_set_bit(0, &ctx->irq_flags)) {
 		val = readl(ctx->regs + VIDINTCON0);
 
@@ -299,9 +289,6 @@ static void decon_disable_vblank(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	u32 val;
 
-	if (ctx->suspended)
-		return;
-
 	if (test_and_clear_bit(0, &ctx->irq_flags)) {
 		val = readl(ctx->regs + VIDINTCON0);
 
@@ -404,9 +391,6 @@ static void decon_atomic_begin(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	for (i = 0; i < WINDOWS_NR; i++)
 		decon_shadow_protect_win(ctx, i, true);
 }
@@ -427,9 +411,6 @@ static void decon_update_plane(struct exynos_drm_crtc *crtc,
 	unsigned int pitch = fb->pitches[0];
 	unsigned int vidw_addr0_base = ctx->data->vidw_buf_start_base;
 
-	if (ctx->suspended)
-		return;
-
 	/*
 	 * SHADOWCON/PRTCON register is used for enabling timing.
 	 *
@@ -517,9 +498,6 @@ static void decon_disable_plane(struct exynos_drm_crtc *crtc,
 	unsigned int win = plane->index;
 	u32 val;
 
-	if (ctx->suspended)
-		return;
-
 	/* protect windows */
 	decon_shadow_protect_win(ctx, win, true);
 
@@ -538,9 +516,6 @@ static void decon_atomic_flush(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	for (i = 0; i < WINDOWS_NR; i++)
 		decon_shadow_protect_win(ctx, i, false);
 	exynos_crtc_handle_event(crtc);
@@ -568,9 +543,6 @@ static void decon_atomic_enable(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int ret;
 
-	if (!ctx->suspended)
-		return;
-
 	ret = pm_runtime_resume_and_get(ctx->dev);
 	if (ret < 0) {
 		DRM_DEV_ERROR(ctx->dev, "failed to enable DECON device.\n");
@@ -584,8 +556,6 @@ static void decon_atomic_enable(struct exynos_drm_crtc *crtc)
 		decon_enable_vblank(ctx->crtc);
 
 	decon_commit(ctx->crtc);
-
-	ctx->suspended = false;
 }
 
 static void decon_atomic_disable(struct exynos_drm_crtc *crtc)
@@ -593,9 +563,6 @@ static void decon_atomic_disable(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	/*
 	 * We need to make sure that all windows are disabled before we
 	 * suspend that connector. Otherwise we might try to scan from
@@ -605,8 +572,6 @@ static void decon_atomic_disable(struct exynos_drm_crtc *crtc)
 		decon_disable_plane(crtc, &ctx->planes[i]);
 
 	pm_runtime_put_sync(ctx->dev);
-
-	ctx->suspended = true;
 }
 
 static const struct exynos_drm_crtc_ops decon_crtc_ops = {
@@ -727,7 +692,6 @@ static int decon_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ctx->dev = dev;
-	ctx->suspended = true;
 	ctx->data = of_device_get_match_data(dev);
 
 	i80_if_timings = of_get_child_by_name(dev->of_node, "i80-if-timings");


