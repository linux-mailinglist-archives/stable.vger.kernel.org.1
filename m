Return-Path: <stable+bounces-143132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5CAAB31BC
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D901D7ADCDB
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 08:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E3825A325;
	Mon, 12 May 2025 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Umm7QY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0593B25A2DA;
	Mon, 12 May 2025 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038745; cv=none; b=K3mUZNMlatszQrK1reZhHrPKi6sV14GcUJ+WwN0sGbM9QNUTQLXF8Lyd1WGN2yQBORds+9Wubacv/G9fioY0Qi97ufkpFbRQUL6QSQSOHgFU2t61KPGPmA+6LeBLX0yacaGRvZQj+4Mq8KTFzA7gP5XrGumT/zx2nSyv8gIKD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038745; c=relaxed/simple;
	bh=2BugR5P92QeAabJWPRUeZifG7CzJunI8qA3dpv69ysE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OPoNR3Ji0orJc0sNmWz9so2Cwap0lEGuRxubqUN3592Ji2nDPChpZnWc6/VzshPSViWtsSnUOMFN1S0iG32UOSChEFBHsXjb7DTpSg/otfy7+BpEntJ0xB3CNQpcoVND1gv3muI6jw6qieDAUPI/kY+jcij3GY/5oE1pJQyrpmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Umm7QY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-441c99459e9so26799885e9.3;
        Mon, 12 May 2025 01:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747038742; x=1747643542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYXcYfmW92NwQS8DOWBMZ1iD5TRg6ruyTQhU7K965SU=;
        b=g2Umm7QYiJYhJDBVj+dSF4SqqNTqVBWLZRbFtCDmlTN3cVQcE9DY+wlpcZHVhlSu1i
         Rx/TlwUn7xjrUrRl7KWKt5toDHcsgKXm08n5y6PlLWJRIU2H+OZXyNn98DYKCekofxe/
         dfPETQ5Lo1IPrc7FVxVu+sQmwEVVdOiKlx2kFVWF5RoPnkevUMBM3Ei8BGfeMJMW8v3s
         ArA+a8SKKxxVG2FfIlBil24BhemvpE4HGKzDAYloWEZ76Y3xdPVpsM7f45Jvem91YjAJ
         8cqcPS+Q/hCRqL8TZudcvK/L0Uyri9BZHyy2xxmSVyED7pKc4Lsjy0dZvvy85l2XIOBg
         BFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747038742; x=1747643542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYXcYfmW92NwQS8DOWBMZ1iD5TRg6ruyTQhU7K965SU=;
        b=cT51RJTIEkX43vp+kip/DG5q4pmu+L/gITivJCgAiB0Uqa9lREBBiv65bK+F21UMOp
         VFVQgVaucNsi2nh8G7YKwN3PSRlnGcduFK/uCpOhN1Rm6iSrum0EY0zkyxGbGrOEGXWF
         DmQP21sxtG5c9iQGPchUB2hcJkw+WT3OL3QNOIFuwmt2xEubc6FqkLosGfxdjja1p37V
         g8+OPkREBS2bNd4CZ9NKi597iYoalHWtXPmd8fg9ATkk8gXObC2Qn5jj2E7WVFiS9AD8
         rN+hqrUPdl02G2OtvQjsAAyeZ3QSUEb6aqoHiE3Nx0xXoV/yEczqJz8vElVjSZoaC+KY
         jUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnfbhp0LqYDabwjFghqfOqlD8vDnqhIIggpEPpFPrK3x2o14U42AVOA2VzDzUkejY0rVjySO1T@vger.kernel.org, AJvYcCX5gmOBLm2/4LbVsAdCF00VhVZNQ8cql8BL7dEc765F6JnfrM1Gw3tDyTww5FmlK5gZ8iM9XlLejatmcLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeaGe6btedKu3jCS4eQFPjeCVL/5hCPh0YDcBwD+pTJ++ry//W
	tlq8ZIYUgDJRBjnR3kS67nmNV6xegxdjErl85Lvml0Zj2UcZfHGR
X-Gm-Gg: ASbGncvbTsvZd0ZYAfSzjCVvGHCQpbSu6trBPZ7kb7fRzt3mcv7gbkztbnsZD+/4kiJ
	+M4noWmVkanpYK7DIGBXIhIui99pve0RdKGvFKNBmu4gST1Ru97v5XMkhXOmcNCNUKcgEy6l1gS
	8/VVlemk5xwweuzcYSu4JS7Bv+rujLT4f8jyiNebIBsOnT3XMB5okSDq99i77VCQbT82ttaW+MG
	tzU4U1EWsTHBRzk1DcztTLjMULSByszSMLsVB00NjSCvOU9k6etKdZsUeNSf7Qoea6n1VQ9X7im
	Nz40mPd4MwNeXa079JPpuAw8BkzQxu9w0A5x7Ys/rjgxM/0o9Otr
X-Google-Smtp-Source: AGHT+IEJoNDjSaA+Sniz3FqA3ByQMXjgbbgPzhBhHPvWA9YXb+3eKhQDYoPDKhbTMcwyvyd3M3nzGw==
X-Received: by 2002:a05:6000:430e:b0:39c:1ef6:4364 with SMTP id ffacd0b85a97d-3a1f643833emr10644682f8f.14.1747038741864;
        Mon, 12 May 2025 01:32:21 -0700 (PDT)
Received: from vitor-nb.Home ([2001:8a0:e602:d900:7df1:5521:294c:1eb5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5a4sm11577918f8f.81.2025.05.12.01.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 01:32:21 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	ivitro@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DEV_PM_OPS()
Date: Mon, 12 May 2025 09:32:15 +0100
Message-Id: <20250512083215.436149-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
for both runtime PM and system sleep. This causes the DSI clocks to be
disabled twice: once during runtime suspend and again during system
suspend, resulting in a WARN message from the clock framework when
attempting to disable already-disabled clocks.

[   84.384540] clk:231:5 already disabled
[   84.388314] WARNING: CPU: 2 PID: 531 at /drivers/clk/clk.c:1181 clk_core_disable+0xa4/0xac
...
[   84.579183] Call trace:
[   84.581624]  clk_core_disable+0xa4/0xac
[   84.585457]  clk_disable+0x30/0x4c
[   84.588857]  cdns_dsi_suspend+0x20/0x58 [cdns_dsi]
[   84.593651]  pm_generic_suspend+0x2c/0x44
[   84.597661]  ti_sci_pd_suspend+0xbc/0x15c
[   84.601670]  dpm_run_callback+0x8c/0x14c
[   84.605588]  __device_suspend+0x1a0/0x56c
[   84.609594]  dpm_suspend+0x17c/0x21c
[   84.613165]  dpm_suspend_start+0xa0/0xa8
[   84.617083]  suspend_devices_and_enter+0x12c/0x634
[   84.621872]  pm_suspend+0x1fc/0x368

To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
SET_RUNTIME_PM_OPS(), enabling suspend/resume handling through the
_enable()/_disable() hooks managed by the DRM framework for both
runtime and system-wide PM.

Cc: <stable@vger.kernel.org> # 6.1.x
Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
v2 -> v3
 - Fix warning: 'cdns_dsi_suspend' defined but not used [-Wunused-function]
 - Fix warning: 'cdns_dsi_resume' defined but not used [-Wunused-function]

v1 -> v2
 - Rely only on SET_RUNTIME_PM_OPS() for the PM.

 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index b022dd6e6b6e..6429d541889c 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1258,7 +1258,7 @@ static const struct mipi_dsi_host_ops cdns_dsi_ops = {
 	.transfer = cdns_dsi_transfer,
 };
 
-static int __maybe_unused cdns_dsi_resume(struct device *dev)
+static int cdns_dsi_resume(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
@@ -1269,7 +1269,7 @@ static int __maybe_unused cdns_dsi_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cdns_dsi_suspend(struct device *dev)
+static int cdns_dsi_suspend(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
@@ -1279,8 +1279,9 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
 	return 0;
 }
 
-static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend, cdns_dsi_resume,
-			    NULL);
+static const struct dev_pm_ops cdns_dsi_pm_ops = {
+	RUNTIME_PM_OPS(cdns_dsi_suspend, cdns_dsi_resume, NULL)
+};
 
 static int cdns_dsi_drm_probe(struct platform_device *pdev)
 {
@@ -1427,7 +1428,7 @@ static struct platform_driver cdns_dsi_platform_driver = {
 	.driver = {
 		.name   = "cdns-dsi",
 		.of_match_table = cdns_dsi_of_match,
-		.pm = &cdns_dsi_pm_ops,
+		.pm = pm_ptr(&cdns_dsi_pm_ops),
 	},
 };
 module_platform_driver(cdns_dsi_platform_driver);
-- 
2.34.1


