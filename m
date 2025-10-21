Return-Path: <stable+bounces-188436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95000BF854A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46BB64F45A6
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11550273D9F;
	Tue, 21 Oct 2025 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2PuAnJi/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132F261B8D;
	Tue, 21 Oct 2025 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076399; cv=none; b=cuCqh1RdwfDiPcMf6VEmFhBQ04U9f9xyRlK+ATCiZNw9+x1UQLpy9yPZvtZPW1xcdfUZzA9jRD908ZEFfjPglnQ7RHOeScUp2BLEbbCACQQFqUPorzbKCmaLPnfw3rd6p32v4ABjww4D63qH8SdbY+UuKLntj+XNSRA/gBSn868=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076399; c=relaxed/simple;
	bh=o4Fj/rla15vRmDsMkL8Cw42R3WBhNva7IlnzpLiZUfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piONLOn1ztofHBnymGmgdjeoYKW8aP66fXF8oemYOWaC1uIUB2nnFeKJBAwLHhgRC53eJJ9RLnQH40w+6OvwXsytlO5vCZZAPG9dWcAyWoLU3uujOc4l3kYgvgTRIUNb4uhwD02uR/37jbfmDyfSvRTOUvTElyQiEjjrMcD6CyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2PuAnJi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E029C4CEF1;
	Tue, 21 Oct 2025 19:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761076399;
	bh=o4Fj/rla15vRmDsMkL8Cw42R3WBhNva7IlnzpLiZUfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2PuAnJi/uc+VYavLIgXpPevwACFGiiTO7C+IRvdp8RZgJAIGv1rGyQnOlQ/brAVDJ
	 nSSoZzUbctEYLgyqzu9DzU5zXn6/vaZbqNM/3kCKHV1oBIxLeOkEvv3+63i9Ih7xHu
	 LtUDtDeZ2u5lvKrzwYog3KIdDWyNNXDLomvqfW5Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 023/105] drm/exynos: exynos7_drm_decon: fix uninitialized crtc reference in functions
Date: Tue, 21 Oct 2025 21:50:32 +0200
Message-ID: <20251021195022.045550673@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
References: <20251021195021.492915002@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kaustabh Chakraborty <kauschluss@disroot.org>

[ Upstream commit d31bbacf783daf1e71fbe5c68df93550c446bf44 ]

Modify the functions to accept a pointer to struct decon_context
instead.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Stable-dep-of: e1361a4f1be9 ("drm/exynos: exynos7_drm_decon: remove ctx->suspended")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/exynos/exynos7_drm_decon.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -81,10 +81,8 @@ static const enum drm_plane_type decon_w
 	DRM_PLANE_TYPE_CURSOR,
 };
 
-static void decon_wait_for_vblank(struct exynos_drm_crtc *crtc)
+static void decon_wait_for_vblank(struct decon_context *ctx)
 {
-	struct decon_context *ctx = crtc->ctx;
-
 	if (ctx->suspended)
 		return;
 
@@ -100,9 +98,8 @@ static void decon_wait_for_vblank(struct
 		DRM_DEV_DEBUG_KMS(ctx->dev, "vblank wait timed out.\n");
 }
 
-static void decon_clear_channels(struct exynos_drm_crtc *crtc)
+static void decon_clear_channels(struct decon_context *ctx)
 {
-	struct decon_context *ctx = crtc->ctx;
 	unsigned int win, ch_enabled = 0;
 
 	/* Check if any channel is enabled. */
@@ -118,7 +115,7 @@ static void decon_clear_channels(struct
 
 	/* Wait for vsync, as disable channel takes effect at next vsync */
 	if (ch_enabled)
-		decon_wait_for_vblank(ctx->crtc);
+		decon_wait_for_vblank(ctx);
 }
 
 static int decon_ctx_initialize(struct decon_context *ctx,
@@ -126,7 +123,7 @@ static int decon_ctx_initialize(struct d
 {
 	ctx->drm_dev = drm_dev;
 
-	decon_clear_channels(ctx->crtc);
+	decon_clear_channels(ctx);
 
 	return exynos_drm_register_dma(drm_dev, ctx->dev, &ctx->dma_priv);
 }



