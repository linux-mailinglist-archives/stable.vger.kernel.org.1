Return-Path: <stable+bounces-142104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F398AAE678
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736E052541A
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BC528C869;
	Wed,  7 May 2025 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjFHSpTA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A6728C2A6;
	Wed,  7 May 2025 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634691; cv=none; b=E5jMrE6UnMiDFaZcf7OO6tXnADR0MrR5tPO2q6+yHj0L+lfMj5F0d1QWKx71fS3pDrZ1nvNbha9/yz9sEKMLWjjAnDEqcUDgbob3W9as71TRKervY7zZYvQBPpEh/mSY02yglZhwJEj5hfHqFQda8yo2H4HKnZ8G9IZ9h4UAK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634691; c=relaxed/simple;
	bh=38syv+ZsT4EKajHWnwSvb0Z+Z/26tyrGhhF8YTgIT4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EbTLlghVNMiePLhj+UqDMcNq6bQdAKTLtppZAYDfHH9OyfkjlTAq80ZhSghJyoFoc7ek2f9of8z/mYvQ5DfInszuzqFo/URdEVO8kffn/co5h1bEUGQ5r3cwEMDXjuREEm4MxKZ90NKyGIC+R1OINLpQSaslmx8YNI8kHWzSuto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjFHSpTA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso389135e9.3;
        Wed, 07 May 2025 09:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746634688; x=1747239488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLwXANYlBMuT5zBgPtCmkgb03VQz6RsgVfqDgCYAJRc=;
        b=AjFHSpTAEHV47syEwmdBHsmYWmIa0MtQ6EUuZQdRisj4R52ctHY3cFp1T2860LN1So
         PoGsnmoGrAEU8a+DibCs8gXrPVb73MfzPeiqH/RbTEA6E8guAX5YQPQ8trs4T5ZI98xh
         imEM54DPZEHFRfHbPCOgMsUXfDN6b/4ZIZ+vgVNjwNX3VKWb/I2eNE5vpXdBkPNHl1Ay
         k/Zzts6JlKY7PdxZwSDqHLV+G/lM708u3QDALrKNf6ePrxLvzeoUipMeytg5t/bCfZf+
         QH4EOEvHIbDa2P4A/b6MSwuEHDYRcJ2ueA3DjVYnGx8otlvY4Ubxw7HsoFmP9mU7q2oU
         Oxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746634688; x=1747239488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLwXANYlBMuT5zBgPtCmkgb03VQz6RsgVfqDgCYAJRc=;
        b=mLJg/MbposKI3B8b+foJIYEzHO/rw4tKmn4z1EPyV049x+xKrUnlt37Ig+TkyDERyT
         EoHdaZmgb67QjuptJrqskrnbVm9xG+fBoQD2Z1dokb3c7jOapv1RGWM5kkUkIYb6LOc1
         WOmBS07dnj3LzoeuAFg8D7T/k587raLcZYM/Fxf0HD8f7puk1zJvZ3TXc09RTg5xmHiF
         qg6u+lPZZdHrKCwQFipYu7tVf4d+qgt0ONUBTMf9fwRGR0iCs7K28DEwPUDBNU77vgdw
         CRwI5//Vu6ftnApESuhMnv+XGWyMWb1KVN51XRFrkLIVlLb93wRhHZb35l+2DKOKr+SP
         +kWA==
X-Forwarded-Encrypted: i=1; AJvYcCUEBd6xzJXRbrn4gdhw8a09uscyef+CBus1sUUOqpKKLZcQ3FRnlrr7lgDYiwcobIBRvjqXAThH@vger.kernel.org, AJvYcCWKbVD5597hB7EBZow2j7aOg9BJVTqIsqwvgRX38jdu61k3ZTrNVXXYLaAeycRoJ5d8s9tMIFXkW8Q9Ny4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg6QO7l2a/MR14yednoNxGjGVJj5ypSKtFjy/Vcnu/om2rZus/
	F1crfeqBeMkov0K6+lhjN96JswGrg4wi0aZwgu5wXo++wp43xGCg
X-Gm-Gg: ASbGnctRDHL1zraRdClOvcu9Pr6a8zm2aOIoTlxWDcepzuKOmLLjPyzkdQZjH5KWVOK
	iNahSJ4KJvQSc7cawRpgcgcqP3Rs+t810L8NVa7gK7dpaixyMO8yf1M9JjwpXzWYYrGvsi01Jw0
	JLKAsqYEn2UNDRTDe6mHNXT2BRHmvbzlNe7wFzdKS+BvGZ1thpVbBNPghPtf5pua/WVF+7pHmQj
	VlDQXBiKzGyYWpz/IUT4U5TCMbI8vOShYkj+/fw9Z5R2v7JLnH+t1vKD4p0wZXNXkIwK1H5Kbkg
	Lz8DY3sFHAxT7ctoVLWtVgB71dCMDrEQ+l+lBw==
X-Google-Smtp-Source: AGHT+IGO760xUJ8iPqAn0f79DygSqXBUJ/ZZmnoLl1Z2maNtSt1vZwHF9eAu1qOC7q4f+S+J1wt9XA==
X-Received: by 2002:a05:600c:3b9d:b0:43d:b3:f95 with SMTP id 5b1f17b1804b1-441d44e03b7mr26435415e9.28.1746634687421;
        Wed, 07 May 2025 09:18:07 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e602:d900:beb4:8333:a918:524e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3af2c8sm5801425e9.31.2025.05.07.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 09:18:06 -0700 (PDT)
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
Subject: [PATCH v2] drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DEV_PM_OPS()
Date: Wed,  7 May 2025 17:17:59 +0100
Message-Id: <20250507161800.527464-1-ivitro@gmail.com>
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
v1 -> v2
 - Rely only on SET_RUNTIME_PM_OPS() for the PM.

 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index b022dd6e6b6e..5a31783fe856 100644
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
+	SET_RUNTIME_PM_OPS(cdns_dsi_suspend, cdns_dsi_resume, NULL)
+};
 
 static int cdns_dsi_drm_probe(struct platform_device *pdev)
 {
-- 
2.34.1


