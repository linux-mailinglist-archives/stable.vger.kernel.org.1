Return-Path: <stable+bounces-187841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9672CBED0C7
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 15:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 097D134DBBF
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A928316DEB1;
	Sat, 18 Oct 2025 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPDR/yMN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F41BC3F
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760795825; cv=none; b=WyEOc/RcMLvCUKgzkc/SGMhZLAbTJhpsM2g/xD3gCr5+JaHhmfrz2R/rXmVGMAKwss69PbxAfLG+gt0vuhLfXHjA2bHI8Wk+vHtchvsuNVyKtjAypY8mr2pv/xpr3XQnZp/LaVzvwzm9FlXoIa5oj3mlq9rwvognPB7MUnmuFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760795825; c=relaxed/simple;
	bh=hzxt/YLLgOX3wqwS1ZWaSn54WvzG2SvRTAy2Gi+q/E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnKGqFGUsShQ0GRByvpnK/gvI7NjxGNjvNEMUcCHYMlitcHUb1eGCxaT7C7QbU6KtFejudCYeKZ5oOxTI6wQWgN97K8gN1grvU6OdMWkenMxOisqs0fFNN+P+iWDD72qrKIndvawhRH4nqdFHf4hSU1rc+z/sAI3N+iJKjHFUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPDR/yMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C3FC4CEF8;
	Sat, 18 Oct 2025 13:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760795822;
	bh=hzxt/YLLgOX3wqwS1ZWaSn54WvzG2SvRTAy2Gi+q/E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPDR/yMNw+rSPzLu+BzvtaiqX1B++5/zDaDMK9o6neDaNj3wO0kZX19B0MLJyoQgp
	 5+b19ElqXdPumZK/jAJp/+JktWvDZoxIiUzSNvUc5L5tXX5ayWAZFZarRjsZG358+B
	 sw/uPjA48Cp41i9cQM5qTY3j2EW1rOyAq3Igq3ESfYaBu9DWCTz1LqP9J27ePJb/uA
	 9k21iPJpa6K/W2lPbx/W7q5pfzcO1tvml86+W7MVoaLLksIfokvkIoxrc+Vt5Qe5JN
	 J2uy1McmIpCqN1jkCUjaJ52zpPreBmt6H9ugTvvAd3QVTS/5VVMzG6Guds3nYZ+iKz
	 oG/XYY2zwgQSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] drm/exynos: exynos7_drm_decon: remove ctx->suspended
Date: Sat, 18 Oct 2025 09:57:00 -0400
Message-ID: <20251018135700.715655-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101641-wistful-rebuff-94b8@gregkh>
References: <2025101641-wistful-rebuff-94b8@gregkh>
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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos7_drm_decon.c | 36 ----------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index a0049ee129ed2..344375293acee 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -51,7 +51,6 @@ struct decon_context {
 	void __iomem			*regs;
 	unsigned long			irq_flags;
 	bool				i80_if;
-	bool				suspended;
 	wait_queue_head_t		wait_vsync_queue;
 	atomic_t			wait_vsync_event;
 
@@ -85,9 +84,6 @@ static void decon_wait_for_vblank(struct exynos_drm_crtc *crtc)
 {
 	struct decon_context *ctx = crtc->ctx;
 
-	if (ctx->suspended)
-		return;
-
 	atomic_set(&ctx->wait_vsync_event, 1);
 
 	/*
@@ -155,9 +151,6 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 	struct drm_display_mode *mode = &crtc->base.state->adjusted_mode;
 	u32 val, clkdiv;
 
-	if (ctx->suspended)
-		return;
-
 	/* nothing to do if we haven't set the mode yet */
 	if (mode->htotal == 0 || mode->vtotal == 0)
 		return;
@@ -219,9 +212,6 @@ static int decon_enable_vblank(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	u32 val;
 
-	if (ctx->suspended)
-		return -EPERM;
-
 	if (!test_and_set_bit(0, &ctx->irq_flags)) {
 		val = readl(ctx->regs + VIDINTCON0);
 
@@ -244,9 +234,6 @@ static void decon_disable_vblank(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	u32 val;
 
-	if (ctx->suspended)
-		return;
-
 	if (test_and_clear_bit(0, &ctx->irq_flags)) {
 		val = readl(ctx->regs + VIDINTCON0);
 
@@ -369,9 +356,6 @@ static void decon_atomic_begin(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	for (i = 0; i < WINDOWS_NR; i++)
 		decon_shadow_protect_win(ctx, i, true);
 }
@@ -391,9 +375,6 @@ static void decon_update_plane(struct exynos_drm_crtc *crtc,
 	unsigned int cpp = fb->format->cpp[0];
 	unsigned int pitch = fb->pitches[0];
 
-	if (ctx->suspended)
-		return;
-
 	/*
 	 * SHADOWCON/PRTCON register is used for enabling timing.
 	 *
@@ -481,9 +462,6 @@ static void decon_disable_plane(struct exynos_drm_crtc *crtc,
 	unsigned int win = plane->index;
 	u32 val;
 
-	if (ctx->suspended)
-		return;
-
 	/* protect windows */
 	decon_shadow_protect_win(ctx, win, true);
 
@@ -502,9 +480,6 @@ static void decon_atomic_flush(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	for (i = 0; i < WINDOWS_NR; i++)
 		decon_shadow_protect_win(ctx, i, false);
 	exynos_crtc_handle_event(crtc);
@@ -531,9 +506,6 @@ static void decon_enable(struct exynos_drm_crtc *crtc)
 {
 	struct decon_context *ctx = crtc->ctx;
 
-	if (!ctx->suspended)
-		return;
-
 	pm_runtime_get_sync(ctx->dev);
 
 	decon_init(ctx);
@@ -543,8 +515,6 @@ static void decon_enable(struct exynos_drm_crtc *crtc)
 		decon_enable_vblank(ctx->crtc);
 
 	decon_commit(ctx->crtc);
-
-	ctx->suspended = false;
 }
 
 static void decon_disable(struct exynos_drm_crtc *crtc)
@@ -552,9 +522,6 @@ static void decon_disable(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	/*
 	 * We need to make sure that all windows are disabled before we
 	 * suspend that connector. Otherwise we might try to scan from
@@ -564,8 +531,6 @@ static void decon_disable(struct exynos_drm_crtc *crtc)
 		decon_disable_plane(crtc, &ctx->planes[i]);
 
 	pm_runtime_put_sync(ctx->dev);
-
-	ctx->suspended = true;
 }
 
 static const struct exynos_drm_crtc_ops decon_crtc_ops = {
@@ -687,7 +652,6 @@ static int decon_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ctx->dev = dev;
-	ctx->suspended = true;
 
 	i80_if_timings = of_get_child_by_name(dev->of_node, "i80-if-timings");
 	if (i80_if_timings)
-- 
2.51.0


