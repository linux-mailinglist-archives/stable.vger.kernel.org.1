Return-Path: <stable+bounces-187782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6A3BEC4FB
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDDCA4F3533
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3CD21770A;
	Sat, 18 Oct 2025 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sV2yBadF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D519F41C
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760753119; cv=none; b=FISe167quQ19842NDTUCg5ZZ9eXwczuTLvAqHjSbva9KceFN2SdF8VoGpBJKXOYD0LNfC5euLX4HtruBCh8G0ND4sRrsoRapMG3AnGDXGDetcPQlP+e+dWyPP2NE7FioQqmYiwtZ8zBOrbwnL6cWQMp68ToT0GEPH+6yoiV4m34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760753119; c=relaxed/simple;
	bh=75Wm0rHny60eHA0JJ+Pvpn1z7ztul8ouLF0DEFE13hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Al0Wa0kwMEAX7UZjP3vS7oq4BlJll2uocuhtZrzdPLwWqGLPHjCCFYWanWv1CsUeMWIHspdb0/JuQCJmhzpvSiR5wcZPOlWQ+PCPFOb3w6koRPYAvBfnlYtoLOCPIlu/HrnfIB82z+16SqInl/hWGmSZd05HhVG/NsK54HaouWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sV2yBadF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84022C4CEE7;
	Sat, 18 Oct 2025 02:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760753119;
	bh=75Wm0rHny60eHA0JJ+Pvpn1z7ztul8ouLF0DEFE13hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sV2yBadFBfaspwvQnvUih9StLpQ/YoPH5EQfU+0PKQWvQO4WHPNazqLLcZ5sM+kuO
	 Had3Q6rm3LnPEQ+I2w+CZTlGjostZLuJDriWimAwWH+lUizq8ONL6B4VqgkoLyafxh
	 8ts/0cOSTrh7DjwcbtVMLJ3Xp3an0MtFA71pULYZ6x0KRkWFBxZTfXP2ATqfd61Y5I
	 a1D0PFnFrncshSeJcW2UkX4Ebr3wNNIcIVYGdjBL0tPmSuoL9vbHsa3qjmQMuq2GtR
	 Ao4XZGbtL4MXvlfmwmBjP1Q1ejjpP54cQvMfHO7Ap4IQCWi9+jrQDZmauEyy21DlmI
	 WvuPwJHJ0YPIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] drm/exynos: exynos7_drm_decon: fix uninitialized crtc reference in functions
Date: Fri, 17 Oct 2025 22:05:13 -0400
Message-ID: <20251018020515.208843-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101639-survey-affix-387d@gregkh>
References: <2025101639-survey-affix-387d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaustabh Chakraborty <kauschluss@disroot.org>

[ Upstream commit d31bbacf783daf1e71fbe5c68df93550c446bf44 ]

Modify the functions to accept a pointer to struct decon_context
instead.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Stable-dep-of: e1361a4f1be9 ("drm/exynos: exynos7_drm_decon: remove ctx->suspended")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos7_drm_decon.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 9eeba254cf45d..99cc3f6803c7a 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -81,10 +81,8 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 	DRM_PLANE_TYPE_CURSOR,
 };
 
-static void decon_wait_for_vblank(struct exynos_drm_crtc *crtc)
+static void decon_wait_for_vblank(struct decon_context *ctx)
 {
-	struct decon_context *ctx = crtc->ctx;
-
 	if (ctx->suspended)
 		return;
 
@@ -100,9 +98,8 @@ static void decon_wait_for_vblank(struct exynos_drm_crtc *crtc)
 		DRM_DEV_DEBUG_KMS(ctx->dev, "vblank wait timed out.\n");
 }
 
-static void decon_clear_channels(struct exynos_drm_crtc *crtc)
+static void decon_clear_channels(struct decon_context *ctx)
 {
-	struct decon_context *ctx = crtc->ctx;
 	unsigned int win, ch_enabled = 0;
 
 	/* Check if any channel is enabled. */
@@ -118,7 +115,7 @@ static void decon_clear_channels(struct exynos_drm_crtc *crtc)
 
 	/* Wait for vsync, as disable channel takes effect at next vsync */
 	if (ch_enabled)
-		decon_wait_for_vblank(ctx->crtc);
+		decon_wait_for_vblank(ctx);
 }
 
 static int decon_ctx_initialize(struct decon_context *ctx,
@@ -126,7 +123,7 @@ static int decon_ctx_initialize(struct decon_context *ctx,
 {
 	ctx->drm_dev = drm_dev;
 
-	decon_clear_channels(ctx->crtc);
+	decon_clear_channels(ctx);
 
 	return exynos_drm_register_dma(drm_dev, ctx->dev, &ctx->dma_priv);
 }
-- 
2.51.0


