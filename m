Return-Path: <stable+bounces-187791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1987BEC524
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73ED51AA4C53
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2098140E34;
	Sat, 18 Oct 2025 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyhcuzXY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9418626
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760754405; cv=none; b=pz4zWPdTRWgLvUqUEmzeYPcCrJ6P8RnH2h88vrdWNkvVVeyAjm0gOwd7jBxVQu7uM5ywAGf9pk4PaC7xikmA0+ZkT0ePU37z8up42fVNor0La7LWJjkSc2eaQbHrYb8WnLsCr1qdcU8j2Cf1wUYQS3WygzXzRu7odsrJBxNaY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760754405; c=relaxed/simple;
	bh=aDti7gcVCvz6XZo1XcPAdBrlN2mexGVA1lVzLMyEiWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DO1A5vxdB7X42UHPpL5F2RnjWtKNdg+Xqmpg/cWdpJiu8o160cbmyyNd9V25fno2Y2F04x3/4ovk9J/PCsmMxL7mfhEfnVF0sDhatP1EWCCEEh3+vaX0oOhX8QzfDGWNTb/zJ7yQ42I9r0aVU7Sm85D8Wl4QqIMJIoD/YsfwnXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyhcuzXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A4EC4CEE7;
	Sat, 18 Oct 2025 02:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760754405;
	bh=aDti7gcVCvz6XZo1XcPAdBrlN2mexGVA1lVzLMyEiWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyhcuzXYmRYAGTZm5WQcLFC7McCVhhu/On1B8X1U5KqVdMYRRV/a613IpdKwbHwKF
	 gKOprP8v1Fy4e3810VNhKaJD63DFR1gR1h+DN8snl4qYbPPXbvWSuDBpfbj7mfXJDr
	 TGulxnPlmjFbAfznIngR388D3uFQ75mBWKvevVAnIYlVshfvH5dxd3Xiw5bEBYVudm
	 oqyKREIqwMv73awJONmWvaUMSab5s0PvaDrP8d9V9hODymPJVzeR9X9HMe0emD53r5
	 vNiLlcR6bu0szwAyxRtShg5CrPGNrwwUK4w98VNPy3EYTRQW77sCkd8AMwx+D9vtCb
	 b59f+6BstAwWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] drm/exynos: exynos7_drm_decon: fix uninitialized crtc reference in functions
Date: Fri, 17 Oct 2025 22:26:40 -0400
Message-ID: <20251018022642.218123-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101640-sprig-fifth-f5a1@gregkh>
References: <2025101640-sprig-fifth-f5a1@gregkh>
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
index e52f72cc000e2..6d18a20e1104d 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -82,10 +82,8 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 	DRM_PLANE_TYPE_CURSOR,
 };
 
-static void decon_wait_for_vblank(struct exynos_drm_crtc *crtc)
+static void decon_wait_for_vblank(struct decon_context *ctx)
 {
-	struct decon_context *ctx = crtc->ctx;
-
 	if (ctx->suspended)
 		return;
 
@@ -101,9 +99,8 @@ static void decon_wait_for_vblank(struct exynos_drm_crtc *crtc)
 		DRM_DEV_DEBUG_KMS(ctx->dev, "vblank wait timed out.\n");
 }
 
-static void decon_clear_channels(struct exynos_drm_crtc *crtc)
+static void decon_clear_channels(struct decon_context *ctx)
 {
-	struct decon_context *ctx = crtc->ctx;
 	unsigned int win, ch_enabled = 0;
 
 	/* Check if any channel is enabled. */
@@ -119,7 +116,7 @@ static void decon_clear_channels(struct exynos_drm_crtc *crtc)
 
 	/* Wait for vsync, as disable channel takes effect at next vsync */
 	if (ch_enabled)
-		decon_wait_for_vblank(ctx->crtc);
+		decon_wait_for_vblank(ctx);
 }
 
 static int decon_ctx_initialize(struct decon_context *ctx,
@@ -127,7 +124,7 @@ static int decon_ctx_initialize(struct decon_context *ctx,
 {
 	ctx->drm_dev = drm_dev;
 
-	decon_clear_channels(ctx->crtc);
+	decon_clear_channels(ctx);
 
 	return exynos_drm_register_dma(drm_dev, ctx->dev, &ctx->dma_priv);
 }
-- 
2.51.0


