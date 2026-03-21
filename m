Return-Path: <stable+bounces-227659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOpBCrEwvmmqIwMAu9opvQ
	(envelope-from <stable+bounces-227659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:46:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A80342E3762
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F57930490C4
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 05:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9C366056;
	Sat, 21 Mar 2026 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrN4jT0D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A386366DB9
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 05:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774071918; cv=none; b=IYRtLD30gOLoeRIFodjehAvpObtZSMO33UnBsbOvZNTsfuSZDWICzw8jV8YN3Gruk4DTLRyR+qjXUTwDPf+1/ljgntbndDZJpZyT4EMAgi8hbHQ7IqDVbrcCPwsw82VFESK/Gga0PHoiKlB24DCTzjlldgJd6Oc4/OmDlRS8MsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774071918; c=relaxed/simple;
	bh=35+bFeOfe5NktlfXTSheef9StWYURJLfz5EMeTRV9oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCwJ/RrTvrfnD86i9bfxBtVs9/CM5Vrapu47Sm2k+GZmge/D/FgBMuSUERgLaxEZz0AjOYQwZVRRtQgE/CXHQynIZKXUIAH37/OVXNs80kIoRCQ/X4JILBpKSUSPGtiL1hILjVOHytLNSoWZVA5ul7e/5MmCftOloSfjcxdEdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrN4jT0D; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-823c56765fdso1458635b3a.1
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 22:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774071916; x=1774676716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FP34IF1NqA/DrYCuAVhgwWOfQKjwg0Ze9v4T9XeI0k=;
        b=GrN4jT0D8t0LXks/ZPsMxBi2X6puSCdqzeg1t2n/yU0x7dg0lbNPADUGY0SUFC79jE
         /4NzaTdvp1w4ew88bGREVqGTOtYDxz072/611n4N9SMbC/I4kpPyV32RiQzSmMmbGHSF
         zluZ+eufbZToHEHZpq3vMPoytkIddTJW5NWH/lOs2HR7q3nWi+WXeAb0GEwMZYrbEtbs
         n9UFoiBF27d+6OQiSy96RnkQeA0inOwZX/PIeb96xnXZ9TF+oOeiX5xPilcnPZsxWry1
         yRwtqM3TVL8JeP+V1N+o1EsakkVKk/R2toERMf1VZoM0NpaI7PMwUeaDRXgsxGT18WrZ
         N6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774071916; x=1774676716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4FP34IF1NqA/DrYCuAVhgwWOfQKjwg0Ze9v4T9XeI0k=;
        b=D0kS+LYWSkWcDccENJwfby5TxqqL/exHc5+wQ6DJ55PcAbP0UcZe34V9rVMueUma5W
         U40/S1WWB0A6ZzvaD41rRyEyTs/W+3sErQ9rdCFFtMYcM3q050jGefBwKMV6IVzfM+0k
         QQBkM7TnOudOJxoXCTBEidSUqmllfJtgZGLC9Lhpre2c/yKDQQS/MJgEBOIqOkBSSMhw
         NRZS5GbZ8MPgR9S3i3eActyi8Ua6EH1h2wA1EMjUuC0Lme3qCH5axmGQMjW0NNtT27x8
         Uu94jT/DC9Eoj7UcWnSWHAFxR4wJTInhsaHTEWPwL5vMu8R4nPDQp5QkIl8n1hKZMgkt
         oikA==
X-Gm-Message-State: AOJu0YwDuWF6pqpYXRtRR7pJ25qRGcBkP1zcEHd+BlDDiZv8cJ0d9Jfq
	OjEnMyCqRb7bBBOS71+DtrO4AR8AVw62kp7Wa9834mfeOGlFMcHY6HOfggfxYXe0
X-Gm-Gg: ATEYQzx7Sv1jJ/pNoBgMKDttBqHzkjdpVipNwRErVboQ+h8yt27FF1IDU9sHl48Tsp5
	YGhpG6y6+yE7iz1z5/cTD0ncBGMES2D/ShaXuYFS85zj5irDEV/YQUATZmKJa1fkmco9oPTLaas
	xxYll9X/YCibAy7B51lazlDBnYpGpX9MUXUUKQrIXX/JB7kayt5J2p4jYeS3YQKZ6VRrPusqQ8x
	DN3u8GEKECRks8Ctruyn2+fpbyXMFocuPTxBmT+MR/RPyVxWmiNsSbjtP58j1scKj3zndEAEpCz
	Py8sdtd3S+eBW3mU2MPyZ8o4kZrK1PCeF4+ZOY48175EOYJVKcgT3//YgnDipJvsE1jOWOVF8LE
	v16nYSLeE5VsMHFn3+PTY255bnz0YNIbHdePNwiXQAJ8n1YMhV4V9sOBxA5a96o+rPUWQfUZVV1
	UIbpu6AYCJ9Gb47Hoq0//UvBNGq0aS+iFPbJwFQ2sS60ba/uH6Bf8Cejw=
X-Received: by 2002:a05:6a00:13a9:b0:81e:6d2d:a121 with SMTP id d2e1a72fcca58-82a8c3c3239mr4749010b3a.62.1774071916251;
        Fri, 20 Mar 2026 22:45:16 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c681sm4338783b3a.37.2026.03.20.22.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:45:15 -0700 (PDT)
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
	Mario Limonciello <mario.limonciello@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Rosen Penev <rosenp@gmail.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Ma Jun <Jun.Ma2@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Zhigang Luo <Zhigang.Luo@amd.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	decce6 <decce6@proton.me>,
	Wentao Liang <vulab@iscas.ac.cn>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 for 6.1 2/4] drm/amdgpu: clarify DC checks
Date: Fri, 20 Mar 2026 22:44:51 -0700
Message-ID: <20260321054453.19683-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321054453.19683-1-rosenp@gmail.com>
References: <20260321054453.19683-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,kernel.org,linuxfoundation.org,web.de,proton.me,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-227659-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email]
X-Rspamd-Queue-Id: A80342E3762
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit d09ef243035b75a6d403ebfeb7e87fa20d7e25c6 ]

There are several places where we don't want to check
if a particular asic could support DC, but rather, if
DC is enabled.  Set a flag if DC is enabled and check
for that rather than if a device supports DC or not.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
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
index 213054071904..7eff2b94ab66 100644
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


