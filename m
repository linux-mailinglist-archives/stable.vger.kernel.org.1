Return-Path: <stable+bounces-110505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA382A1C992
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3803AA023
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9700B198A11;
	Sun, 26 Jan 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvICHWOu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F731662F1;
	Sun, 26 Jan 2025 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903203; cv=none; b=cCoqjQF4qHCu7Wh7yYVqGUd27d6JoxcCV7QFexMYSpKzg4NeCDfV8iB2VtFd7Vif/53Aa1QnB5oE7aM+bp967mKbxzuJHE+FK4OWI8td2E12nRpy0W25uVNjCdvj0Co3NxmsSJDD0oQcU9R5pS9AYdYdyc1VlBPzxAcBd4QbGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903203; c=relaxed/simple;
	bh=lBTWHoEglIg63hLtbb2uN3HE7cH3ANNtDenRKpCKCTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Af3XNLpJJgnqJthygbt9z8KzUp5fraYgWTZA7vOgRVS67NzYj0/zmmjAH23K6eRc3gcO5YXwIUYoqKL6gG6E3tWjfYY9Jl3bs7Q4t16ey56obC0lTzWZfqulUUVBg32DWIh6MIkBm1WUXsmj2uOYQrxzm6lylyipc0FCgBb4JMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvICHWOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C622BC4CEE2;
	Sun, 26 Jan 2025 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903202;
	bh=lBTWHoEglIg63hLtbb2uN3HE7cH3ANNtDenRKpCKCTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvICHWOu1x5687usZoonLfDCucU/BW5nQoPrkVOzdbi2UK0zAkAn+o0r2Zsi14ZFm
	 4B1UpFIcCeR2vrxaQX09tMqPc+gBiSPqQ+iveehjL+PjL3NfXAnXWaGIQ9hzWBx8it
	 74y9fSgBEhrC8QbNc6Il3nTL6bYxy93rsYdr+ngUPxN3k2NwXpYm2H2zRpnWP+zx/i
	 np8zWA4amMT6MXB8tHoRljSejmvBXZAwcJBsDljbNiD6sCJXretlSRuLt6pWIpX3Cj
	 1sk6n4S0/+U2g0yA/jomiV5ypRttz19gPXjTWdBM84bzPX1o4riT6vfIZoFVofJAbj
	 DOstmJCYdcs2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Dustin L . Howett" <dustin@howett.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	mripard@kernel.org,
	geert+renesas@glider.be,
	arnd@arndb.de,
	jani.nikula@intel.com,
	tzimmermann@suse.de,
	dmitry.baryshkov@linaro.org,
	chiahsuan.chung@amd.com,
	hamza.mahfooz@amd.com,
	sunil.khatri@amd.com,
	alex.hung@amd.com,
	aurabindo.pillai@amd.com,
	hersenxs.wu@amd.com,
	mwen@igalia.com,
	Wayne.Lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 03/34] drm/amd/display: Add support for minimum backlight quirk
Date: Sun, 26 Jan 2025 09:52:39 -0500
Message-Id: <20250126145310.926311-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit c2753b2471c65955de18cbc58530641447e5bfe9 ]

Not all platforms provide the full range of PWM backlight capabilities
supported by the hardware through ATIF.
Use the generic drm panel minimum backlight quirk infrastructure to
override the capabilities where necessary.

Testing the backlight quirk together with the "panel_power_savings"
sysfs file has not shown any negative impact.
One quirk seems to be that 0% at panel_power_savings=0 seems to be
slightly darker than at panel_power_savings=4.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Tested-by: Dustin L. Howett <dustin@howett.net>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241111-amdgpu-min-backlight-quirk-v7-2-f662851fda69@weissschuh.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig                | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 41fa3377d9cf5..1a11cab741aca 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -26,6 +26,7 @@ config DRM_AMDGPU
 	select DRM_BUDDY
 	select DRM_SUBALLOC_HELPER
 	select DRM_EXEC
+	select DRM_PANEL_BACKLIGHT_QUIRKS
 	# amdgpu depends on ACPI_VIDEO when ACPI is enabled, for select to work
 	# ACPI_VIDEO's dependencies must also be selected.
 	select INPUT if ACPI
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5f216d626cbb5..d394f758272e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -93,6 +93,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_eld.h>
+#include <drm/drm_utils.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_audio_component.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -3457,6 +3458,7 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	struct drm_connector *conn_base;
 	struct amdgpu_device *adev;
 	struct drm_luminance_range_info *luminance_range;
+	int min_input_signal_override;
 
 	if (aconnector->bl_idx == -1 ||
 	    aconnector->dc_link->connector_signal != SIGNAL_TYPE_EDP)
@@ -3493,6 +3495,10 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 		caps->aux_min_input_signal = 0;
 		caps->aux_max_input_signal = 512;
 	}
+
+	min_input_signal_override = drm_get_panel_min_brightness_quirk(aconnector->drm_edid);
+	if (min_input_signal_override >= 0)
+		caps->min_input_signal = min_input_signal_override;
 }
 
 void amdgpu_dm_update_connector_after_detect(
-- 
2.39.5


