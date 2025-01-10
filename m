Return-Path: <stable+bounces-108171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6465A08958
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 08:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65A4169739
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 07:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35A9207DFB;
	Fri, 10 Jan 2025 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gk/AO+Ss"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1736B158DC4;
	Fri, 10 Jan 2025 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736495112; cv=none; b=ontXrEI4/FiSjuuvwjH8IOEyYNGN+QcYIBNaPdbkgEvLq6zR3oVf2yrLD7QBIpwOPQR4DICd4cnw0HvA6UfEGtAfhV7ZF0vIVuwvphc6U3dxgqgtsgtRISE+LzCCPxTgT4JHbidhtIuZsLZeonvj/Z6tVxYJNCGzttGKYLXQ+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736495112; c=relaxed/simple;
	bh=SsP5At8DOf+gfsirjwp5BlLwu4+7+9lix3OdB0Ds/Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u0bYUtYSyfQI1bTOX+Xkx6oaL39eKk+KuKfsTVVv+OluFswnwHwFNyrPqvONHt2LXAUp+JFO39JLzyIyP9vxwrZBBD0K2M8DvH5Ft1HbFNHa9tuXWCXQ/Txd4+GsDAV2Rh9VAOyePsmMDK7YWQZ+8j5GFY2vpvIBHWr1IHCiGYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gk/AO+Ss; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43623f0c574so13090395e9.2;
        Thu, 09 Jan 2025 23:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736495107; x=1737099907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATDsjAK0uKMKhFaAu8bbQjJc2CPGx/RtQGrifkWV5pE=;
        b=gk/AO+SsXPHdruZYSKSKU+qChqA9B2rHBoJFNsXxY17xsdJl6AeYsJK3N2l3vk7S1J
         9S1gwfOplYbPa2dkGej18wVajr6ZdxX0WAWcNhQ6QrlSPwnRo+th/GC5ODpuHIYz1sQq
         BprXaWbXE6nlU/tnCH+pskyo1djuw27BKI9Q6zEIzmn2bgd4nXy/8E4ZXQsOxa+P4htr
         EOfSHBuhd7P/G/0Eyqa+cYn0G3XV6SSavzFSMZUjuqI85yRQcmwLEXSfhD8HfwdFj+pf
         L/OwI+8jlSgTuWmCNwLqBqHqz5unW3e2ncZrUcJWUUw8k/0/Ffs0Mobs5g7wjNoxEXxp
         OZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736495107; x=1737099907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATDsjAK0uKMKhFaAu8bbQjJc2CPGx/RtQGrifkWV5pE=;
        b=sIjzAiVBOAKXpYBC2s/U3u4EqTEFl23xft48xbu4oiiHWKDYb8r0LOPB70pAt5Xs8h
         nnD37MhAf55jb+rBOZNGzdj/t8B3DxavjhaPU052eR6SeYDEtJ5JxqhYSr98uTAQe9hX
         rgTNn93/JpeaQo4pmCcBqi2NfMtPHHlB437QtnNnGoHZpadmEq9q9u4RD5Gtz7h2xrvZ
         JyAz4zlWauGMFbANsCikSNkk9gK20lcglDeP5a2mCBt1rQd6MQIm6GFfAuDCe7M5ZY9z
         aADz5bac1lG/z4z/USSE4sZYb0BUkiuaRJpoloJGPBdR3K9phdGMei0HWyI/VEO+Cifz
         BeUw==
X-Forwarded-Encrypted: i=1; AJvYcCU46LdVok6oOHPcqQvGL6LKi/QdLPLTWpx8M9w4EfErpXIXzX5F43dO1gD13ymeyqbo8vCk0rFzqwnx73E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEbPnm4HrPXSfyFHlk0MFVyNK3f/euJCutuXpzvft+d0tmmTb1
	wyWhj//DJPC118lwOZbh74xsjVu9fyJSt/DF4Y0gs7DcWd2VHKcE
X-Gm-Gg: ASbGncsxzer9t2bLEFIGnBwst6EROIA7T0KNy75kX0NqRnScGAJPVpLRdsDLtn3EX5Y
	ROJe40iRcWtLAs599ZPVGh72/A1LHGGDTm5EE7zSfSMJKZTl0UsogDnqec4GZkSgu5ZjXK+c9nn
	hmrm/fFY28Ft1HU0YMb5lIhP8Q4T8oeBqUbb4LesbCwqiv+MAG9Np7r8V56UU2f4a3XSRK0QQDw
	jdrzHzFCIZoAK3ghxuUbota0kFfDOiX2uAfUC9pENGFetMFps5bzZuHa+cQ8w==
X-Google-Smtp-Source: AGHT+IGb+vzb8Pe/v6kmaLVgm8KOUcAV6AU7z/JagMZlqc8SrieF7wsh7dlW2Vj7FxtpiiwFRDJhZQ==
X-Received: by 2002:a05:600c:3c85:b0:434:a802:e99a with SMTP id 5b1f17b1804b1-436e267821emr85597015e9.4.1736495106968;
        Thu, 09 Jan 2025 23:45:06 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e8a326sm78547995e9.35.2025.01.09.23.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 23:45:06 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] Revert "drm/meson: vclk: fix calculation of 59.94 fractional rates"
Date: Fri, 10 Jan 2025 07:44:57 +0000
Message-Id: <20250110074458.3624094-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110074458.3624094-1-christianshewitt@gmail.com>
References: <20250110074458.3624094-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit bfbc68e4d8695497f858a45a142665e22a512ea3.

The patch does permit the offending YUV420 @ 59.94 phy_freq and
vclk_freq mode to match in calculations. It also results in all
fractional rates being unavailable for use. This was unintended
and requires the patch to be reverted.

Cc: <stable@vger.kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/gpu/drm/meson/meson_vclk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 2a942dc6a6dc..2a82119eb58e 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -790,13 +790,13 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 				 FREQ_1000_1001(params[i].pixel_freq));
 		DRM_DEBUG_DRIVER("i = %d phy_freq = %d alt = %d\n",
 				 i, params[i].phy_freq,
-				 FREQ_1000_1001(params[i].phy_freq/1000)*1000);
+				 FREQ_1000_1001(params[i].phy_freq/10)*10);
 		/* Match strict frequency */
 		if (phy_freq == params[i].phy_freq &&
 		    vclk_freq == params[i].vclk_freq)
 			return MODE_OK;
 		/* Match 1000/1001 variant */
-		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/1000)*1000) &&
+		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/10)*10) &&
 		    vclk_freq == FREQ_1000_1001(params[i].vclk_freq))
 			return MODE_OK;
 	}
@@ -1070,7 +1070,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 
 	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
 		if ((phy_freq == params[freq].phy_freq ||
-		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/1000)*1000) &&
+		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/10)*10) &&
 		    (vclk_freq == params[freq].vclk_freq ||
 		     vclk_freq == FREQ_1000_1001(params[freq].vclk_freq))) {
 			if (vclk_freq != params[freq].vclk_freq)
-- 
2.34.1


