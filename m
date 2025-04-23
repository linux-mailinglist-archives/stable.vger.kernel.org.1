Return-Path: <stable+bounces-135835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B460A99056
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A9B167F23
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F13E28A3F8;
	Wed, 23 Apr 2025 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JfcMkkWV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729228A1FD;
	Wed, 23 Apr 2025 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420968; cv=none; b=LuWljIRDI2B4DaYLVI9L8Mg377lxJkGgHAIMBp+HgX8TO7DP/HaeOhb7gXw84nhdVq7mOYVSollHb2Vw5Qt/y8von3mK48cl78aPJoABIBWDfiv8kIUGRytfETgBzeClJZmhJXHyrfYOLds/zsyjud7g8F6xefKFWWHgK18jQR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420968; c=relaxed/simple;
	bh=AA0h21vWcdv/q1UVKGkIxLp99nqsS/G0Goaz8mNsNTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnqO8G4Qgz0mR30+7w6xsmxnnAgaBzkwKOS7TCBvnDlbXUfPjV8lE6xHo6ZtTuDgwnBKfhPhKbIAhjjMsIKH7nWTG3+tN7LCuWW6lAG5Exs3abXQ0lYIr3THTeaF5Z2Cx41bAjX/nvRi85EAgUUZePFigqhtp4Sxa2x0DmzkX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JfcMkkWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE7AC4CEE2;
	Wed, 23 Apr 2025 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420968;
	bh=AA0h21vWcdv/q1UVKGkIxLp99nqsS/G0Goaz8mNsNTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JfcMkkWV0FYbkeqfoemKXHjxM8i+Jb3bV/vpgYcpUWHxRWIm9y9K1ZZ1T1c4zonyr
	 6llc3GvKngYZenjPA7ntlMBDTxrWPDc8p8FEOEF3rfwXgUWugfX/Ptv8uFcyZnjPKH
	 RHeyjrfgHLF4AoejsKaG5307kKgmViZvdX9YfH9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sun peng Li <sunpeng.li@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Fangzhi Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 178/223] drm/amd/display: Do not enable Replay and PSR while VRR is on in amdgpu_dm_commit_planes()
Date: Wed, 23 Apr 2025 16:44:10 +0200
Message-ID: <20250423142624.422221831@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Chung <chiahsuan.chung@amd.com>

commit 69a46ce1f15b4391c128d581f6936750f9bfa052 upstream.

[Why]
Replay and PSR will cause some video corruption while VRR is enabled.

[How]
Do not enable the Replay and PSR while VRR is active in
amdgpu_dm_enable_self_refresh().

Fixes: 67edb81d6e9a ("drm/amd/display: Disable replay and psr while VRR is enabled")
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 36a830a7440f..87058271b00c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -113,6 +113,7 @@ bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state)
  *
  * Panel Replay and PSR SU
  * - Enable when:
+ *      - VRR is disabled
  *      - vblank counter is disabled
  *      - entry is allowed: usermode demonstrates an adequate number of fast
  *        commits)
@@ -131,19 +132,20 @@ static void amdgpu_dm_crtc_set_panel_sr_feature(
 	bool is_sr_active = (link->replay_settings.replay_allow_active ||
 				 link->psr_settings.psr_allow_active);
 	bool is_crc_window_active = false;
+	bool vrr_active = amdgpu_dm_crtc_vrr_active_irq(vblank_work->acrtc);
 
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 	is_crc_window_active =
 		amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base);
 #endif
 
-	if (link->replay_settings.replay_feature_enabled &&
+	if (link->replay_settings.replay_feature_enabled && !vrr_active &&
 		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
 		amdgpu_dm_replay_enable(vblank_work->stream, true);
 	} else if (vblank_enabled) {
 		if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 && is_sr_active)
 			amdgpu_dm_psr_disable(vblank_work->stream, false);
-	} else if (link->psr_settings.psr_feature_enabled &&
+	} else if (link->psr_settings.psr_feature_enabled && !vrr_active &&
 		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
 
 		struct amdgpu_dm_connector *aconn =
-- 
2.49.0




