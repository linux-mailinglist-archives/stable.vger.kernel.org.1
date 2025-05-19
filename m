Return-Path: <stable+bounces-144885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D0EABC49C
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 18:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543B4164D3A
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183FF286D77;
	Mon, 19 May 2025 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxS49O97"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B63F1A2643
	for <stable@vger.kernel.org>; Mon, 19 May 2025 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672376; cv=none; b=qm9rRuCY/wE9BQhwzr+ps3JfQ9BjziLWP1XS70PHJXJ/ujvYKWh8dSCCIix0abEe/g7qx9xsEjbbTgPbq6EQ/rPKlEQ5UnrG106FmGfYOLR9068cPeUzupyMvgzo2Jf7AwZ0KshWajbeedwpX28Y7uT0tQ4wDZiB7ZoGmCvpfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672376; c=relaxed/simple;
	bh=RNWDkvo+zaqTe8fRkiJuTUFBH6wo/aexH4Hagt+4nqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FHCfjdsBq9E5vftSLk6A8FFNwcEObfd8bWiaeEeTT2xTSgzOG8AVoX1ZNRO0SJFXFeyj4siMIVtRY+67JwImNZ9Ni8WS/YlUwy8prIjNgDLYkG/3Wje1yO+3hoMwg/uIsKzEWzxUDTP4xnLjvp4+h1AqTw0rx+P+6SNt5vJ50hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxS49O97; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f8b2682d61so34725256d6.0
        for <stable@vger.kernel.org>; Mon, 19 May 2025 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747672374; x=1748277174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MSd4qkbLi+wdHInGBGw29k5cL8JGxZ9eO/Xu1FfL9Y=;
        b=KxS49O97+HHR0z4B2P9pLsxkXAZQT2DjkPzTEFeGKcRCE0N8q2cWqCIq/Pp94u685O
         uVt6Z7sIaLSyuYnEI7VAPEUke1/BcLyFIL5zCinEOmkmIbsZq4V0EKExZOk6hV4G3m2x
         a9CsgyzP5ARlYU8bbL94aYFIyV8h1jjoIjH4Nxy0Sc4GzH7+acejJ9+L+vbhLn7Dyh5c
         dbt5nvSHYWGaVGF5Qmih32WnoUAF59KZ36ZtGlkGuxKCG7nuBIej7cEndUcKZGMDM/le
         M8cp7Xw3wLQrPLntRCs3PHc51ukHkkyESf9n8mZDdZKdw5BwvuUroChDMKLZ3G+JK5/I
         b8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747672374; x=1748277174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MSd4qkbLi+wdHInGBGw29k5cL8JGxZ9eO/Xu1FfL9Y=;
        b=GCmLSKBRYI0x8bxK2iLgKKGwf3v4uv/f15uqQr3QAQ69m2VUpWWI9Rb10hNvel/HDa
         25xQW3Y42MlJ46W/cwyvjEDswHCfG9pxjYAi4Jge72PRmAVO4zS5Vo65UgFztMHj0H3F
         HZsTf4jkFv9Njndv2W4lJMuk7NzfTDzo8wh6CuFrvu4cZSeGehjX2w7b5kJT2GudzawW
         Io5jTShcCY9BHpzntp7faJcpExw52ZXvL+p6oJRTV+hGvgEJDY0ntxW6OnPFZYbp+sLy
         zor/C0qIa1QZ5Ca6owtsX7nd3ljsoEDCr78fEFx9bhzJosuYRN0KEpQNcJfdmxhtD4zT
         ex1Q==
X-Gm-Message-State: AOJu0YxQOuDgUFzK1vqnPlJOLqTiQbRiwdVTpns35JzLvCrwpMS0sEpo
	csH4REHjgVdMEfb9PYrR8O4/z9ZxrgEyFwLy6Z64+a3rA3tfPP4G9mJQFB4Srw==
X-Gm-Gg: ASbGncugFumtOhlOOQWw29tcXdv39iNCSio+ILUA9CBSw9YC8Vn6wiOiJ2ElwqUUFiK
	TtKbT4aSDJ/jkoqc1IoGb6/dwkcK7YxkSWaUZNe8k8aMyAhhJ7Pz+QrgSN8sFS0PO6DSd+aNWWy
	qr3hWTaatCSBhFv1s2PKY266/RMll8/Pn6q8CZSNERcGzQpmqCiu2G6oZJRr/2nboQgE9LWYp9N
	nF9kuagSWOSgWKlscPBM/QxNj/hqdF9KCIN13/jlu+8ujjU6wEO/JhvWSwPMWUpPPhxM7RLGR67
	uiYdnk72vtqgDMIGHOtrwrfv/ZjoxFDLzKjd5MDfqlj//2hGO2i//FoPJK6N9FJ+IQ6tpBySWMM
	j
X-Google-Smtp-Source: AGHT+IFkdE3GOVCCuxewqkcxPzr4MlpS8xUpR726jrjl+NBpHsI/d5i+j+qFwcE3Z/95SixhseVpKQ==
X-Received: by 2002:a05:6122:1e08:b0:51f:a02b:45d4 with SMTP id 71dfb90a1353d-52dbb4307aemr12133108e0c.1.1747672362350;
        Mon, 19 May 2025 09:32:42 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:276e:c8c9:6d13:9b45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dbab4e953sm6906606e0c.38.2025.05.19.09.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:32:41 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: stable@vger.kernel.org
Cc: tzimmermann@suse.de,
	javierm@redhat.com,
	gregkh@linuxfoundation.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 6.12.y 3/3] drm/tiny: panel-mipi-dbi: Use drm_client_setup_with_fourcc()
Date: Mon, 19 May 2025 13:32:30 -0300
Message-Id: <20250519163230.1303438-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519163230.1303438-1-festevam@gmail.com>
References: <20250519163230.1303438-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

commit 9c1798259b9420f38f1fa1b83e3d864c3eb1a83e upstream.

Since commit 559358282e5b ("drm/fb-helper: Don't use the preferred depth
for the BPP default"), RGB565 displays such as the CFAF240320X no longer
render correctly: colors are distorted and the content is shown twice
horizontally.

This regression is due to the fbdev emulation layer defaulting to 32 bits
per pixel, whereas the display expects 16 bpp (RGB565). As a result, the
framebuffer data is incorrectly interpreted by the panel.

Fix the issue by calling drm_client_setup_with_fourcc() with a format
explicitly selected based on the display's bits-per-pixel value. For 16
bpp, use DRM_FORMAT_RGB565; for other values, fall back to the previous
behavior. This ensures that the allocated framebuffer format matches the
hardware expectations, avoiding color and layout corruption.

Tested on a CFAF240320X display with an RGB565 configuration, confirming
correct colors and layout after applying this patch.

Cc: stable@vger.kernel.org
Fixes: 559358282e5b ("drm/fb-helper: Don't use the preferred depth for the BPP default")
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/r/20250417103458.2496790-1-festevam@gmail.com
---
 drivers/gpu/drm/tiny/panel-mipi-dbi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index e66729b31bd6..ac159e8127d5 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -390,7 +390,10 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, drm);
 
-	drm_client_setup(drm, NULL);
+	if (bpp == 16)
+		drm_client_setup_with_fourcc(drm, DRM_FORMAT_RGB565);
+	else
+		drm_client_setup_with_fourcc(drm, DRM_FORMAT_RGB888);
 
 	return 0;
 }
-- 
2.34.1


