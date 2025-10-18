Return-Path: <stable+bounces-187785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86776BEC50F
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 214E74EA6CA
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B28F19995E;
	Sat, 18 Oct 2025 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3JyyRN8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FBC146D45
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760753903; cv=none; b=mKW+NlpGNY7yPaxrQ9aTzqwQytLRjrOYlL4zVY3TZo/+Xw9bsrmF+4Kq2+SWl/02wzPV1jttaLAxmAVPIAon4lj4QFZVTFcXSmOPWpoVvo4pJu2o46EJdfB0b6vFvj3n9vdGQpvyTCTI46XSG7ZCh+/pRklv0u8XL1xldp6NiRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760753903; c=relaxed/simple;
	bh=KvEZmaoCQ0WyMljIS+GLqZHj6jNiivBGyVmlU4M2LqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHB9ZxgY4uwiBj442Cv/hm7vq6ut7CbastzG6BzRYvqw9Brq88dWzXTYks0KcBW/B5V6mB5j4tOW5kRic1tzji0/AwJ+FNOBO8pbvlscv3lGkxWFfJSW27nHu1MKrGt2wMqncI75lYs+oWnbQTWl0Db5yQ/NSGwFqJMu34SNX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3JyyRN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68420C4CEE7;
	Sat, 18 Oct 2025 02:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760753902;
	bh=KvEZmaoCQ0WyMljIS+GLqZHj6jNiivBGyVmlU4M2LqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3JyyRN8BD+lfYJujbsowNYhE/2kHc1093dj04SVRwhJBmBrXtzEkmljOntqZokA0
	 TZ8gPKpx0Lyt9vATEl5BmPw6jkZxxh0j9h+7S/e8jvycHn+MJr/KQFHQigCjDq8wOs
	 pxN8Y5oyS6fm1eSki3NdiNnBjOXd+1Cdlv4reC9v//T1GYDTuJkBouTEKGeKntuovw
	 CpsSIAO84unsREKw3uDi6wUKWeyt8TA/jApMt805aT0koy+2GY/cMn+4qL+/J0tl1o
	 WTwZpfKHayLAAjFH88W509Ssc3uRoEItFa7osJADwQTZC+Cq8TN01qNEPd7S5jwHeY
	 pZiLPmZbUzGoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] drm/exynos: exynos7_drm_decon: fix uninitialized crtc reference in functions
Date: Fri, 17 Oct 2025 22:18:17 -0400
Message-ID: <20251018021819.214653-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101639-sublet-lilac-775e@gregkh>
References: <2025101639-sublet-lilac-775e@gregkh>
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
index 5f8e5e87d7cd6..66f1a096c0f93 100644
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


