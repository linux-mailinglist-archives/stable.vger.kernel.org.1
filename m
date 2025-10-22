Return-Path: <stable+bounces-189006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF73BFCD21
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 661AF4F9540
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F40234C151;
	Wed, 22 Oct 2025 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UNKHtIv5"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828934C15E
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146279; cv=none; b=p3sDfMVefRXWsBXBa9IGIAOWwcsjw4x9nnoxyXiwUCbbgdszPXqZfcTp83uKxap/KhwGvcoXz3HCKwrDoLYeuy0nu0hmLDTi+u89GnzdzLJrDYoi+tDbmeTgX1czinWFfv+VtY69pQF/GfInTYcbvM4QFiTVcpvokULhnS0x2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146279; c=relaxed/simple;
	bh=eEi5uGSy32lg1YEn4uhchHVaozmcMy+gUlUoOl32tFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6eEQvcfdQhU5bVNhTCYTaGNm3HF2O5mf+xnhxHNBsRnKZNsOTQDYjiR8znp5xNMye48ZpM2XTGC7AgKpeygr9MHtrTrFLAE1x2wVCtL+cGOlaqJcSaAQUY+9YvgyBw2vBH0Il/mY+zUAxvCzuTjG1+ri/VxeNQV9Qpzn544SlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UNKHtIv5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E607D1A15DC;
	Wed, 22 Oct 2025 15:17:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9620606DC;
	Wed, 22 Oct 2025 15:17:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B185D102F23AD;
	Wed, 22 Oct 2025 17:17:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761146271; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=CChA9h90pM92X6zpGVU45uXBGsE28460coNy6HElnTo=;
	b=UNKHtIv5f1DzlxegUyhHSDfJ7g25b/CPCEU3SM9RVlJIpi6E0EBTl6jl7VFNlEpJ4NTWV2
	HcfDK+MtQX0e4N747aUnearfX70ksr/PyZkeevsJTT7nNSW9ZpGExcEc+zA4HYpJJfg1sK
	AJUAfvAsW3OdDMfP2WzJ6jw4XQYfRULAmPSaaoqKvjtCmLz61sbyC5hXDgRNvOoFVDbDvR
	S2OhtLkr0zhAYk30l8KVPulymsRD/PtA229eg2kOF+SHPnAFtoqGBFdqYgNj+H+IetJKwJ
	jGDrqHNXZZCTIjw+P4todOqIqXWFf4bhXCRRtrC3MilgZ4DKL2xHf5BH2dpRUw==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Douglas Anderson <dianders@chromium.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maxime Ripard <mripard@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Bajjuri Praneeth <praneeth@ti.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	"Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
	stable@vger.kernel.org,
	Swamil Jain <s-jain1@ti.com>,
	thomas.petazzoni@bootlin.com,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2] drm/tilcdc: Fix removal actions in case of failed probe
Date: Wed, 22 Oct 2025 17:17:38 +0200
Message-ID: <20251022151739.864344-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>

The drm_kms_helper_poll_fini() and drm_atomic_helper_shutdown() helpers
should only be called when the device has been successfully registered.
Currently, these functions are called unconditionally in tilcdc_fini(),
which causes warnings during probe deferral scenarios.

[    7.972317] WARNING: CPU: 0 PID: 23 at drivers/gpu/drm/drm_atomic_state_helper.c:175 drm_atomic_helper_crtc_duplicate_state+0x60/0x68
...
[    8.005820]  drm_atomic_helper_crtc_duplicate_state from drm_atomic_get_crtc_state+0x68/0x108
[    8.005858]  drm_atomic_get_crtc_state from drm_atomic_helper_disable_all+0x90/0x1c8
[    8.005885]  drm_atomic_helper_disable_all from drm_atomic_helper_shutdown+0x90/0x144
[    8.005911]  drm_atomic_helper_shutdown from tilcdc_fini+0x68/0xf8 [tilcdc]
[    8.005957]  tilcdc_fini [tilcdc] from tilcdc_pdev_probe+0xb0/0x6d4 [tilcdc]

Fix this by moving both drm_kms_helper_poll_fini() and
drm_atomic_helper_shutdown() inside the priv->is_registered conditional
block, ensuring they only execute after successful device registration.

Cc: stable@vger.kernel.org
Reviewed-by: Swamil Jain <s-jain1@ti.com>
Fixes: 3c4babae3c4a ("drm: Call drm_atomic_helper_shutdown() at shutdown/remove time for misc drivers")
Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

I'm working on removing the usage of deprecated functions as well as
general improvements to this driver, but it will take some time so for
now this is a simple fix to a functional bug.

Change in v2:
- Add missing cc: stable tag
- Add Swamil reviewed-by
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 7caec4d38ddf..2031267a3490 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -172,11 +172,11 @@ static void tilcdc_fini(struct drm_device *dev)
 	if (priv->crtc)
 		tilcdc_crtc_shutdown(priv->crtc);
 
-	if (priv->is_registered)
+	if (priv->is_registered) {
 		drm_dev_unregister(dev);
-
-	drm_kms_helper_poll_fini(dev);
-	drm_atomic_helper_shutdown(dev);
+		drm_kms_helper_poll_fini(dev);
+		drm_atomic_helper_shutdown(dev);
+	}
 	tilcdc_irq_uninstall(dev);
 	drm_mode_config_cleanup(dev);
 
-- 
2.43.0


