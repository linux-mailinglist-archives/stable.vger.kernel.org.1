Return-Path: <stable+bounces-34190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2D7893E47
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251E4281468
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0E347A53;
	Mon,  1 Apr 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ye961VMo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B14778B;
	Mon,  1 Apr 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987292; cv=none; b=nMFbAliOG3OF1njYa9jGOYIWvuULhKv0f17ppcLpOjPIyV3ovulX3Ebh+Dzrf3S8gH1R7H7G/fR8cn7bteF0D+V7B9phw3a2e86crEb1TxUkttUbRwrBqWf/dH1oO3EZZc2aROCveND+28UkvYoWji9Qse1HKNwVnb8YctXIttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987292; c=relaxed/simple;
	bh=5u+mIuCz6RuLHK4KjhyRilZsnlFvVkndlkcgAMb9Ah8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDP49YNpSoyROUE7IDhONPXuYrwhNMFa2sZ3SrvjOgfrCi9Mg/q0eh3Y9Mn1cX+Rdt/uGg8tS0eCbkW3QVo/c3v+rXZ0/wJfgLJsGrgh7QJZJsIoTp57IC7I2GmR282uK8MDNixNlRPeeHKDGLy4NRlBhz25NelPsX6CsJVGLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ye961VMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFDBC433F1;
	Mon,  1 Apr 2024 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987292;
	bh=5u+mIuCz6RuLHK4KjhyRilZsnlFvVkndlkcgAMb9Ah8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ye961VMovuET196tNwutKpNBKF2c/Zk7nJFxRmfR3jRjA6FGk6zeTcMwVPGo9YLh1
	 nYUjS1iuc0XMl+bN7APk3fbexbvvB7wD2ERv6qazxhXpgmMax11zG/aG8ws+X0RtIc
	 0lmwTwgWuK2Ds4w2Ny00tdzzsnZStEkB64txVrLg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.8 243/399] drm/amd/display: Use freesync when `DRM_EDID_FEATURE_CONTINUOUS_FREQ` found
Date: Mon,  1 Apr 2024 17:43:29 +0200
Message-ID: <20240401152556.428504502@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 2f14c0c8cae8e9e3b603a3f91909baba66540027 upstream.

The monitor shipped with the Framework 16 supports VRR [1], but it's not
being advertised.

This is because the detailed timing block doesn't contain
`EDID_DETAIL_MONITOR_RANGE` which amdgpu looks for to find min and max
frequencies.  This check however is superfluous for this case because
update_display_info() calls drm_get_monitor_range() to get these ranges
already.

So if the `DRM_EDID_FEATURE_CONTINUOUS_FREQ` EDID feature is found then
turn on freesync without extra checks.

v2: squash in fix from Harry

Closes: https://www.reddit.com/r/framework/comments/1b4y2i5/no_variable_refresh_rate_on_the_framework_16_on/
Closes: https://www.reddit.com/r/framework/comments/1b6vzcy/framework_16_variable_refresh_rate/
Closes: https://community.frame.work/t/resolved-no-vrr-freesync-with-amd-version/42338
Link: https://gist.github.com/superm1/e8fbacfa4d0f53150231d3a3e0a13faf
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11140,18 +11140,24 @@ void amdgpu_dm_update_freesync_caps(stru
 	if (!adev->dm.freesync_module)
 		goto update;
 
-	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
-		|| sink->sink_signal == SIGNAL_TYPE_EDP) {
+	if (edid && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
+		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
 		bool edid_check_required = false;
 
-		if (edid) {
-			edid_check_required = is_dp_capable_without_timing_msa(
-						adev->dm.dc,
-						amdgpu_dm_connector);
+		if (is_dp_capable_without_timing_msa(adev->dm.dc,
+						     amdgpu_dm_connector)) {
+			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ) {
+				freesync_capable = true;
+				amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
+				amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
+			} else {
+				edid_check_required = edid->version > 1 ||
+						      (edid->version == 1 &&
+						       edid->revision > 1);
+			}
 		}
 
-		if (edid_check_required == true && (edid->version > 1 ||
-		   (edid->version == 1 && edid->revision > 1))) {
+		if (edid_check_required) {
 			for (i = 0; i < 4; i++) {
 
 				timing	= &edid->detailed_timings[i];



