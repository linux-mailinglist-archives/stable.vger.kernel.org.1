Return-Path: <stable+bounces-207972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 150B4D0D977
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 18:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8C5D30185F6
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF0268C42;
	Sat, 10 Jan 2026 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Yr6K9PYn"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73835277C86;
	Sat, 10 Jan 2026 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768065321; cv=none; b=b0jB4Wom9WEVmT6mfgcOjFAB8rbyqgSahyrkBXUP+xuCJm6DflHp5UV/U6/w6gtsHlKcqxrOQv7/bYzZSjkAxu5ZxOI7PFxLcrFJk3Hi/ywT7FzoPApRGcy9xpdSqlwJ14CHPQZmPg81tK0ZGN1IAjUDJBw/bwfiqm/cS6HaNKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768065321; c=relaxed/simple;
	bh=O02xKoL83aPggV9KKs39NRhLhuG30e9T9mx6B7I92V0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKtODgESQSyx+2fzWssdANptcdxJlUvYEAZVAephrzqu3RMwv4AfxE9fU9/xGxwHGx2J7iokBaB5oNviDxzettDptWTvqyoahMnd+SNysMPV7XBZyoA4nOD5RNv74l80Jtj+4FcWACxcUkO6ZTXlqOMpuApCCXIHP9UZQjJ/mg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Yr6K9PYn; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22211103463;
	Sat, 10 Jan 2026 18:15:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768065316; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=/pWu63fv2X4piZLVw/R8K7A4ZYtCKrF3gKuywcnCCi8=;
	b=Yr6K9PYnDF/mEE6bWMrY80V6pFaQJ0SQ6YrofMdeF8PCmrBfH3rcEVqrpMaxH8Twd8M78U
	yTmPH9VnpCwe/xGB9ZKajxGf28ZF+IcozRLWchF7ZduT9zLA5XIziXUun30n20RZzdRNIQ
	dBIGMqy9PGhmlRz/vB143x+SXjAtUIPnLLiauFUIiQq9PSZHoXY233sqcpgjZuRrMIpyQq
	KoFAkr0SWlirPQ18xHIkjDQQVDKpgfSL+0F/74murXa2NeTExpBBvlJYlTtV2szq65wOa8
	9rTRVCVVpOi9ghCDweD1zfLkikmPBE7vrSuee5HKdeN8aETQIxU8Q0CjmFkCHw==
From: Marek Vasut <marex@nabladev.com>
To: dri-devel@lists.freedesktop.org
Cc: Marek Vasut <marex@nabladev.com>,
	stable@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/imx: parallel-display: Prefer bus format set via legacy "interface-pix-fmt" DT property
Date: Sat, 10 Jan 2026 18:14:10 +0100
Message-ID: <20260110171510.692666-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Prefer bus format set via legacy "interface-pix-fmt" DT property
over panel bus format. This is necessary to retain support for
DTs which configure the IPUv3 parallel output as 24bit DPI, but
connect 18bit DPI panels to it with hardware swizzling.

This used to work up to Linux 6.12, but stopped working in 6.13,
reinstate the behavior to support old DTs.

Cc: stable@vger.kernel.org
Fixes: 5f6e56d3319d ("drm/imx: parallel-display: switch to drm_panel_bridge")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: David Airlie <airlied@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/imx/ipuv3/parallel-display.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
index 6fbf505d2801d..02bb38a1ee4eb 100644
--- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
+++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
@@ -110,8 +110,7 @@ imx_pd_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 		output_fmt = imxpd->bus_format ? : MEDIA_BUS_FMT_RGB888_1X24;
 
 	/* Now make sure the requested output format is supported. */
-	if ((imxpd->bus_format && imxpd->bus_format != output_fmt) ||
-	    !imx_pd_format_supported(output_fmt)) {
+	if (!imx_pd_format_supported(output_fmt)) {
 		*num_input_fmts = 0;
 		return NULL;
 	}
@@ -121,7 +120,17 @@ imx_pd_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	if (!input_fmts)
 		return NULL;
 
-	input_fmts[0] = output_fmt;
+	/*
+	 * Prefer bus format set via legacy "interface-pix-fmt" DT property
+	 * over panel bus format. This is necessary to retain support for
+	 * DTs which configure the IPUv3 parallel output as 24bit, but
+	 * connect 18bit DPI panels to it with hardware swizzling.
+	 */
+	if (imxpd->bus_format && imxpd->bus_format != output_fmt)
+		input_fmts[0] = imxpd->bus_format;
+	else
+		input_fmts[0] = output_fmt;
+
 	return input_fmts;
 }
 
-- 
2.51.0


