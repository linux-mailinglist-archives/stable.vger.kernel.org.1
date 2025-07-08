Return-Path: <stable+bounces-161262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA803AFD435
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B43A5A0ECB
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C04A2E5B26;
	Tue,  8 Jul 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AG+2rgU9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF1A2E5411;
	Tue,  8 Jul 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994066; cv=none; b=R4ZPWC5YJPc+1GjV4QlhpAv0euClwIDjq1zeSiH3Fm6HcUgppN2KTFYkNmfyCVGuW1m1HxcrZnR5ilLM7Mw++/cOYFOATEotmCe9t+nrNI4JVKnyZvWBZMChrOmpPZ8oKeHja26aJGdmfyJ/3zlC1qpfjKbIq+cS+k9L+MtXpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994066; c=relaxed/simple;
	bh=BqjnKY+Fmz1V0hyNjEDrh6ktKvXn+PGGLkzVqAwMzPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDhkIT7v0sMB81MIiFyZt1Uj8MNIHuqddffgAqYjMxGgkCjsXjAfcIn+0V4M1Wx3/OT7eIHCA75FKAe5PVQAVIX5u+8kWgtyBTIGjs+/W+eANa3YjSbRwn2nnDqAGJlIvNEI7pa0urrbrCEzQA30Wqe7/xAJ2UVhC7YPYXvUgdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AG+2rgU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78777C4CEED;
	Tue,  8 Jul 2025 17:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751994065;
	bh=BqjnKY+Fmz1V0hyNjEDrh6ktKvXn+PGGLkzVqAwMzPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AG+2rgU98TnkGp4Dx9xAiavlSDrl9y14tcui8WxeGnY6yh8ChxtXhJCjgFaqotTuG
	 lQ8zXE9rOh/jacbQ6M3DJJvwBguLwLm/HDgQdk+If3o8qU+VhMepmT7N/tO1c7oxnI
	 ITev/PDpkmUoj/ulXzwXreybSdkezl/q630YmYhA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 114/160] drm/exynos: fimd: Guard display clock control with runtime PM calls
Date: Tue,  8 Jul 2025 18:22:31 +0200
Message-ID: <20250708162234.624677672@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162231.503362020@linuxfoundation.org>
References: <20250708162231.503362020@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 5d91394f236167ac624b823820faf4aa928b889e ]

Commit c9b1150a68d9 ("drm/atomic-helper: Re-order bridge chain pre-enable
and post-disable") changed the call sequence to the CRTC enable/disable
and bridge pre_enable/post_disable methods, so those bridge methods are
now called when CRTC is not yet enabled.

This causes a lockup observed on Samsung Peach-Pit/Pi Chromebooks. The
source of this lockup is a call to fimd_dp_clock_enable() function, when
FIMD device is not yet runtime resumed. It worked before the mentioned
commit only because the CRTC implemented by the FIMD driver was always
enabled what guaranteed the FIMD device to be runtime resumed.

This patch adds runtime PM guards to the fimd_dp_clock_enable() function
to enable its proper operation also when the CRTC implemented by FIMD is
not yet enabled.

Fixes: 196e059a8a6a ("drm/exynos: convert clock_enable crtc callback to pipeline clock")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index f25e112a92ed5..2a3152f97c843 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -182,6 +182,7 @@ struct fimd_context {
 	u32				i80ifcon;
 	bool				i80_if;
 	bool				suspended;
+	bool				dp_clk_enabled;
 	wait_queue_head_t		wait_vsync_queue;
 	atomic_t			wait_vsync_event;
 	atomic_t			win_updated;
@@ -1014,7 +1015,18 @@ static void fimd_dp_clock_enable(struct exynos_drm_clk *clk, bool enable)
 	struct fimd_context *ctx = container_of(clk, struct fimd_context,
 						dp_clk);
 	u32 val = enable ? DP_MIE_CLK_DP_ENABLE : DP_MIE_CLK_DISABLE;
+
+	if (enable == ctx->dp_clk_enabled)
+		return;
+
+	if (enable)
+		pm_runtime_resume_and_get(ctx->dev);
+
+	ctx->dp_clk_enabled = enable;
 	writel(val, ctx->regs + DP_MIE_CLKCON);
+
+	if (!enable)
+		pm_runtime_put(ctx->dev);
 }
 
 static const struct exynos_drm_crtc_ops fimd_crtc_ops = {
-- 
2.39.5




