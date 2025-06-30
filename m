Return-Path: <stable+bounces-158947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C130DAEDD56
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 14:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C62188FCC9
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736102868A2;
	Mon, 30 Jun 2025 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k1uabQKW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A51DF974
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287506; cv=none; b=CKjOV0jZbOmJacg9sjgU6AFT40XHh4H73ZZl8rBqdcdqE3ljRUe7A5aBWpC/wmIXhkaTs4eV6HCgdZi5v8kNWPFRw6oeycGbk4nesRVZr6sutUUWKl6UEscO9k+q5wdj53odLqWa0xX6Fi+G8mNHFsmMO9YGAOtK3A0JslEBE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287506; c=relaxed/simple;
	bh=RIZqBShKsR1AvBnUJeE8N6v9+G6NwPNre/tTkQkhIBg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dsNScjNjSDwT5fUu2NbdFdwdI1fsX8jjwOncZ/bQfNDenYqHO/fvLIM1A75+fFXgtonZ9oq4SyhjYdG7v7b4YoYs5ncTAABomV20YNKrbc1QOQTS0+zdRxD28KIaKDsCAgq2lvkFHock7CgE8o6lP8/qQJgThpKIfRPwWi5f5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k1uabQKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F243C4CEE3;
	Mon, 30 Jun 2025 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751287505;
	bh=RIZqBShKsR1AvBnUJeE8N6v9+G6NwPNre/tTkQkhIBg=;
	h=Subject:To:Cc:From:Date:From;
	b=k1uabQKWmOju7WjGygvHqj8WmBzvoysBriwAu2DrEIienNRP9zWuhd+qcyKK2+E6G
	 +/b0I/T5rBXl3q3MmrIHLOuFprs745UEJoZQ5fV9bPsJo2JAMMqHjhrd6wdqUsA2g4
	 Iiihx0Gpg7DnPZ0LR21eXJxkWw2E2FP4hNG6Kea0=
Subject: FAILED: patch "[PATCH] drm/amd/display: Only read ACPI backlight caps once" failed to apply to 6.15-stable tree
To: mario.limonciello@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,roman.li@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 14:45:02 +0200
Message-ID: <2025063002-talcum-exclusion-49fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x ffcaed1d7ecef31198000dfbbea791f30f7ca437
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063002-talcum-exclusion-49fc@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ffcaed1d7ecef31198000dfbbea791f30f7ca437 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 29 May 2025 11:33:44 -0500
Subject: [PATCH] drm/amd/display: Only read ACPI backlight caps once

[WHY]
Backlight caps are read already in amdgpu_dm_update_backlight_caps().
They may be updated by update_connector_ext_caps(). Reading again when
registering backlight device may cause wrong values to be used.

[HOW]
Use backlight caps already registered to the dm.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 148144f6d2f14b02eaaa39b86bbe023cbff350bd)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d3100f641ac6..0b5d5ab14a69 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4908,7 +4908,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	struct drm_device *drm = aconnector->base.dev;
 	struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
 	struct backlight_properties props = { 0 };
-	struct amdgpu_dm_backlight_caps caps = { 0 };
+	struct amdgpu_dm_backlight_caps *caps;
 	char bl_name[16];
 	int min, max;
 
@@ -4922,20 +4922,20 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		return;
 	}
 
-	amdgpu_acpi_get_backlight_caps(&caps);
-	if (caps.caps_valid && get_brightness_range(&caps, &min, &max)) {
+	caps = &dm->backlight_caps[aconnector->bl_idx];
+	if (get_brightness_range(caps, &min, &max)) {
 		if (power_supply_is_system_supplied() > 0)
-			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps.ac_level, 100);
+			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps->ac_level, 100);
 		else
-			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps.dc_level, 100);
+			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps->dc_level, 100);
 		/* min is zero, so max needs to be adjusted */
 		props.max_brightness = max - min;
 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
-			caps.ac_level, caps.dc_level);
+			caps->ac_level, caps->dc_level);
 	} else
 		props.brightness = AMDGPU_MAX_BL_LEVEL;
 
-	if (caps.data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
+	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
 		drm_info(drm, "Using custom brightness curve\n");
 	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;


