Return-Path: <stable+bounces-233608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLOgHTYZ1Wli0wcAu9opvQ
	(envelope-from <stable+bounces-233608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:48:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA0B3B0571
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D78D306D84D
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CAD28F935;
	Tue,  7 Apr 2026 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9rq9Hfr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59540283C9D
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572918; cv=none; b=BcFKnsvdVc8EA0y2OxNE1XNVj3jKg5ZeGnKHcyf/7/feH2qVzTNicI5V1TmHY0ukXspL5omNesZ1vSVWHeVYs4q1R/+8l2fOTeV+1I9gEHd/dsqgUZBgLz7DjHfIIPYljkDFKpVbK5LK0Jc1XEtzsbbteYTWojAPUCPeW1iIySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572918; c=relaxed/simple;
	bh=xQEGRyP1H4wepinHqC9zBhayNpeAzbDrVWZunTvCxuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JH7VGcRNFrOhpa9IfUrdJBGxRzybVh0mz9L7e0vC4p3x4EwUKkMgwFF4qiKmO5BnYtcBELwNhDqNtjvUGllrT36lGRQY3gkwdhMEj18Tf726QZ4yXm9+xD9WDDLfrgOlNrHS5svd4aoepBNqAmiijR6ZXQDB0sWtS4ak2eR+voA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9rq9Hfr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cfbd17589so4056361f8f.0
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775572913; x=1776177713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBvRjjOb926xFV+H1FqZpjuC1zFML4FZaPUVcq0/XXk=;
        b=n9rq9HfruTYCxwwUbdGoyrUAas4SeSb3A7FJW3uPQ+PJKG7bmSDQAPaRNVBBNsSIgK
         DmACQ7I5vxsHeoglkuLuqr2Lj7b7S8btT0CxUHlFFXka6hd4xIhxT7aKG58WrYrMbmuY
         ThZSkwRd+htH6bCLVuJd1bZl9Mr3/iCYp5b8uiLeG4eIv8erk214zZN7V9kZSVbVciCc
         Sv7RBt1W8sg3efzKCHgZR1ImglNalJ1BVidxQXXMIaYSkuCK/0fy5iF6SA0X2sQ0Hwen
         MauDycOJYLmEduFIlm5ioed6UoEo55QiaK4jR3Ca/WoPyPexTx19Hjl6q80CjXgJdrZn
         vBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572913; x=1776177713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBvRjjOb926xFV+H1FqZpjuC1zFML4FZaPUVcq0/XXk=;
        b=guEskXzYk71vzi/d8UVIDPQqxK3NKxkLscPlujZYbR+afBejZfrGgIgfJa8n8AKzHJ
         vTjdbsn/bt4VT1HMFx1XIOi6TfGJb9OxILOzv1jgWtd/BBtMVqo5do1qM+lG5QR2dy98
         u58G3kS10QPHckuYAe4fqteOYtrrp1V2Fho6d37rvnwgDwxxJUYlcFujGGMZxdAoGTki
         sMwg5DF/sh04WaZh85xRi+Oj8UjskIBetTMEQjbPpKsyceOwbPk4ZgRHBpUuGgHMb9TD
         zb5tDrsN7Kndvm6hb04BxFNDbS/USbQ1BLLekPiyrZF7YDASwAkbCIREDZ99+7vIC3Z0
         s4bA==
X-Forwarded-Encrypted: i=1; AJvYcCWkYdQj3cAx8j+FE8+dJWvsuk6h6U6Fbn7ubJDq770FaDWDCtMIqCHYlWhq2K6D+aSde1bEuAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD8ipB4Q/6kUP54Xn7bA+7OnqeLzDQwDglDegvUfT78n+dMFv/
	agKv7SScuaXpR/o2Bvl5DArKOygZHJgjunXzeCrouHv/yREKyGpwCVhj
X-Gm-Gg: AeBDievXaMBAxSbr0A1xYTWuhXaQsM9EuZEyl4yINyFBl1fGGpWikEcMq4PESMDW+QT
	RsdXSBXpj4wuQAz/oVqwjuD4GNqR4YCgWRNJ7M5W9L34cLtkGPBEziQtnSAS2h+OYDy+H0kkkHW
	Z3yKKJCoBZAs+kXEh1G0xydjjLHcgJcMXO9LjFDAY0NGo1JA2hAw1FhJXbGH8LSM9GvUnLDp8BR
	f+2QB7c14AAhmQOMts3e/Jgt+aO7IVCdODbkZwBlcgGZqidN6GAIXzUZfFMZWzukeFgc4h9xg++
	UjRlHfGQWINi+4IrjLYtXyFpL74hwu0iLE+K2T+n8SDPCqFVJm0o4CqIMBg+VOkSa25i4iq0hFF
	Kc+9YY52sidkNuEeC+/Iydve977WGIkz6Ng4CGe6zSHTu+XlEMX/2PIvgiVS6mdr8Q/Ra9fN6du
	Vog6H60kwbk72AS8ri4RrpFfANeNu4n9nZSG3hTiY=
X-Received: by 2002:a5d:4445:0:b0:43d:4a43:53db with SMTP id ffacd0b85a97d-43d4a4355afmr3472891f8f.26.1775572913195;
        Tue, 07 Apr 2026 07:41:53 -0700 (PDT)
Received: from vitor-nb (dsl-43-224.bl27.telepac.pt. [176.79.43.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm49990292f8f.31.2026.04.07.07.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:41:52 -0700 (PDT)
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
	stable@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4] drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DEV_PM_OPS()
Date: Tue,  7 Apr 2026 15:41:41 +0100
Message-ID: <20260407144142.1420354-2-ivitro@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233608-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivitro@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ideasonboard.com:email]
X-Rspamd-Queue-Id: DFA0B3B0571
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Cc: stable@vger.kernel.org # 6.1.x
Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
v3 -> v4
 - Add Reviewed-by from Tomi Valkeinen
 - Rebase on top of drm-misc-fixes
 - Verified issue still present on current mainline

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


