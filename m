Return-Path: <stable+bounces-132999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E857A9197B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF4B19E4008
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A381FCFDB;
	Thu, 17 Apr 2025 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+O2ocFt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3E3D994
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886109; cv=none; b=HUnuoRmz9T3XruK4V4Mqqa2R0TGC6D+pWOMSIL3mRtvJpcI7eL7+wMgehuhgplAGaW9fGKBEOhA7QORxMTg+/cHVT7Hlkm9FXrRjbs7qGym3otHxgljDo95MW51dDiqpC37yAfa0c1cNGfFKbovlmAI04J5rugeMe69aqrRkAKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886109; c=relaxed/simple;
	bh=5BlieCIgZ/eKd/3gY5BZl15HoCQAIiJ1hNNqBWTqzzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WyIz1j0OnAD16rLCsDuCHDI1DjcHNutkmCxUfG0gMskEhG2WFw+7rrFtFnqGEQh3XcIn1ROEqvToH5A8kt2JYxTuR/H90s+vYEa53E+A95LhLfu5yy4Id+S0IkXUKqpAdtTsn/YdV1ortqzJYJlYDS4nO5QaPr0lZDUEf/O0gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+O2ocFt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73c17c770a7so779545b3a.2
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744886107; x=1745490907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V5alxNm/DLkzjQ9ZfukVKFr2c1g7/WejA+wG2G/ssrc=;
        b=N+O2ocFtyy2XSDrTSXXUlJNOY5r82ilePcrXph0lFVOVPpt8lIT4Rd53tQOT3RhyvR
         lrwSlq3Dp5SH2GyymI3mImame/bUP3j/8oaxBT9FJejA6S7a/81FR6JrxuACV5atnYFf
         KwEWAN7cRkLASR1AeF4Nwx11pYEoc8u10g/X84Q9DL9ZJKlXprY3RD/yhEGCsf8xInIJ
         WWKQmAveqDCIKT29CpG91unmNchjgR4xOudG2+py8Hb/8MGcn23cuHFj3SCN4w82Oavj
         tls9f5Gi1AZ+nKQxxx0ns4eFR+v7kpipWz8W4MJO7jB+Ov74jCEQ3hgIr8y45GA5YcQY
         uhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744886107; x=1745490907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5alxNm/DLkzjQ9ZfukVKFr2c1g7/WejA+wG2G/ssrc=;
        b=pyzzQzDTJA1jwUncyLor4pU4ZA7yMWDoqV3pqV+lwKf8i5n2AeApauUogiicjEfbVT
         KZVtMx2MvS2cQfOviSNkx85bEXy5ds+HDAw/zZZCNzThO+f9DWos5ikElnel04JXluLO
         soDW45dkwz8gEd1Qru3dk+7B1kfqa5C/aa3Q4T/huKKReIQyccN16VPVqxM7GAmuihnk
         8VU0ME76fqB7aCubM8bDn2aM2xjJaLiE171EaoI2x5a1KK1nB/+hZg0JY8qnJalSsimb
         zg+lRRubTM8XUqKA3iS0xpw0SUj4boFgXI5GmQkqeMuEyLl8bN1M2DM6wK4D40tijBGb
         AaKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbvr+GfBY8wH4KdWFHvuPNCYHKW6DSkTjb8SvnsC6zu0QfoUODOFe+5vtmogtTfmhJx6yhiZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDFgPqr8T5DE3nrLmkyADwVI14GIIBEvgJlJSCzmlsEQyc/lLr
	0wvZOYmT/YjRdWQbI9TbTOIzb8wes50R+ZEHOzJw427HgLzszMRy
X-Gm-Gg: ASbGnctsgMwOXTEKoRanFIrhV9lYpRo5CM/rxMQbKdZ8X0zOFz9C8Oqn5EXRp3ZRqPV
	SF055+4dd+wJrrCn1SKtApvdmK2hC59hdLG0Ljy1l2EK3ultijSALG0kyrjYk5uJhbAquB0SDD2
	bHIIYX+GnKj7IGJHbJpExo8PZt4Yr7Wq2NLUorxUtvkPHS+bR/YgAA7A6lt8oOZgRBejCE0KgIE
	uIXBudsnc3YW6zqPRCUBM3xKCzPc/nhY0KAOr58uH3xPXdO827KugzX/b/94PEDBnhlfqJDXDlA
	15+IY/JAeNOSWg22wisxKinRIAyslwEqQu9oWxCHVwwgXM9fe4xtQ78=
X-Google-Smtp-Source: AGHT+IG46dsdwMApeeROd0P8FHUNsfcsg7uqz2ZNUbeyxe7v6pPDAr+96aBvmoyqg4xi9S2Y2pJ/BQ==
X-Received: by 2002:a05:6a00:2442:b0:736:ab21:8a69 with SMTP id d2e1a72fcca58-73c264c576emr7125034b3a.0.1744886106678;
        Thu, 17 Apr 2025 03:35:06 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:579d:5312:b7a3:7e17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b22202ae2sm2681585a12.61.2025.04.17.03.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 03:35:06 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: simona@ffwll.ch
Cc: airlied@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	noralf@tronnes.org,
	tzimmermann@suse.de,
	javierm@redhat.com,
	dri-devel@lists.freedesktop.org,
	Fabio Estevam <festevam@denx.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/tiny: panel-mipi-dbi: Use drm_client_setup_with_fourcc()
Date: Thu, 17 Apr 2025 07:34:58 -0300
Message-Id: <20250417103458.2496790-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

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
---
Changes since v1:
- Improved the commit log.
- Added Thomas' Reviewed-by tag.
- Added more maintainers on Cc as panel-mipi-dbi.c has been marked as orphan.

 drivers/gpu/drm/tiny/panel-mipi-dbi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index 0460ecaef4bd..23914a9f7fd3 100644
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


