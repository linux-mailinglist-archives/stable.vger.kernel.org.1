Return-Path: <stable+bounces-176992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D068B3FDAC
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B658A2C3C81
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85002EF643;
	Tue,  2 Sep 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhTwHqHq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C2327E1AC;
	Tue,  2 Sep 2025 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812101; cv=none; b=QNtgaVRgziAdNkzI/OJrHCOf5MXrdBX3UZH3NLxjRSnVdySbUkuKPG1ZH6J88xDP0lwXt5ah6j/aTS2dW5gUYxvcAzC+kAdZ+xBxrCc1fSwsCtbKLd523jaoyQyL5+GXzwqieV8cuhsqtZsyxAThm6k4gjefcjlFR+Kogi7B9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812101; c=relaxed/simple;
	bh=LFTtV6r3Kv8hlUjLpPyuwQgn0EJVqqRO2UBgklloSc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ACm3b9yjkTm8eCb1gJQqO4xwcFgbI5/JHMHi3li1hySrvaRYSbJWlUXggBieNeE3pqfuZOv6onWKeSR0KnQmZg/VaUi/WJHO/PNYtDZ2nUzhX2J1nZMBGqRid/S2YaZ4rrOVrQsFEchuzYa1NdqJDibjquVcUzirWt5QJ8sWntA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhTwHqHq; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-772679eb358so1019972b3a.1;
        Tue, 02 Sep 2025 04:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756812099; x=1757416899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1peIzucQT9u+8mHdz0lvrHZdBPLJn2LftndnROMFbg=;
        b=OhTwHqHqCq/Zf0YHLwUhlMWd9L1H8K687gzyCJQPKvhTr3imZXjI67gS7JiBRMv6uf
         YmYfCoNdqy3t6XrElOuox7fErF86H0sMkqgnVK8+65yZWqNgnC/lfhorCJQPLMFNTv/F
         Pg7f4vMgKA8HZMweguVZOYRFbJbO5dIibx1AO0+AS8Bx+sr0MoyLZ28W+yz5ycZ45Luo
         fGUiNSaKoEnzmZydVC0Gfzu06sEz/GXRSAArUCwdTkrkRQk2MT955gxVCXuzVP+V4fjq
         oZ9x1hzMLzGraoI6b3Unsbwqb1954x8N7dKqfcfXzzik9O6yESFom1AyZ8BVgx4gLcT6
         6BgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756812099; x=1757416899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1peIzucQT9u+8mHdz0lvrHZdBPLJn2LftndnROMFbg=;
        b=Y6ArhUCZhtrnCWUUYeiSpcHbmsiVPBjZUU+tKTKTx89ADsYhQwVK0uwh8HisP00oc5
         TlOciRHvKVQQ2mJx4NXUJbmB3wJ7/A083FJlyz1YPmrH5l+BZtt06Ik/is8Fl/QLEj5C
         mepBqEWQD9Orq/v5E7XIe9nbDadK52+90P1DS6ISxT5iTvZ9p8DMB2Cz52zfjfjHvWPZ
         j7kgbGRK46/exxmnBk56ZJ5BizRuQN8oyMBGHEMFOVpyds3pkoY/6VG4wBFz7JhFhlAd
         KmFOES5qrDUuQYwg+MtnKrRWOgiorv9C24aOWWBQF5cH6ZBBUY52A1tQ6JsYCoEXvoZS
         JOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnNAoA92wY77+CUbH4m+Wpk6PRHLyEScMRKoAv4DIbtMFnh0LyVqDEkW5wsj/BUnR7Vw1CxmMtIbu3V5M=@vger.kernel.org, AJvYcCWR0MfZ4wNStArKHO1ve46EH7ugqPB4cJ4K4h6qnR3lerATAh5hGb0/kGktFLTSlTBXpsqlGuKi@vger.kernel.org, AJvYcCWcC/JKxnTUpVwGcb/wowqeH3ExTTbtve/LQMuqQW6Br5yoxxqpQ6TRNb+6Emt56PjGDpXfUoXGmZmx09lIP+qQdrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZmnTKgDtFJRN3Ynj+gXOPtC3A5XEaM+TYTh01nUXUkOQ4c0S
	I4NMhcjq95yP35rECCL9R/l4rikJHFJVXy2BMoz+qDybN61mOr22ezJk
X-Gm-Gg: ASbGncsqPOnWeO7Hv/xNfN44Ls2FY53MmlL1uXdx0aA8GB0mze8HHXYfyvnnegvUPGn
	qgLMGXE8Zqw438nTiB7cOT7p7hInaIMuilgWpupGdtA7EedziSfIGMtPlZRUboATAFe4WtHsWdQ
	3Rt6wRoD/7Tf5G0TeGECjxZw7Tx2nX5uKO+hANYUGYhEroRXqwNwQ18wMimsGApvOmTN1uG7Akw
	jxfU6Fm25fZOTlGk6Dha9/O/zLcIAUDrXNgJQj6EV1zvPCx3uBXvfpsHKSTXZ61BuCxfOh9Xp5m
	Q6RQQO/ZqsSP6x2SDwWVW9tkMyjQET5k4dpahen0C2xO3NvlMjtu1Y1P50r67yEUiAiUpNmlbAa
	FH/Q0ozmonTGE/Prc1+Hy/60Vwp4azw+RuNaSsv/yE0B/CP6uV0GrxGfj3kpI
X-Google-Smtp-Source: AGHT+IHYpnAEN97dhppR5gZj3bV2/ORfp7nw4JDDkTPmEAt+EIglpgn6hekUrxJELxqoV+MTc9dF5A==
X-Received: by 2002:a05:6a00:14d6:b0:76b:c9b9:a11b with SMTP id d2e1a72fcca58-7723e21e594mr12353303b3a.3.1756812099412;
        Tue, 02 Sep 2025 04:21:39 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e27d1sm13140645b3a.81.2025.09.02.04.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:21:39 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: krzk@kernel.org,
	alim.akhtar@samsung.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	aha310510@gmail.com
Subject: [PATCH 1/3] drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
Date: Tue,  2 Sep 2025 20:20:41 +0900
Message-Id: <20250902112043.3525123-2-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902112043.3525123-1-aha310510@gmail.com>
References: <20250902112043.3525123-1-aha310510@gmail.com>
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

