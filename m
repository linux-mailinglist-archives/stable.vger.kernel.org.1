Return-Path: <stable+bounces-187786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA4ABEC512
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D2F4354858
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2ED19F464;
	Sat, 18 Oct 2025 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReV+KNBH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A028170A11
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760753903; cv=none; b=D6fwHoo7JM2vNtnihtFPbFto2SE3oMNIoVHJ0YDsSc+UGKWzv5zYIcq3457yTVdCcenxM54T9s2JW7j4WhtpYgHYHxE/s/exVaUahxsZ9AAZJynigj2x5XuP2pMbS9/XuATKaTHSNwHEQ0e9D/OuvgZk9DePxTCPTe6nB/UxULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760753903; c=relaxed/simple;
	bh=P98X41Y1p8l0myRiArfVQkd33HSnHaCCdUpAC6JAyfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHn3hmPPfzo05dIHdrAFiw7jdU/A7HMeQBYi1B939EXQVV0XN6UoIOW7QDp78xwUQ2xMzY2nZY8q2fqpbJpaixlXdid+Di0kTgB2efgngrB/Y2ICOFW/2ZnDVOQioZmXZqUNfzthUnFZHf66jxH6qA4bjC0PqYbfkJGc8EYEkzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReV+KNBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6CBC4CEFE;
	Sat, 18 Oct 2025 02:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760753902;
	bh=P98X41Y1p8l0myRiArfVQkd33HSnHaCCdUpAC6JAyfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ReV+KNBHBJIyJcuMRnpEpnUbKpHbTPZgJgV5lIVuBpPGIsFODYQ0SfQDQGIAY+ei7
	 PqgZn0Q8ocaY2cJBvbp5hjYWQhrfPfj9fd9MVE34PNGWff4km4F4MOvIjQ4d3Zll6k
	 OzjzjcZqFaOjNSICYFe3gTQckEj0z4lJTocsrKIhEa+OkOUTRfO0Sgx4YVKnyWuq6Q
	 dd9lmGShGZSaRkM2LLeF98620BM/p4WlX0EGBolbG/C4guvKzmGywh+6V32yCQKWMd
	 ETcQoXLKiARfuwIXWeOqbQFQQ1y76VqfhhtKqopV/bFuRQnzBDbk0MSWWdavIA89Wf
	 He8IKwImYgt0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] drm/exynos: exynos7_drm_decon: properly clear channels during bind
Date: Fri, 17 Oct 2025 22:18:18 -0400
Message-ID: <20251018021819.214653-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018021819.214653-1-sashal@kernel.org>
References: <2025101639-sublet-lilac-775e@gregkh>
 <20251018021819.214653-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaustabh Chakraborty <kauschluss@disroot.org>

[ Upstream commit 5f1a453974204175f20b3788824a0fe23cc36f79 ]

The DECON channels are not cleared properly as the windows aren't
shadow protected. When accompanied with an IOMMU, it pagefaults, and
the kernel panics.

Implement shadow protect/unprotect, along with a standalone update,
for channel clearing to properly take effect.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Stable-dep-of: e1361a4f1be9 ("drm/exynos: exynos7_drm_decon: remove ctx->suspended")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos7_drm_decon.c | 55 +++++++++++++---------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 66f1a096c0f93..4ea0106651a4f 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -81,6 +81,28 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 	DRM_PLANE_TYPE_CURSOR,
 };
 
+/**
+ * decon_shadow_protect_win() - disable updating values from shadow registers at vsync
+ *
+ * @ctx: display and enhancement controller context
+ * @win: window to protect registers for
+ * @protect: 1 to protect (disable updates)
+ */
+static void decon_shadow_protect_win(struct decon_context *ctx,
+				     unsigned int win, bool protect)
+{
+	u32 bits, val;
+
+	bits = SHADOWCON_WINx_PROTECT(win);
+
+	val = readl(ctx->regs + SHADOWCON);
+	if (protect)
+		val |= bits;
+	else
+		val &= ~bits;
+	writel(val, ctx->regs + SHADOWCON);
+}
+
 static void decon_wait_for_vblank(struct decon_context *ctx)
 {
 	if (ctx->suspended)
@@ -101,18 +123,27 @@ static void decon_wait_for_vblank(struct decon_context *ctx)
 static void decon_clear_channels(struct decon_context *ctx)
 {
 	unsigned int win, ch_enabled = 0;
+	u32 val;
 
 	/* Check if any channel is enabled. */
 	for (win = 0; win < WINDOWS_NR; win++) {
-		u32 val = readl(ctx->regs + WINCON(win));
+		val = readl(ctx->regs + WINCON(win));
 
 		if (val & WINCONx_ENWIN) {
+			decon_shadow_protect_win(ctx, win, true);
+
 			val &= ~WINCONx_ENWIN;
 			writel(val, ctx->regs + WINCON(win));
 			ch_enabled = 1;
+
+			decon_shadow_protect_win(ctx, win, false);
 		}
 	}
 
+	val = readl(ctx->regs + DECON_UPDATE);
+	val |= DECON_UPDATE_STANDALONE_F;
+	writel(val, ctx->regs + DECON_UPDATE);
+
 	/* Wait for vsync, as disable channel takes effect at next vsync */
 	if (ch_enabled)
 		decon_wait_for_vblank(ctx);
@@ -340,28 +371,6 @@ static void decon_win_set_colkey(struct decon_context *ctx, unsigned int win)
 	writel(keycon1, ctx->regs + WKEYCON1_BASE(win));
 }
 
-/**
- * decon_shadow_protect_win() - disable updating values from shadow registers at vsync
- *
- * @ctx: display and enhancement controller context
- * @win: window to protect registers for
- * @protect: 1 to protect (disable updates)
- */
-static void decon_shadow_protect_win(struct decon_context *ctx,
-				     unsigned int win, bool protect)
-{
-	u32 bits, val;
-
-	bits = SHADOWCON_WINx_PROTECT(win);
-
-	val = readl(ctx->regs + SHADOWCON);
-	if (protect)
-		val |= bits;
-	else
-		val &= ~bits;
-	writel(val, ctx->regs + SHADOWCON);
-}
-
 static void decon_atomic_begin(struct exynos_drm_crtc *crtc)
 {
 	struct decon_context *ctx = crtc->ctx;
-- 
2.51.0


