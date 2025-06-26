Return-Path: <stable+bounces-158715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBACDAEA65E
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 21:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC227AF84A
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 19:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906BD2EFD9A;
	Thu, 26 Jun 2025 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Pn62ZQw+"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F82264D3;
	Thu, 26 Jun 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750965681; cv=none; b=sCqa9k+x4lfFGqtAEr2A3CT3/2UTJeglcDyLX6K4G9LWAtM2nPkHwGFtslEZx7dXM40RRZ0yKiApYPDN/k9IeNjD9Rv4cqr4fNE6zx/2LQadj2y91HFXt1Ez6ecMlwv4PGyp9uL77NW5v8KDJt9/XccNJyT3kcX8Ryekqze+1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750965681; c=relaxed/simple;
	bh=D8o5aKxiqPDfJaP/Wlra9wiusUGgyAqkKg4+LuSvXis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SBK+llowCJ7++b0V18hHNeQEwD+D+JGwzS91/eAKPb+rjPnI5kDhOgUbLcNM3KwASECE4RTb/k8oRjoGalJjo3lFXvRu52GPRDDqycy9jHv1CHiBxQmfZViBQ69D65vxf9mnxdxOkAsX56x6TzRaWg99GMcKK1J285+rvbDaf4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Pn62ZQw+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3CA0825D64;
	Thu, 26 Jun 2025 21:21:18 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IstntXv3cZpE; Thu, 26 Jun 2025 21:21:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1750965677; bh=D8o5aKxiqPDfJaP/Wlra9wiusUGgyAqkKg4+LuSvXis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Pn62ZQw+QE0tjCn0VDNyryMq5NiYYLWChHURVJLwXWY2Rtsz8kcRaMh+VeqrNGfPK
	 QuawYtCEC5pwvYquUJF0BTaMYUdEP8mymD61+I3J8Xi2vCBuYj5GsovKtkj0QKWpcJ
	 SWkHfNKqjS2N/+UHOsL9ZJKWbbnkBf5hR0OTTNwaIr4OY7IxzOxJETsWYDP7jQ8uFV
	 5DEerlKJvRnt3vZ9+CT63xLNQXw5Jd/E3Tn9H3C4usiVQ7WnH/WkraBe41J2S/gY9A
	 aPvN8jGDGw3u9oyx+EU+4ao2KrmF/gUBkSa5srdyrzqIdNeg7YFct6bsKZaG8tBtQ/
	 dhC4GJ1vo/jxw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 27 Jun 2025 00:50:30 +0530
Subject: [PATCH v3 3/3] drm/exynos: exynos7_drm_decon: add vblank check in
 IRQ handling
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-exynosdrm-decon-v3-3-5b456f88cfea@disroot.org>
References: <20250627-exynosdrm-decon-v3-0-5b456f88cfea@disroot.org>
In-Reply-To: <20250627-exynosdrm-decon-v3-0-5b456f88cfea@disroot.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Ajay Kumar <ajaykumar.rs@samsung.com>, Akshu Agrawal <akshua@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750965633; l=1467;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=D8o5aKxiqPDfJaP/Wlra9wiusUGgyAqkKg4+LuSvXis=;
 b=Zaidk2/MU65T4C2DakEpl1E0vJyg4XwWxX2szoui0qZZcrrbhIkFhB55oDTaWDS1w+QzFykVB
 dtvzv6gyjheBTohjdUEszCp2rVBomHkZYW6z6n3GgQhxqz5uqjV/bmL
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

If there's support for another console device (such as a TTY serial),
the kernel occasionally panics during boot. The panic message and a
relevant snippet of the call stack is as follows:

  Unable to handle kernel NULL pointer dereference at virtual address 000000000000000
  Call trace:
    drm_crtc_handle_vblank+0x10/0x30 (P)
    decon_irq_handler+0x88/0xb4
    [...]

Otherwise, the panics don't happen. This indicates that it's some sort
of race condition.

Add a check to validate if the drm device can handle vblanks before
calling drm_crtc_handle_vblank() to avoid this.

Cc: stable@vger.kernel.org
Fixes: 96976c3d9aff ("drm/exynos: Add DECON driver")
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/gpu/drm/exynos/exynos7_drm_decon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 43bcbe2e2917df43d7c2d27a9771e892628dd682..c0c0f23169c993ac315fc8d7bcbd09ea6ec9966a 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -636,6 +636,10 @@ static irqreturn_t decon_irq_handler(int irq, void *dev_id)
 	if (!ctx->drm_dev)
 		goto out;
 
+	/* check if crtc and vblank have been initialized properly */
+	if (!drm_dev_has_vblank(ctx->drm_dev))
+		goto out;
+
 	if (!ctx->i80_if) {
 		drm_crtc_handle_vblank(&ctx->crtc->base);
 

-- 
2.49.0


