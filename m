Return-Path: <stable+bounces-89076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9089B31EA
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 14:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3E81C21743
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 13:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F221DBB13;
	Mon, 28 Oct 2024 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="TLwDU7Ed"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5AF1DB92A;
	Mon, 28 Oct 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122963; cv=none; b=dM2P89bYgaby/y2aySDkkvh2lgh0aW3ne+Wqdg/jnL9ItGrKdzG80z6h1/tu6VxCfuED8Oqxo7FDebqibNdOCmoWG+RIy2w7HsEkYxIH/CcvwCjMva9o7jAIhtn61SKO+707TSldpMLjVhGGNf4cDY8xhAhRU7qyxUppcZg0gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122963; c=relaxed/simple;
	bh=V2bm68Aam0kLjC158+jZ/CWLV08CnutoQAqhJ/ADHIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTB5WnOFf33KDpLFcEzYPQXeu8L+HaQpMpu627VVX9kX4KPVhNlFvBXYyeOqrOa+2A6aDNTj7Z8nW4c7FoTTEaJ8N0Pp1BhpV7eWIQQixR4hFpAiiHvfsO93iFy1hWi2maa3fQeT8f9UmU2CIKh10UcN3Osv5PEdWNnRfmpFHTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=TLwDU7Ed; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XcZMB4z28z9spY;
	Mon, 28 Oct 2024 14:42:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1730122950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnAt2WGdW9o/tfYw/mDO16S2oXry5gmhCCzZ6QXpMaY=;
	b=TLwDU7EdjMHnB/kN4w7klFnTpfTh39T+w2Ip2Z+SNLYnTrNRaz3gaXvV6Rj26Swm4jMozt
	rLKv2xX7gKI++qMioucgmHWSs57O7qvQwMKA6i+OgpSiyFaRuilbGMvTebtZESFRtkV/F3
	J/bhWVMteFxlD2ypar6tvgSmhqcMprefpYQE2/QfSHPyPTcPTUYIZu8t3GdoD9k3xwA0ac
	OFfIaZRGYLf2VaObHIenOR+PQ41w6FwUflA9yJ8i/3BOYY0aU40tRil1kdb3BaKMKdP7lP
	jU/qYdtuqGQg/QFUnCp6XPVmYboQXtIviDqqeEtmOzHIunSinUueiboohKBE8A==
From: Steffen Dirkwinkel <lists@steffen.cc>
To: dri-devel@lists.freedesktop.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	stable@vger.kernel.org,
	Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: xlnx: zynqmp_dpsub: fix hotplug detection
Date: Mon, 28 Oct 2024 14:42:17 +0100
Message-ID: <20241028134218.54727-1-lists@steffen.cc>
In-Reply-To: <f7fbd696-d739-457b-bebb-571b32ecc1d6@ideasonboard.com>
References: <f7fbd696-d739-457b-bebb-571b32ecc1d6@ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

drm_kms_helper_poll_init needs to be called after zynqmp_dpsub_kms_init.
zynqmp_dpsub_kms_init creates the connector and without it we don't
enable hotplug detection.

Fixes: eb2d64bfcc17 ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/gpu/drm/xlnx/zynqmp_kms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
index bd1368df7870..311397cee5ca 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
@@ -509,12 +509,12 @@ int zynqmp_dpsub_drm_init(struct zynqmp_dpsub *dpsub)
 	if (ret)
 		return ret;
 
-	drm_kms_helper_poll_init(drm);
-
 	ret = zynqmp_dpsub_kms_init(dpsub);
 	if (ret < 0)
 		goto err_poll_fini;
 
+	drm_kms_helper_poll_init(drm);
+
 	/* Reset all components and register the DRM device. */
 	drm_mode_config_reset(drm);
 
-- 
2.47.0


