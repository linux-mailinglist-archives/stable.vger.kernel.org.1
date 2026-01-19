Return-Path: <stable+bounces-210281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE030D3A1A2
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B719305380A
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 08:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE7F33D50A;
	Mon, 19 Jan 2026 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbNAL+h+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985933CEB7
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811167; cv=none; b=NXw1KkFOMA1yy41GZw4p9ks3gl/jzvwclsxcHiu5R3T4DfAhamzzwi8KPqrnYnCMnou4ViJNpsYafKEEwy1IRo9uTEkiOW99Vv+Vao4bf2U58JrEut+pYcilLx0XzEpfJtsovZDqK50Z8mP2ApPNcVK0vZGmiJ0it+LkJZl1ZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811167; c=relaxed/simple;
	bh=LFTtV6r3Kv8hlUjLpPyuwQgn0EJVqqRO2UBgklloSc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AW79JaZHlh2UhxjzaKYOZQJzIFw0SM+b7pTSHxFfW+nCUfpe43wnJ8Tt0J6oqWTqTncY+fERtkKgOUiJubKmc4gG+LoVs9oW3t1K6URcTsMl4ubhetzUb+B4K7PKfFhL/oY5c8tcUMPCgxkoz4wGLpv5Sid6cdDmi89i7DydCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbNAL+h+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a743050256so3227205ad.3
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 00:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768811165; x=1769415965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1peIzucQT9u+8mHdz0lvrHZdBPLJn2LftndnROMFbg=;
        b=UbNAL+h+UFXueXYCGrZIrrzmJZ8fz6iPkt23ighCLd19xqfGWOKIQb3JmNMAB3MjI1
         Ckd417D1WStI4SCrES0/ytGatRoI2OwlnehixGKAMHah11rFDtBtmpVxJ+8b6W0aYvTZ
         Dj2aEi6oDw+mGR838m8X7eyKOzvtks0pln3VH2tjLehZQhLpCpeyVIby48WTM8TbZYwE
         ZO+KHnCCgeCFpDz1QmXPrwETdGX1wW9+4BhF+SaZ/R/01oA/WDn587YKImnBhY1SAGk9
         mO4NLPxLU/+NI5Y3DZx98Ave7zaKGJZRRU8/bPnmzq/xOroQCTb3KP/AeVjQbtv2ITAn
         zpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768811165; x=1769415965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C1peIzucQT9u+8mHdz0lvrHZdBPLJn2LftndnROMFbg=;
        b=KB1KBH8GZIxn4FhH1f44s30j5fhEFC5DoBm6/oHZZOXuCtzd1X4ctqN9heoWGdyiEf
         CMSRdOvzW+YqANR3tDaqro1jvXqk3Ui2QLkoqiK3J85x3uiP2bDIBBRuY7wdv5AWgOlG
         IAP11sURz/g0HFBWkNH0IelpH2SafHdQpJ5nQ4YbVHXShsUvdiyzOs/h1USl+g+cgPVE
         UlRdTDhQaFtbPaR1MAUpznHpUaW5MRaK4vLwFeWIM3JR4EpsmAo/u+MSbEP/366hrLxu
         w+GjZZap4s7JYs5dgSzOgm0FazyInwu7RFamphpFm6E7zJy1+UH/LsQzLdS3MTV2GLwM
         d8zA==
X-Forwarded-Encrypted: i=1; AJvYcCWR28tFcGBr2t+ccpIe+ZMqTOa/5atatpt3YfS3P5CMOkcVpnIpEa+tTVffNmI0t/PSJX214g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIO/lM5TlLzL08uTbgr00drAB4pKH8/vAZnCfyF7GMU4GMZG0z
	T0QTEQDLNG4EMJac2YS90F8BHvPj7T2qktX+kYsyV2geKEo1git6o8dMW5ZbPg==
X-Gm-Gg: AZuq6aKF5+Q2QZcFjGADfnR5ERdXMS9Q5ZOFPDgJ3dYYaTDzZehXIZZYeak6LwG/z1W
	iSTx/1n2VxKnYjxjE7F9+QEP8+5a7WqEneF1EQuhvYhBD9vL9zfuyzy9Q2ag0zaaAw+99sTiRbv
	vKdo+VICBY7SnjKN9tDvKR7JjJCagLmFmvz78UoUqXKMcyRKNaZy0f4090qvQYLM+pjbzE//zUs
	rLc5BlhY5PzrmbmuKn+p0iBNLdc97BAInocLIDAqk5koEDS9RYTqQvqOz0OvGM/Hk7lJuAtai6V
	w8IcCXF2TzWxas5pmDJWM58YdI3z6fgt2RIB4F8rAgKMLk9J8ELeMxaR2p737Wl+kXaDY3G1RJ7
	nUWQ5P1C/0AMtY1AqJF1+FdFEBDPLoJCyJFNpW/tmwSkwNfyRUcP7YZLrP+ay2wnDHPWu8VSpgl
	nXwqbPOBci6FtSeliiKNrcBfoqHBgWbZmxWO0ikQ==
X-Received: by 2002:a17:903:1ae4:b0:2a0:f828:24a3 with SMTP id d9443c01a7336-2a7175cc0f1mr100262275ad.28.1768811165155;
        Mon, 19 Jan 2026 00:26:05 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce534sm85699645ad.27.2026.01.19.00.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 00:26:04 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 1/3 RESEND] drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
Date: Mon, 19 Jan 2026 17:25:51 +0900
Message-Id: <20260119082553.195181-2-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119082553.195181-1-aha310510@gmail.com>
References: <20260119082553.195181-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vidi_connection_ioctl() retrieves the driver_data from drm_dev->dev to
obtain a struct vidi_context pointer. However, drm_dev->dev is the
exynos-drm master device, and the driver_data contained therein is not
the vidi component device, but a completely different device.

This can lead to various bugs, ranging from null pointer dereferences and
garbage value accesses to, in unlucky cases, out-of-bounds errors,
use-after-free errors, and more.

To resolve this issue, we need to store/delete the vidi device pointer in
exynos_drm_private->vidi_dev during bind/unbind, and then read this
exynos_drm_private->vidi_dev within ioctl() to obtain the correct
struct vidi_context pointer.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_drv.h  |  1 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index 23646e55f142..06c29ff2aac0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -199,6 +199,7 @@ struct drm_exynos_file_private {
 struct exynos_drm_private {
 	struct device *g2d_dev;
 	struct device *dma_dev;
+	struct device *vidi_dev;
 	void *mapping;
 
 	/* for atomic commit */
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index e094b8bbc0f1..1fe297d512e7 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -223,9 +223,14 @@ ATTRIBUTE_GROUPS(vidi);
 int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 				struct drm_file *file_priv)
 {
-	struct vidi_context *ctx = dev_get_drvdata(drm_dev->dev);
+	struct exynos_drm_private *priv = drm_dev->dev_private;
+	struct device *dev = priv ? priv->vidi_dev : NULL;
+	struct vidi_context *ctx = dev ? dev_get_drvdata(dev) : NULL;
 	struct drm_exynos_vidi_connection *vidi = data;
 
+	if (!ctx)
+		return -ENODEV;
+
 	if (!vidi) {
 		DRM_DEV_DEBUG_KMS(ctx->dev,
 				  "user data for vidi is null.\n");
@@ -371,6 +376,7 @@ static int vidi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct vidi_context *ctx = dev_get_drvdata(dev);
 	struct drm_device *drm_dev = data;
+	struct exynos_drm_private *priv = drm_dev->dev_private;
 	struct drm_encoder *encoder = &ctx->encoder;
 	struct exynos_drm_plane *exynos_plane;
 	struct exynos_drm_plane_config plane_config = { 0 };
@@ -378,6 +384,8 @@ static int vidi_bind(struct device *dev, struct device *master, void *data)
 	int ret;
 
 	ctx->drm_dev = drm_dev;
+	if (priv)
+		priv->vidi_dev = dev;
 
 	plane_config.pixel_formats = formats;
 	plane_config.num_pixel_formats = ARRAY_SIZE(formats);
@@ -423,8 +431,12 @@ static int vidi_bind(struct device *dev, struct device *master, void *data)
 static void vidi_unbind(struct device *dev, struct device *master, void *data)
 {
 	struct vidi_context *ctx = dev_get_drvdata(dev);
+	struct drm_device *drm_dev = data;
+	struct exynos_drm_private *priv = drm_dev->dev_private;
 
 	timer_delete_sync(&ctx->timer);
+	if (priv)
+		priv->vidi_dev = NULL;
 }
 
 static const struct component_ops vidi_component_ops = {
--

