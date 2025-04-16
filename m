Return-Path: <stable+bounces-132848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C55EA90459
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 15:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FA87AC12A
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B9E225D7;
	Wed, 16 Apr 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNs1gwuV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA92DFA36
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810257; cv=none; b=V0KwwpxjdTwpwgyYAdvLd2kO+zIuzh+/6n2HBOpLB3hEsb1XpnshPm+qMKFAlNJp0oedMQrunGXXJkZYDkhPSL40/zLzNKSWMLWllA3Hh5JU1r5fXeOT3GZyRY2RNrwwUVkRNED6+O3xdPrdFDTbWGVWd1k+u0u2i9HsQGYynyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810257; c=relaxed/simple;
	bh=1e6WVYT54p487326NZnhNnHHuq5jW+mL8FKA32Bllos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kDHaNhDjrQzQZ4ZDnbATRp/E2d+Hx7BE0+36zhr1FRbGwguA0/4w6CJ3TtAh9ixMwFRVbxsmXry2QjDl+4Te80zoGzNW4smtY0BjPLSvvdcEJAq0+AYtBIoIqk6IZS9NH8XS2kMijBzY2CBjbuFxXrPRr97YmhKOHNCxzE0bADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNs1gwuV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fd89d036so82083615ad.1
        for <stable@vger.kernel.org>; Wed, 16 Apr 2025 06:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744810255; x=1745415055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LbNSVDiFHwq8rNV000t7lz6vq0av5GqGVYbhsOdiyA8=;
        b=KNs1gwuV1u6KT6hnffPLFtj5fLt4IIzWzJomh/50+UnGlVbCB0lnJ8AwDiuuJeM52l
         GT5IiA8w2jOUgsQSAYy3KF5w+puSfWULrl28eE4xg4hSJGAlQ4s9qYNFvYX1U5hmhbIO
         JlcqswICpykt2TmlXNDcZhbW7SqjwEXUxVAurSM681QcNx0p4ovCHMQ2+D4/f5AfE/dN
         aYjt32yZhORkEwq2FtDJIeA/H/zKpPr8/NLm+bvs/dKy8qhRFJPSdFne9IWE3qDHQarz
         mKQx12TOPyaYkVpC6tDcFc3XKg0ePWIgVn37xeVCLoKTV2BDINoC90d+0/uMCvZ2tC1j
         Uo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744810255; x=1745415055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbNSVDiFHwq8rNV000t7lz6vq0av5GqGVYbhsOdiyA8=;
        b=wNCdyzVL/ZljSNHj6mxHuCkJo2icx6LREfQFp2dRrg+dIcK1zGN6GmxetRQbxSiM3J
         OFcEwENmkemnRRJNfjlViTdnQbPbAJvOjnBSzpuuRegnNf/uf0I3wOO5R7joJUZXwMoc
         B//ztjqLWBqpvD5eN4igGwscpKham9HWxqWBnQVLTiWeFNPM71PKzssrVA8VlrwobPZ3
         iNOtw3EZXP/XMTjngnnvPMLlbSd7v0BS17spanUPEsNcpPXHHiGr2Gq+nzlLHHQBC45T
         Fh8cONM9i1I/v4sXN0LU6Bh9tqTYe29XvhtsKyo0LCDl2lb9miGBGrxBfjJiVElgopmB
         3K7A==
X-Forwarded-Encrypted: i=1; AJvYcCWYNQSCrAgXaaZSdFBhq/XZINqu4HxBR64n/fNXcjxpKCKvn5MYTRDUGvQY4SHd7x83AQFEZVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvyblSNtsx9BmR7Q9eRVNJBDZTfOoIXczEFrhRBob4Sr5Ba8OE
	OsjO6LYWMslt2r9oKUzXy5XR+mGYeXrNyD0wnh7hjDb6lzcK+0Ta
X-Gm-Gg: ASbGncuGbPhoiJ//qjPEuIKq0D1zUnpATGuTjfajRjFP0Fsn7acKSfpXMGA/7SwwsP8
	1pATF8gOYVGzD7OoOHs6duEW7N0cnBBEwd14v8mVW1KJiwTdPWm8UvfEDTdB7nDk8LQ8PRx2JgU
	Ze8hAEYbGdid6TpD9CikFAKchJgHJZW7jzSegMVv6pWntij0MxocvXayxiCeKBpFUzmDvmMTcLR
	2avVF/QPoPOOueat3c3iQdm4W9yd4Mwf15smOOhJdCUHwKLiPDOL/vShFE1xrpcJVqyBRW/SdaR
	w/Z99gCO2yIx4LyTZ1sQH3gF1/5lBdtyMJB4lyvY/w0QZwGdxc/fUuU=
X-Google-Smtp-Source: AGHT+IG2vRfsCnm5TZSplWPRtz1ywxgjh6sWoTQEfUxv6dxNNa3rWkx78FM/tF2HIadzSJ6G6zfqcw==
X-Received: by 2002:a17:90b:5444:b0:2ee:f80c:6889 with SMTP id 98e67ed59e1d1-3086417cdf7mr3401623a91.33.1744810254931;
        Wed, 16 Apr 2025 06:30:54 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1040:3dd1:1e14:adfc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611f458dsm1525061a91.19.2025.04.16.06.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 06:30:54 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: noralf@tronnes.org
Cc: tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	Fabio Estevam <festevam@denx.de>,
	stable@vger.kernel.org
Subject: [PATCH] drm/tiny: panel-mipi-dbi: Pass drm_client_setup_with_fourcc()
Date: Wed, 16 Apr 2025 10:30:48 -0300
Message-Id: <20250416133048.2316297-1-festevam@gmail.com>
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
for the BPP default") an RGB565 CFAF240320X display no longer works
correctly: the colors are wrong and the content appears twice on the
screen, side by side.

The reason for the regression is that bits per pixel is now 32 instead
of 16 in the fb-helper driver.

Fix this problem by passing drm_client_setup_with_fourcc() with the correct
format depending on the bits per pixel information.

Cc: stable@vger.kernel.org
Fixes: 559358282e5b ("drm/fb-helper: Don't use the preferred depth for the BPP default")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
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


