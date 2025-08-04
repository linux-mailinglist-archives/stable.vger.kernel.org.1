Return-Path: <stable+bounces-166512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD293B1AA02
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 22:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8267A3B71
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F01E21D5BC;
	Mon,  4 Aug 2025 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=nicusor.huhulea@siemens.com header.b="MNCmyQqF"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377F516F8E9
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754338473; cv=none; b=D93M9SRl0a703gFcrTGKFJaPhT3nwxWaE6L80NYnYniNuaCP9HHRKTCJQtesNOqNPsox3uQNMDJAgCbIguQhmaNZ6JRTcaoXDtsGrwsT5Z+GC6e1RX3qVEuaqX+dZWePziFVJzarI1d2332sHyaRPLP2ctTeZTbeUSkpMIy4T2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754338473; c=relaxed/simple;
	bh=MNTGyRh/F7oXsfn0lRC+jW/I9BeOTWn9ZBBhP3i0eIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E/r6kRbpCoHGlBbPh5tp7lOntk0o4ZNENMt2x0XWp6U48eush3j/mH73NiL4I+roJ8sVcRoKWX9JnpRATsKszwwghES8oyGZ8/ytAtdtWIVJSWoTYUeWHVG8lZPd2O/1DGUCyscJkY7/H1VQKuxbwjrdFSAE0gndkXI/w/UNN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=nicusor.huhulea@siemens.com header.b=MNCmyQqF; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250804201419cc062dd374b2ff4db2
        for <stable@vger.kernel.org>;
        Mon, 04 Aug 2025 22:14:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Eg0FnZksed8sRDakoNZ/imDBspZ54K5LuiASPUMrNYs=;
 b=MNCmyQqF8OxupdUaYm0BKKhTuulV7v/FSQAmb1H7l5SqUfCAyXGXUnGEw7MiAUtL4atBI1
 HMrzL2pzbdd2EYYtIjB6/Y5AxsjENgaMmnNKLckcepcrVeoG6kHSy6JaRw/y7Rg/fd8S3tlm
 kmgAyQ8+wmcmHpvUe3XoDIV7qnU08CC2TA5sXEcee09WaohfEZeJGIGsO8oDxV5NB2zNVJdv
 4s0ZV950xZki7KMSV8uFSr/wfIughT2UiAYd0wETHiUCobkxDR80xLWbRyigfMcQzElZt1bl
 L1s5hM0X5I9qQvYbTOTu4icKD+0XjrFB7ahoCjQLMSYCaUKw89uQyx5w==;
From: Nicusor Huhulea <nicusor.huhulea@siemens.com>
To: stable@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	cip-dev@lists.cip-project.org,
	shradhagupta@linux.microsoft.com,
	imre.deak@intel.com,
	jouni.hogander@intel.com,
	neil.armstrong@linaro.org,
	jani.nikula@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	laurentiu.palcu@oss.nxp.com,
	cedric.hombourger@siemens.com,
	shrikant.bobade@siemens.com,
	Nicusor Huhulea <nicusor.huhulea@siemens.com>
Subject: [PATCH] drm/probe-helper: fix output polling not resuming after HPD IRQ storm
Date: Mon,  4 Aug 2025 23:13:59 +0300
Message-Id: <20250804201359.112764-1-nicusor.huhulea@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331196:519-21489:flowmailer

A regression in output polling was introduced by commit 4ad8d57d902fbc7c82507cfc1b031f3a07c3de6e
("drm: Check output polling initialized before disabling") in the 6.1.y stable tree.
As a result, when the i915 driver detects an HPD IRQ storm and attempts to switch
from IRQ-based hotplug detection to polling, output polling fails to resume.

The root cause is the use of dev->mode_config.poll_running. Once poll_running is set
(during the first connector detection) the calls to drm_kms_helper_poll_enable(), such as
intel_hpd_irq_storm_switch_to_polling() fails to schedule output_poll_work as expected.
Therefore, after an IRQ storm disables HPD IRQs, polling does not start, breaking hotplug detection.

The fix is to remove the dev->mode_config.poll_running in the check condition, ensuring polling
is always scheduled as requested.

Notes:
 Initial analysis, assumptions, device testing details, the correct fix and detailed rationale
 were discussed here https://lore.kernel.org/stable/aI32HUzrT95nS_H9@ideak-desk/

Cc: stable@vger.kernel.org # 6.1.y
Cc: Imre Deak <imre.deak@intel.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>
Suggested-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 0e5eadc6d44d..a515b78f839e 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -250,7 +250,7 @@ void drm_kms_helper_poll_enable(struct drm_device *dev)
 	unsigned long delay = DRM_OUTPUT_POLL_PERIOD;
 
 	if (drm_WARN_ON_ONCE(dev, !dev->mode_config.poll_enabled) ||
-	    !drm_kms_helper_poll || dev->mode_config.poll_running)
+	    !drm_kms_helper_poll)
 		return;
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
-- 
2.39.2


