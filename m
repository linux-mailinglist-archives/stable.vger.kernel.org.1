Return-Path: <stable+bounces-244157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAOGOen0+WksFgMAu9opvQ
	(envelope-from <stable+bounces-244157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:47:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 521AC4CEC13
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1411030134BC
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967FC30DEA9;
	Tue,  5 May 2026 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq9xI3+E"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E27472777
	for <stable@vger.kernel.org>; Tue,  5 May 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988839; cv=none; b=Jt7bmqDQhVQB0b1kDM/j+7bu7HptAFN+0jET1vVBeWBo+o2KqPFLzFu4Ynp8VQRaWJwy7i+8O4fp/flSI/0hak7oHJslBwmZIC/8O1hrSNEc5u8xjN5Vw35OdXdB8wtoc6qfSU4uXFFLmavZel53fXbN6q0LCjLzgjGDb6F7qZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988839; c=relaxed/simple;
	bh=T1nYSoC/rhLLKKZCwm+PKabQcoZDmbpRIloWfV/g36o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dS8jgVy/B7X/PxNL2NCPZprxw76dYlwl4yUomq4vPv9JbqlZuXHYfZTZBhkNAEAscACljYw45jgFITcNPKczwqWo3hXyBpy4kI4Iq2d03xebS3Abh+ee9Q9e3gTc/vH4sjY3ErEkCh6yu+YEAA1lfoHCzOO1APqxvYpHaHMGXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jq9xI3+E; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso63069525e9.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777988836; x=1778593636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WngZ1i7b+AeASB3S8rstycFmmHOgCBJxwXtpf2QN6jA=;
        b=jq9xI3+ErPS8bCruMti4o4fdOfGXni9RgF2h8h5queIGLYvGBjg4C1zyXBuuo8vn6K
         GGsVXPxuKlIivrVcP81WRRtw6+Zdu7GAuvlUZdsRLLxCiq1WDdwKf/XcIDBBJHFvd5v5
         teNRKJspdM8f2ZmGXX61+2B+GDTWTo1Vot7VReuAAXlTFTsgh2/y+iJAEjFWsI+LREEq
         BsIF8TCQCRAc1H2QPfYvuqlf5PQVqhigqxnsSpKODSJWEe6lHCg2tFoAp5ZDyFzsYhrR
         TuNls9AtQ3NvEhGdKLVeDxl8tlU+OgiqHMzM1tldTTsjrqK30tT1M9y3xycrqbNllVYb
         MV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777988836; x=1778593636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WngZ1i7b+AeASB3S8rstycFmmHOgCBJxwXtpf2QN6jA=;
        b=XSVDhqAvYqOBjaOOeeRA14Mz3cU9kx6zZZxI6Xc8kvi0LwtWmyFeZeNOLw4NQvxI1S
         S1ratj9fXtAGhJwLp0tumDiLvItfjWQJUAiy9CNROTgb+13z9Hvpn5OCnjtIzmrKKrOL
         +qEF7BR8HnnVSZHBbJH/wqoshBu8SFDmg9RaKX2n3qMQqeazmqHU+JPa9iFmIUQd4VZo
         Q6tR5ogQL2qgFWMCWzxODnmrhP7dQkaOKHFAa8Dpfyv9+pDZ1ZR00CQN52q87xrYdqJ2
         a0PpcgFA6TSpiFjb2fIXSEujU+tGxROCyYN2ZKDy9WHw3pcTQvZr2uX7HzkPDYoZK9I2
         bVjQ==
X-Forwarded-Encrypted: i=1; AFNElJ80AY7IrlG1DVdyXtrONTGzkn+biDp4or93dHVGwybf2dC7vcBUpZCJJLikSlT4fGtNOnUh0Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpTdLRi+boteiExo8AvIHFnsRfqV2zmMfLsYDEInzhlIEhF+wt
	MkE2HTJeQTl+hbam6jwi9YUffZMJEqqZTsZ4VKpMy8BZWoF45x6jQrkY
X-Gm-Gg: AeBDiev+WL7mQpPvM3oUGs+6xy0RRYd/9X4rDfFS3vxgkf+DfXzMbi34MMYyvrzW9YL
	vw0l3GHcFtcMfIQ35ID08RTivvAd0Ffm8ddTGc1Wihpf5vTBFYaMzrFNFkisxVMmMi6AHhZTAE3
	Axew3CZ7tb8Vasm4M2Qji+f2+mGzcTZMN1UfZnvrq5mpVD9DbDdxXipvsJJEc+j4OipY9Wfq8QN
	POhxHE/d/YUWywoFrJYwTCylXejDBoORgGE7/QbKXZPwhqQ48N8XQI1nCG40xey+wrBfL3uS4Ju
	QjB3fxtzQeW7NGanf3I0HPfV3/kVcmcJQJWnYyU5yAm7ojEs3eurDzhxNsd0uyA6zFDjvldMaQ3
	HHDPGAgqpIuX7uE8rnoPTOG+jPeQRteRk72caF27Jn9fMw8hcXaD7ElF1hyBLO4Jf9rBcY5G+Hs
	MnQRQK8hAX9nAsD4IPW2CxMTvCZO040XJhz9Ldaqj51QUX7sWk+MRw
X-Received: by 2002:a05:600c:859a:b0:48a:525b:e157 with SMTP id 5b1f17b1804b1-48a9865f870mr168311235e9.13.1777988835944;
        Tue, 05 May 2026 06:47:15 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb694fcsm375814145e9.3.2026.05.05.06.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:47:15 -0700 (PDT)
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
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DEV_PM_OPS()
Date: Tue,  5 May 2026 14:47:05 +0100
Message-ID: <20260505134705.188661-2-ivitro@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 521AC4CEC13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244157-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivitro@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ideasonboard.com:email]

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
RUNTIME_PM_OPS(). Bridge and panel drivers should only deal with runtime
PM, as the DRM framework manages system-wide power transitions through
the bridge enable() and disable() hooks.

Link: https://lore.kernel.org/all/fbde0659-78f3-46e4-98cf-d832f765a18b@ideasonboard.com/
Cc: stable@vger.kernel.org # 6.1.x
Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
v4 -> v5
 - Fix commit message to use RUNTIME_PM_OPS() instead of SET_RUNTIME_PM_OPS()
 - Explain that bridge and panel drivers should only deal with runtime PM

v3 -> v4
 - Add Reviewed-by from Tomi Valkeinen
 - Rebase on top of drm-misc-fixes
 - Verified issue still present on the current mainline

v2 -> v3
 - Fix warning: 'cdns_dsi_suspend' defined but not used [-Wunused-function]
 - Fix warning: 'cdns_dsi_resume' defined but not used [-Wunused-function]

v1 -> v2
 - Rely only on SET_RUNTIME_PM_OPS() for the PM.

 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 0dd85e26248c..e07a9892df4e 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1230,7 +1230,7 @@ static const struct mipi_dsi_host_ops cdns_dsi_ops = {
 	.transfer = cdns_dsi_transfer,
 };
 
-static int __maybe_unused cdns_dsi_resume(struct device *dev)
+static int cdns_dsi_resume(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
@@ -1241,7 +1241,7 @@ static int __maybe_unused cdns_dsi_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cdns_dsi_suspend(struct device *dev)
+static int cdns_dsi_suspend(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
@@ -1251,8 +1251,9 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
 	return 0;
 }
 
-static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend, cdns_dsi_resume,
-			    NULL);
+static const struct dev_pm_ops cdns_dsi_pm_ops = {
+	RUNTIME_PM_OPS(cdns_dsi_suspend, cdns_dsi_resume, NULL)
+};
 
 static int cdns_dsi_drm_probe(struct platform_device *pdev)
 {
@@ -1399,7 +1400,7 @@ static struct platform_driver cdns_dsi_platform_driver = {
 	.driver = {
 		.name   = "cdns-dsi",
 		.of_match_table = cdns_dsi_of_match,
-		.pm = &cdns_dsi_pm_ops,
+		.pm = pm_ptr(&cdns_dsi_pm_ops),
 	},
 };
 module_platform_driver(cdns_dsi_platform_driver);
-- 
2.53.0


