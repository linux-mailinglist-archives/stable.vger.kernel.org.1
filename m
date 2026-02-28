Return-Path: <stable+bounces-220031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMeBLZxBomlz1QQAu9opvQ
	(envelope-from <stable+bounces-220031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 02:15:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B1C1BFAA8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 02:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C2CF3175ADF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 01:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736802ED17B;
	Sat, 28 Feb 2026 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIfN90wo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC22E6CDF
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241158; cv=none; b=XSHhTZOqh1T+LUAOn4nfbi7RIBToW0bCAmqc1Yfb9l5Ue6YpIrXecfDK0V79QUjXNqgZvLBwYrkD0do3drdNCdP3efBSJEtef2nJuaChw32AzNC9drdBDDEIB0GJ+D4OcTgFFR3KaM6zEBGBYMs5xxibb9qBbRfz1HQ2NcKYghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241158; c=relaxed/simple;
	bh=/2IufbmKgS8EWPwFqYgpHFq+mUhoBXzmJsBRcVZFpMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAkQXKGkq0y8sD9NeSo1NJFvnNQqqIevOoUnsd3q3lvErVivqm5IMARv2rhBIqRdV51qpSdNFjObHu6iatV/Wr9P7kTUY6KImYYtTaXgjns+dg9k9ibnaDnzYlPQIR1eZfX4BtE3ZxPAqeJ3eyMEeqwj0X19TeFvAqTebxpxCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIfN90wo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2add623cb27so17707235ad.3
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 17:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772241156; x=1772845956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7pjsQqLYlC7MiskgqQ4KF6moeG8nJU49gJ0m6tNxws=;
        b=FIfN90wog8N3TxFZVJK/OTJjyvjI/sRwUBh1pVhgSEjwav6YNSI5Kjmjjvd4Vdov7z
         TluDmDq9Z77FO9ouLJ1n9dyed6ZLwzQEyKZXcu57rwQeJ8/8jglMPTDaqZtbl0tPMRrZ
         DOM+IIRqso0Ec6SF92PQk3lBMNms3sQDfpLkp+hDbyqFFq/6d4y6kUKIVYz27G/0SPJO
         UP3xMtqGwk5pB+wP4iQnENjYVY5uH6yX751Oxrx5zTotY4uuNcLN5hheKXgWLzzcgtb3
         VHwNwta4Lz8Tu7mGE2vkpth1ie1wvgoqi+MKB/TD0vUsGBTMSEXHmaQFtAF3JRcUeBTz
         b3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772241156; x=1772845956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T7pjsQqLYlC7MiskgqQ4KF6moeG8nJU49gJ0m6tNxws=;
        b=KNxuFwOdU2mkXe5nsAvwQPCGhnNA3WEc95+CDm4qGNyJoKb/6UElsVNJfxgW6C/MsA
         CU/IPTk0+OhbH0xr221Cx/r1acOAtsl16CpycJyhFj82UV6gIB2ShVonzm2rIG+mcB6K
         oFWkDD8AosaqYoEiW1N5lnLncOtTqOnkpdLWtrEMs+UBll2D1UY7sYkCRnthOfIYE4rH
         7M7mBmwijJ/rUOjaR7UwZ/cIfR4RJTnRmgr2VHoUpR1xghNrHP6G+PEl9HHujhgkZ179
         29Gk0gvz7fhNWghu6V2ZTHnVm1+siihSOFdG3Au1GScHztlkJhKZ+r3JYfW6kAwt302s
         iS/w==
X-Gm-Message-State: AOJu0YwfMab1cQLqrYJjOvRIqcVH4mjcPvCpPOlxU3yRi3Rbe8iqVo3K
	9RipHqr2NzlkDZ0YEKOeus7uRy5923nRQas9+XJjx42rTEeBqv4/sf9WnlHtD9musiY=
X-Gm-Gg: ATEYQzweIrPJkOP2PCX22pRn8A+FhZxyju2GQYHopC6t0/40RD99t9KW2pbuIyddq2b
	umlRu92Yg2LZj0Tz1BzU023b+QvfZeaQcqUrfFu3Okrerj+63teB+8eM3esgXKIN/ATiCXskI+U
	ein9uHaztDgEFrONUllwQywjWImHNrahJ5brhWssd7GLfiz4BmA2d81plqBaxA6xy1A2walyYwA
	IAr77vHwRYuJboDPZL217zvOmqGUXi8yQ5QLpYdrVex1s+N7QYFnyLBL8gpy+Y6FjMkOQGBfoQL
	9jpIW/mSYxOC0k9bc3WO+XuQQpZds0KklIuCrf5rpamLkPooq8y9RpGN/MJNGSR3K0C2/1CP99x
	yJSyjkyPBRsRY8PtXpcTwb33hU1Dt7gzlkMIFHHQe2uWk4xVfXMdCY8S+upikDR3azlCyCEZZ1t
	hQUIFQHx9JsIpKLqSym0aOOSSr81wH2izEm8ErB/U8fpBxsoH0TZCT6Q==
X-Received: by 2002:a17:902:e84f:b0:2a9:62ce:1c0c with SMTP id d9443c01a7336-2ae2e251993mr44077005ad.6.1772241155506;
        Fri, 27 Feb 2026 17:12:35 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f46c2sm75772845ad.89.2026.02.27.17.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 17:12:34 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Evan Quan <evan.quan@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Eliav Farber <farbere@amazon.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Ma Jun <Jun.Ma2@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhigang Luo <Zhigang.Luo@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.1 2/2] drm/amdgpu: clarify DC checks
Date: Fri, 27 Feb 2026 17:12:13 -0800
Message-ID: <20260228011213.423524-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228011213.423524-1-rosenp@gmail.com>
References: <20260228011213.423524-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220031-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,kernel.org,amazon.com,linuxfoundation.org,web.de,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 19B1C1BFAA8
X-Rspamd-Action: no action

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit d09ef243035b75a6d403ebfeb7e87fa20d7e25c6 ]

There are several places where we don't want to check
if a particular asic could support DC, but rather, if
DC is enabled.  Set a flag if DC is enabled and check
for that rather than if a device supports DC or not.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 32 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  2 +-
 8 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dcb5de01a220..c4287e09658f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1071,6 +1071,7 @@ struct amdgpu_device {
 	struct work_struct		reset_work;
 
 	bool                            job_hang;
+	bool                            dc_enabled;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 5fa7f6d8aa30..9ced0c60ec8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -857,7 +857,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 
 	if (atif->notifications.brightness_change) {
-		if (amdgpu_device_has_dc_support(adev)) {
+		if (adev->dc_enabled) {
 #if defined(CONFIG_DRM_AMD_DC)
 			struct amdgpu_display_manager *dm = &adev->dm;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3cca3f07f34d..11bfbf1d6a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1981,7 +1981,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	amdgpu_ta_if_debugfs_init(adev);
 
 #if defined(CONFIG_DRM_AMD_DC)
-	if (amdgpu_device_has_dc_support(adev))
+	if (adev->dc_enabled)
 		dtn_debugfs_init(adev);
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 535cc74c5880..a43f18defa7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4402,25 +4402,27 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 98cce09684f2..f9692e724409 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -534,7 +534,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_has_dc_support(adev) &&
+	    adev->dc_enabled &&
 	    adev->mode_info.gpu_vm_support)
 		domain |= AMDGPU_GEM_DOMAIN_GTT;
 #endif
@@ -1330,7 +1330,7 @@ int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
 					 "dither",
 					 amdgpu_dither_enum_list, sz);
 
-	if (amdgpu_device_has_dc_support(adev)) {
+	if (adev->dc_enabled) {
 		adev->mode_info.abm_level_property =
 			drm_property_create_range(adev_to_drm(adev), 0,
 						  "abm level", 0, 4);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 055e05b2cb22..3c01bb464248 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2530,7 +2530,7 @@ static int amdgpu_runtime_idle_check_display(struct device *dev)
 		if (ret)
 			return ret;
 
-		if (amdgpu_device_has_dc_support(adev)) {
+		if (adev->dc_enabled) {
 			struct drm_crtc *crtc;
 
 			drm_for_each_crtc(crtc, drm_dev) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f7fbc7932bb5..0d41a13c9019 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4842,6 +4842,7 @@ static int dm_early_init(void *handle)
 		adev_to_drm(adev)->dev,
 		&dev_attr_s3_debug);
 #endif
+	adev->dc_enabled = true;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index ab8ae7464664..9bf85ca607c3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1567,7 +1567,7 @@ static void pp_pm_compute_clocks(void *handle)
 	struct pp_hwmgr *hwmgr = handle;
 	struct amdgpu_device *adev = hwmgr->adev;
 
-	if (!amdgpu_device_has_dc_support(adev)) {
+	if (!adev->dc_enabled) {
 		amdgpu_dpm_get_active_displays(adev);
 		adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
 		adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
-- 
2.53.0


