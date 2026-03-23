Return-Path: <stable+bounces-229936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IBLMmp2wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:20:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F422F9BF4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86A9E35BC8C4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F8C23504B;
	Mon, 23 Mar 2026 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iZFuFldI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36B73BF67B;
	Mon, 23 Mar 2026 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283308; cv=none; b=Mw6aUwwGuCXX3k9SIxGIyZThq074a7d0LiDJE+H2HwMFlOkQI97rGQ9Nxlm1UQo+8mkEZP2+kCzDIjukCe7p2iMJWGLHbjHP15ANNGxflErNkg5TCN7JgAquPVaFacsM9VamJ6ioGIlCVGVwCimFTtZXN/XVGZoMxiN49+pQmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283308; c=relaxed/simple;
	bh=x4GIOloxbHACPRtiGA2MF6KFY9eB071wckxhG0bpx4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7B9E1yYpKDZawNa+o09ttCka5+s6oOLhM90jISkeuEQYRGmcAbghdESCA0xD6GzE0WxYvOS/50bIasqeJUZ/idGGdgwS4RBKdI2YXLj+AQBCuClmQpN75gCw953vDXhI/iR1o6W/uvPgpc4BGsejXFqiqUeJcbc+8VKDOm+3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iZFuFldI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1085AC4CEF7;
	Mon, 23 Mar 2026 16:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283307;
	bh=x4GIOloxbHACPRtiGA2MF6KFY9eB071wckxhG0bpx4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZFuFldI04vGNx3AOTsgQDmtlc2A5RJmtDvSTXVuVtNet+rU7MdMFVBz09cuNyUY/
	 +Drgy9cMPadW3t7vLClmgPQU5bJMjqUcTKWcsqgNiCmNhX5orKQAfPA7S65eENUQwf
	 1JzLPvJBL6YEm/dkMXZ/QfbI5u2/mMHYSVBF0do4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rosen Penev <rosenp@gmail.com>
Subject: [PATCH 6.1 460/481] drm/amdgpu: clarify DC checks
Date: Mon, 23 Mar 2026 14:47:22 +0100
Message-ID: <20260323134536.428244473@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229936-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,amd.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 29F422F9BF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit d09ef243035b75a6d403ebfeb7e87fa20d7e25c6 ]

There are several places where we don't want to check
if a particular asic could support DC, but rather, if
DC is enabled.  Set a flag if DC is enabled and check
for that rather than if a device supports DC or not.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c          |    2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c       |    2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |   32 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |    2 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    1 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  |    2 -
 8 files changed, 25 insertions(+), 21 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1071,6 +1071,7 @@ struct amdgpu_device {
 	struct work_struct		reset_work;
 
 	bool                            job_hang;
+	bool                            dc_enabled;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -857,7 +857,7 @@ int amdgpu_acpi_init(struct amdgpu_devic
 	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 
 	if (atif->notifications.brightness_change) {
-		if (amdgpu_device_has_dc_support(adev)) {
+		if (adev->dc_enabled) {
 #if defined(CONFIG_DRM_AMD_DC)
 			struct amdgpu_display_manager *dm = &adev->dm;
 
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1981,7 +1981,7 @@ int amdgpu_debugfs_init(struct amdgpu_de
 	amdgpu_ta_if_debugfs_init(adev);
 
 #if defined(CONFIG_DRM_AMD_DC)
-	if (amdgpu_device_has_dc_support(adev))
+	if (adev->dc_enabled)
 		dtn_debugfs_init(adev);
 #endif
 
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4404,25 +4404,27 @@ int amdgpu_device_resume(struct drm_devi
 
 	amdgpu_ras_resume(adev);
 
-	/*
-	 * Most of the connector probing functions try to acquire runtime pm
-	 * refs to ensure that the GPU is powered on when connector polling is
-	 * performed. Since we're calling this from a runtime PM callback,
-	 * trying to acquire rpm refs will cause us to deadlock.
-	 *
-	 * Since we're guaranteed to be holding the rpm lock, it's safe to
-	 * temporarily disable the rpm helpers so this doesn't deadlock us.
-	 */
+	if (adev->mode_info.num_crtc) {
+		/*
+		 * Most of the connector probing functions try to acquire runtime pm
+		 * refs to ensure that the GPU is powered on when connector polling is
+		 * performed. Since we're calling this from a runtime PM callback,
+		 * trying to acquire rpm refs will cause us to deadlock.
+		 *
+		 * Since we're guaranteed to be holding the rpm lock, it's safe to
+		 * temporarily disable the rpm helpers so this doesn't deadlock us.
+		 */
 #ifdef CONFIG_PM
-	dev->dev->power.disable_depth++;
+		dev->dev->power.disable_depth++;
 #endif
-	if (!amdgpu_device_has_dc_support(adev))
-		drm_helper_hpd_irq_event(dev);
-	else
-		drm_kms_helper_hotplug_event(dev);
+		if (!adev->dc_enabled)
+			drm_helper_hpd_irq_event(dev);
+		else
+			drm_kms_helper_hotplug_event(dev);
 #ifdef CONFIG_PM
-	dev->dev->power.disable_depth--;
+		dev->dev->power.disable_depth--;
 #endif
+	}
 	adev->in_suspend = false;
 
 	if (adev->enable_mes)
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -534,7 +534,7 @@ uint32_t amdgpu_display_supported_domain
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_has_dc_support(adev) &&
+	    adev->dc_enabled &&
 	    adev->mode_info.gpu_vm_support)
 		domain |= AMDGPU_GEM_DOMAIN_GTT;
 #endif
@@ -1330,7 +1330,7 @@ int amdgpu_display_modeset_create_props(
 					 "dither",
 					 amdgpu_dither_enum_list, sz);
 
-	if (amdgpu_device_has_dc_support(adev)) {
+	if (adev->dc_enabled) {
 		adev->mode_info.abm_level_property =
 			drm_property_create_range(adev_to_drm(adev), 0,
 						  "abm level", 0, 4);
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2530,7 +2530,7 @@ static int amdgpu_runtime_idle_check_dis
 		if (ret)
 			return ret;
 
-		if (amdgpu_device_has_dc_support(adev)) {
+		if (adev->dc_enabled) {
 			struct drm_crtc *crtc;
 
 			drm_for_each_crtc(crtc, drm_dev) {
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4842,6 +4842,7 @@ static int dm_early_init(void *handle)
 		adev_to_drm(adev)->dev,
 		&dev_attr_s3_debug);
 #endif
+	adev->dc_enabled = true;
 
 	return 0;
 }
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1567,7 +1567,7 @@ static void pp_pm_compute_clocks(void *h
 	struct pp_hwmgr *hwmgr = handle;
 	struct amdgpu_device *adev = hwmgr->adev;
 
-	if (!amdgpu_device_has_dc_support(adev)) {
+	if (!adev->dc_enabled) {
 		amdgpu_dpm_get_active_displays(adev);
 		adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
 		adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);



