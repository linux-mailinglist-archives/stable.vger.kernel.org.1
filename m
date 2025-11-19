Return-Path: <stable+bounces-195166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B737C6E5E9
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 13:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1795838392D
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 12:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5C434E743;
	Wed, 19 Nov 2025 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="paJ2Bppv"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B034347FE8;
	Wed, 19 Nov 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763553811; cv=none; b=GFPzVokHB2Bok701f3TDtDOV6Ejedz0YjicCLCsiBDfh6fzU+R9YbqzL3KDHQNFUnjMvla8HuPvDwxtLWCSKseLZLSQejtvrQAjeX6KfUBkb7fRlcCkWg6YTZMKpz/8SxQhEJNjKfOEJsOIxgcBPcJeo8bE7lCXyvD3mIHcbFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763553811; c=relaxed/simple;
	bh=8M/C7v7p1802Y3or/0It2c8ANJrHosFKHg7bE3P7lGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t4vZV9moOTYY4v2KrKyOx6MXpwlP+kAKasgA1dr+EsrVFHS0zq6j9PMzqPdi1n4HCX4cn813lWsLF7mogOLu2iZyX9HvPTliQ8ldrf+EfmXes1vEXo4y1kFeujuwD60mRxi0izAfeLsx1djg2bYU9HCpingIEhj1SB+7Pop42jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=paJ2Bppv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 34DBE1A1BD1;
	Wed, 19 Nov 2025 12:03:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A2D860720;
	Wed, 19 Nov 2025 12:03:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E24C10371A4A;
	Wed, 19 Nov 2025 13:03:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763553800; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=zPUlO2R5eXMWotkNTVCSB8Dpcd7nY6Qnl2imtQ6Qgvw=;
	b=paJ2BppvoZ0NPRDAzneJwTOUDx3IdZgsXIxQVeL2jmJrsiCCCc0wrSbxmvRZK+elTnit/3
	aIpCopQ1lyHo2oCSXnt1en71XLOt+PsQOgmr3LDQgWDWTA17zaO55iYFjc+JLF4VimE5BO
	sVA31zD11qHfH6qRp/2aBxX9UYIQUZEzV8WL3cyAZguksUhIC51PFigWfuZoc4Lc+rTZDW
	NtcREBhV0ktknWKiXSpnXgzvygXrjiTdoXYBwDdpqnJfIIXlFCh4jjgjOY+WdsN2it2j8k
	PJTEsowe60ibBHjkRYYpU3UpoPu3lvfifXE6RgTFc4yTjzcBf1xmMoiTwYHj8Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 19 Nov 2025 13:03:02 +0100
Subject: [PATCH] drm/arcgpu: fix device node leak
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-drm-arcgpu-fix-device-node-leak-v1-1-06229edcfe6e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPWxHWkC/x2NSwqEQAwFryJZGzCCDO1Vhln0J+0EtZU0iiDef
 cIsC169uqGyClcYmxuUT6myFQNqG4hfXyZGScbQd/1ARA6Trug1TvuBWS5M5kTGsiXGhf2M2XU
 uRMqvHALYy65su3/h/XmeHy/19ZtxAAAA
X-Change-ID: 20251119-drm-arcgpu-fix-device-node-leak-f909bc1f7fbb
To: Simona Vetter <simona.vetter@ffwll.ch>, 
 Alexey Brodkin <abrodkin@synopsys.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

This function gets a device_node reference via
of_graph_get_remote_port_parent() and stores it in encoder_node, but necer
puts that reference. Add it.

There used to be a of_node_put(encoder_node) but it has been removed by
mistake during a rework in commit 3ea66a794fdc ("drm/arc: Inline
arcpgu_drm_hdmi_init").

Fixes: 3ea66a794fdc ("drm/arc: Inline arcpgu_drm_hdmi_init")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index 7cf0f0ea1bfe..c74466ea2535 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -250,7 +250,8 @@ DEFINE_DRM_GEM_DMA_FOPS(arcpgu_drm_ops);
 static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 {
 	struct platform_device *pdev = to_platform_device(arcpgu->drm.dev);
-	struct device_node *encoder_node = NULL, *endpoint_node = NULL;
+	struct device_node *encoder_node __free(device_node) = NULL;
+	struct device_node *endpoint_node = NULL;
 	struct drm_connector *connector = NULL;
 	struct drm_device *drm = &arcpgu->drm;
 	int ret;

---
base-commit: 949f1fd2225baefbea2995afa807dba5cbdb6bd3
change-id: 20251119-drm-arcgpu-fix-device-node-leak-f909bc1f7fbb

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


