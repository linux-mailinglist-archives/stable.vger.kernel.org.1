Return-Path: <stable+bounces-158951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35277AEDD5C
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 14:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A89517474D
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247BA286D70;
	Mon, 30 Jun 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AWQpjU9g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE9286D59
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287544; cv=none; b=daIJMhrsq1c+orY070WGPvLTCjqF5/iZonAoh69shQW6QYPon4XoqiKGXiB8JWopWYOiK7v31iRIjvvaxa8j4pMljqXyzjfK9VqB75jIGgCuofm5u/p8teSAOkGVlEJVHztSy19N728yljDz/1fEmbAkNtllerMhhK/A425AIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287544; c=relaxed/simple;
	bh=W6i2uTH0WmO/jY9Rsux8RyDmzYugKIYnjVhaJhHL9u4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BGoKjyxM+3ACIg1rrNMITCgZ9wRExN6AowNWgPZIbGTfOAJyKuYj4TsuT0nDkTo3OpZewF8Ts+rGTeXX5dMNG2d2dJi8RBErK+gpNf5YQj9bzvW+CZRIJ9vConfBdxc5E3PegEvGF24OHXM7MXV6C7qpmvUu20mdpjJJAqzDeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AWQpjU9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD863C4CEF0;
	Mon, 30 Jun 2025 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751287543;
	bh=W6i2uTH0WmO/jY9Rsux8RyDmzYugKIYnjVhaJhHL9u4=;
	h=Subject:To:Cc:From:Date:From;
	b=AWQpjU9g8CYJr+P2xV5oAt39jlRUOv0nf3JNU2s815d0g8RZJvKEJW4DymJoEyDi0
	 EJlWTfZJ+eicBh6a4hgMrj3elOIKIGiPRr23tuyEwaESVj8em2CSNbNNKM/wehm2L1
	 VDq+DR+ZpnF7AUy16R68op6yCDFpi5X5VYXZdcO0=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value" failed to apply to 6.15-stable tree
To: mario.limonciello@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 14:45:40 +0200
Message-ID: <2025063040-sanctity-jolly-859c@gregkh>
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
git cherry-pick -x 66abb996999de0d440a02583a6e70c2c24deab45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063040-sanctity-jolly-859c@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 66abb996999de0d440a02583a6e70c2c24deab45 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 23 Jun 2025 12:11:13 -0500
Subject: [PATCH] drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value

[Why]
commit 16dc8bc27c2a ("drm/amd/display: Export full brightness range to
userspace") adjusted the brightness range to scale to larger values, but
missed updating AMDGPU_MAX_BL_LEVEL which is needed to make sure that
scaling works properly with custom brightness curves.

[How]
As the change for max brightness of 0xFFFF only applies to devices
supporting DC, use existing DC define MAX_BACKLIGHT_LEVEL.

Fixes: 16dc8bc27c2a ("drm/amd/display: Export full brightness range to userspace")
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://lore.kernel.org/r/20250623171114.1156451-1-mario.limonciello@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5b852044eb0d3e1f1c946d32e05fcb068e0a20a0)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bc4cd11bfc79..0b8ac9edc070 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4718,16 +4718,16 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	return 1;
 }
 
-/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
+/* Rescale from [min..max] to [0..MAX_BACKLIGHT_LEVEL] */
 static inline u32 scale_input_to_fw(int min, int max, u64 input)
 {
-	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
+	return DIV_ROUND_CLOSEST_ULL(input * MAX_BACKLIGHT_LEVEL, max - min);
 }
 
-/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
+/* Rescale from [0..MAX_BACKLIGHT_LEVEL] to [min..max] */
 static inline u32 scale_fw_to_input(int min, int max, u64 input)
 {
-	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
+	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), MAX_BACKLIGHT_LEVEL);
 }
 
 static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
@@ -4947,7 +4947,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
 			caps->ac_level, caps->dc_level);
 	} else
-		props.brightness = props.max_brightness = AMDGPU_MAX_BL_LEVEL;
+		props.brightness = props.max_brightness = MAX_BACKLIGHT_LEVEL;
 
 	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
 		drm_info(drm, "Using custom brightness curve\n");


