Return-Path: <stable+bounces-89075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A69B31DC
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 14:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427B1282357
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321A91DACBB;
	Mon, 28 Oct 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="luo7zlF9"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C391D5178;
	Mon, 28 Oct 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122764; cv=none; b=PzU5MDzxoEydlzZFfPPcDZ4IMgZeREuwOksqAHXOP+4eyyq01+QNXKUBGj0VDgc/S+lM9ivdSepEQ5s45D/hI6mjvwnlPwDVPuUhyog3jsu3mIJ+8VD2UyZBXU/ItCNSO2LEAmmoe/4xzpUgj8oMAuO+zXeKlFuXsQoQlEkKhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122764; c=relaxed/simple;
	bh=BTxU7lbd3Ilnfi+bCP6to01QzZ/e1q2VcY1rzjmMIxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1VFKHqtMBWkA6wL/3k8dBsmApoLatdbdsoty4RIHkib7LRBkE6Ll6i5TpHTChnYbSq/ips1guHubS81hj8vgU94krx+z+1wAnZ/xVqSIQvH2Hs3dRjSQxFzfkiGPgUFCHJHxW21IhKCJqEye+iWVq5g8xpBuAYd3LZuuSmITvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=luo7zlF9; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XcZ6y4czPz9slB;
	Mon, 28 Oct 2024 14:31:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1730122314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UaiWgQ1AXzTNomMAaUXn9Y1bpdRE43DfhiGZpik/Y10=;
	b=luo7zlF9FBoaEfUANDbeaf2YgSmiEd/LXMh1DINtKPbqtLaxF2NaE8YdkrulyYLpKF6tbh
	OlZLLuLVC4MOJVnjscSHavPP5sOkhRnWcSaWo93+IJevkS1B5y1pbqPL9QLfyhkYt56y81
	ik/u3jyHoV3qix7fAqahHeFiuQUBmEJR8ZOgjuMu/n3rWOFgozcfXxdK0/Ff/SfbMgMC3Z
	2aiJ4phODmpoebf4K+0IJpwVCslmGKaQtty5t9q9HkGEBAxiPSC0bw41GzkG/t2JxnWLMw
	MPw8tLVkIv+B9NBm91wEkJ3an53Hz8oZrxqdRnQjGD8Bnihn4Lei61QZJal9uQ==
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
Date: Mon, 28 Oct 2024 14:31:38 +0100
Message-ID: <20241028133138.52973-1-lists@steffen.cc>
In-Reply-To: <f7fbd696-d739-457b-bebb-571b32ecc1d6@ideasonboard.com>
References: <f7fbd696-d739-457b-bebb-571b32ecc1d6@ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XcZ6y4czPz9slB

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

drm_kms_helper_poll_init needs to be called after zynqmp_dpsub_kms_init.
zynqmp_dpsub_kms_init creates the connector and without it we don't
enable hotplug detection.

Fixes: eb2d64bfcc17 ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
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


