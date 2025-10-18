Return-Path: <stable+bounces-187795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52566BEC57B
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F721AA7EB9
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61038236451;
	Sat, 18 Oct 2025 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oen4wbPg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1C4235C01
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760754900; cv=none; b=knIul8PgK9916K2XgFr1tSGpO6bFGgTSeDJv6+7fZazVJqr1laVrcR+gQUrl9pr78XLzNjOLztgOrKI6sfwrwPu6mTBXYB3tcXk4NoJ3JXOf02s+bmfHS82cUy9mvGpc4XP9NPLXxcNGiLXW+HuMpa0UL+WIPCuGIzm7inmliVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760754900; c=relaxed/simple;
	bh=gLMjXnSh46nzHRKrJyDttRRxP97Yl0ViVw7RYPtMqsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6gffcfPJjIG2pdoxpG8IoFBF2AsnXtHT4JgRcWefWkdCHQJ8usMdJk3RYvtIZp1VXwh1oaPQn8bYmfwh0ZplmzmwWDwR8O4296KzOBhc1dlU4EPlVDJmFahx/4yGVY5ktOfBLVWU9gctSMLlNnNOjWePoCBAEkuWth5JnZ8jfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oen4wbPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304DEC4CEE7;
	Sat, 18 Oct 2025 02:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760754899;
	bh=gLMjXnSh46nzHRKrJyDttRRxP97Yl0ViVw7RYPtMqsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oen4wbPgrK/VgObjxdHTFbSur+O2IEIBMkU+1I+7fglBV7/Y8+6nEbjPKtvI/zYV7
	 3d4yXCQF6fQa9fNKjNZ/gzFc3uOjbufOBZT00CPFKrz1o5csvabZNVN70ZLuN6ShT4
	 liQegqNO9XP/5eJqRv2lUgggcGeTocjX+qU5/ddqca+SGB+6+F0TRrK6Q6Ug+XeqCL
	 G9VhmneJNq8FiktGsJvSP4mKtVnqyOlsVYXBN4osCxI8/AGG4fRZu/Nx9iMpnZu2KZ
	 vpQ5V+2hidHC35HpGVihRQrHF/e5sU0DB69Hu0QHubo0dB06ugwl0EXQ1EccyVzsFc
	 R0wvTGJRS8dpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] drm/exynos: exynos7_drm_decon: fix uninitialized crtc reference in functions
Date: Fri, 17 Oct 2025 22:34:55 -0400
Message-ID: <20251018023457.221641-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101640-enviable-movable-b2dd@gregkh>
References: <2025101640-enviable-movable-b2dd@gregkh>
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
index d255c03aed225..abd08991a6d18 100644
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


