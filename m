Return-Path: <stable+bounces-187796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D00BEC581
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F766E8911
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01545239E88;
	Sat, 18 Oct 2025 02:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myDJ98fz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42BB23535E
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760754901; cv=none; b=ZX7SiGMXLvDL6RcTwsRC2ci2upXJWZEDHU/llQyU3UBtbsOxnQ/LTLuwmquLm1t+Xb+l9mDOzfnRinRYBzI0iJbJr9LwkaSzU67ze1BWZWfz7KgRCx3/39/1JTvwLuon0myPPQkWiIWUm4//gzP7Sx/nDbefG1uqIVIaKq7vFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760754901; c=relaxed/simple;
	bh=CVyWQRupTTIv3/VQC2sbmShwP+xNG/ya80I52kzrjJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzXP9Dj5+IpQkCA6QlTLldH0jEjPlFi8FMiu25Uswp+SI1iSsJ7+oXl6udIXE6AtybyELx+irLBmbVL8Vs+j0oWELnr2xlWxZbrzH9/l4aYZEyiip7EkkyfisJmRUQCzltjZN0ZEzpwg4kXSGGBKL199LMXa1D2T0k5IuO12PrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myDJ98fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13BEC116B1;
	Sat, 18 Oct 2025 02:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760754901;
	bh=CVyWQRupTTIv3/VQC2sbmShwP+xNG/ya80I52kzrjJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=myDJ98fzPUvGZXkKuV2vu6iNwkQod5pz6Rfd5WSZgd+b7rvcLbTRzgu4/2LWDEmfp
	 Wl1eX9AhPYyGW47OLX1bq1T0jR+H21NAXps+5P9rtMvvBuJ2E4J9M6MBtwzhbMBxpa
	 VHTca6pL/whDFopJaBq0wBejX8LU6bMn7ufmwn+dO5r8Xi/c3fL76R9cgdXQf3v7tT
	 P763Nu86Kj7nYrTfaDoyYKuBeN0OdBhpCTnM69vrcMN+JORHbornyjsqxXWmlgFOtj
	 hN6HMR3HKDIuAttS1bo8jhr10chsil+erEXCDrxiO/4t/S0u6mVw9o2EiVIFwSJgP3
	 KWOgWRKg9Mxhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] drm/exynos: exynos7_drm_decon: remove ctx->suspended
Date: Fri, 17 Oct 2025 22:34:57 -0400
Message-ID: <20251018023457.221641-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018023457.221641-1-sashal@kernel.org>
References: <2025101640-enviable-movable-b2dd@gregkh>
 <20251018023457.221641-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaustabh Chakraborty <kauschluss@disroot.org>

[ Upstream commit e1361a4f1be9cb69a662c6d7b5ce218007d6e82b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos7_drm_decon.c | 36 ----------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 46a1b61a500b3..cfc68e3f808ab 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -51,7 +51,6 @@ struct decon_context {
 	void __iomem			*regs;
 	unsigned long			irq_flags;
 	bool				i80_if;
-	bool				suspended;
 	wait_queue_head_t		wait_vsync_queue;
 	atomic_t			wait_vsync_event;
 
@@ -105,9 +104,6 @@ static void decon_shadow_protect_win(struct decon_context *ctx,
 
 static void decon_wait_for_vblank(struct decon_context *ctx)
 {
-	if (ctx->suspended)
-		return;
-
 	atomic_set(&ctx->wait_vsync_event, 1);
 
 	/*
@@ -183,9 +179,6 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 	struct drm_display_mode *mode = &crtc->base.state->adjusted_mode;
 	u32 val, clkdiv;
 
-	if (ctx->suspended)
-		return;
-
 	/* nothing to do if we haven't set the mode yet */
 	if (mode->htotal == 0 || mode->vtotal == 0)
 		return;
@@ -247,9 +240,6 @@ static int decon_enable_vblank(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	u32 val;
 
-	if (ctx->suspended)
-		return -EPERM;
-
 	if (!test_and_set_bit(0, &ctx->irq_flags)) {
 		val = readl(ctx->regs + VIDINTCON0);
 
@@ -272,9 +262,6 @@ static void decon_disable_vblank(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	u32 val;
 
-	if (ctx->suspended)
-		return;
-
 	if (test_and_clear_bit(0, &ctx->irq_flags)) {
 		val = readl(ctx->regs + VIDINTCON0);
 
@@ -376,9 +363,6 @@ static void decon_atomic_begin(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	for (i = 0; i < WINDOWS_NR; i++)
 		decon_shadow_protect_win(ctx, i, true);
 }
@@ -398,9 +382,6 @@ static void decon_update_plane(struct exynos_drm_crtc *crtc,
 	unsigned int cpp = fb->format->cpp[0];
 	unsigned int pitch = fb->pitches[0];
 
-	if (ctx->suspended)
-		return;
-
 	/*
 	 * SHADOWCON/PRTCON register is used for enabling timing.
 	 *
@@ -488,9 +469,6 @@ static void decon_disable_plane(struct exynos_drm_crtc *crtc,
 	unsigned int win = plane->index;
 	u32 val;
 
-	if (ctx->suspended)
-		return;
-
 	/* protect windows */
 	decon_shadow_protect_win(ctx, win, true);
 
@@ -509,9 +487,6 @@ static void decon_atomic_flush(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	for (i = 0; i < WINDOWS_NR; i++)
 		decon_shadow_protect_win(ctx, i, false);
 	exynos_crtc_handle_event(crtc);
@@ -539,9 +514,6 @@ static void decon_atomic_enable(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int ret;
 
-	if (!ctx->suspended)
-		return;
-
 	ret = pm_runtime_resume_and_get(ctx->dev);
 	if (ret < 0) {
 		DRM_DEV_ERROR(ctx->dev, "failed to enable DECON device.\n");
@@ -555,8 +527,6 @@ static void decon_atomic_enable(struct exynos_drm_crtc *crtc)
 		decon_enable_vblank(ctx->crtc);
 
 	decon_commit(ctx->crtc);
-
-	ctx->suspended = false;
 }
 
 static void decon_atomic_disable(struct exynos_drm_crtc *crtc)
@@ -564,9 +534,6 @@ static void decon_atomic_disable(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	/*
 	 * We need to make sure that all windows are disabled before we
 	 * suspend that connector. Otherwise we might try to scan from
@@ -576,8 +543,6 @@ static void decon_atomic_disable(struct exynos_drm_crtc *crtc)
 		decon_disable_plane(crtc, &ctx->planes[i]);
 
 	pm_runtime_put_sync(ctx->dev);
-
-	ctx->suspended = true;
 }
 
 static const struct exynos_drm_crtc_ops decon_crtc_ops = {
@@ -699,7 +664,6 @@ static int decon_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ctx->dev = dev;
-	ctx->suspended = true;
 
 	i80_if_timings = of_get_child_by_name(dev->of_node, "i80-if-timings");
 	if (i80_if_timings)
-- 
2.51.0


