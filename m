Return-Path: <stable+bounces-135738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C6A99024
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CFF1B81980
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE69628C5D2;
	Wed, 23 Apr 2025 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w+v7HWA/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C020284685;
	Wed, 23 Apr 2025 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420714; cv=none; b=nRD1btkrHC2qMBHhA7CJIMZ1Vq190/l/4POb2AzFBWx8g/QZwGmAkUrSL8Gi8dd6k7Z6ZIU/HKdXLdpfB56I8lSZzhNY4jX++5UnAI1kDXVimCqhjX49muyfW5ReYrWnWoO/WXW25kY+kvVItURzQmZs2NhdYzFTA8QNJnNC218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420714; c=relaxed/simple;
	bh=01c5D9dN3os3ACO8eB1Mt5pka4h8+6Hfjb1KaG9qMZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajc5sQzhlLWBgYZ3OQZm0WUHLochTMwqJ/OChOs3irkgufVgMN9ATWo4g5ue7w4H3Ne8INw9/2UwDiF97O815eLXAi3k8NQ9P9X6DwnavdaeNZ8NMef/4gE/b89eo/pJPcg1XHRxM4n0OMLDg47VKbbhfMigbeV7v7RnKxmayIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w+v7HWA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3F0C4CEE2;
	Wed, 23 Apr 2025 15:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420713;
	bh=01c5D9dN3os3ACO8eB1Mt5pka4h8+6Hfjb1KaG9qMZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w+v7HWA//S/9fVpwHBwFrAieFsdhiKxeYN7GJbS67UjDwULbUoUgoJLmaT29fjjxS
	 uU18ZITQskkL4SqDYtpMC3LArKHUnXRyYqu8QAdCBht2WQ2oLTMLZpGlQybJJhycHD
	 co3+mRng3/FRdd2pxBsK7gQ2T/0e1sNNxb55K1ag=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 156/223] drm/amd/display: Increase vblank offdelay for PSR panels
Date: Wed, 23 Apr 2025 16:43:48 +0200
Message-ID: <20250423142623.527793928@linuxfoundation.org>
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

From: Leo Li <sunpeng.li@amd.com>

commit f21e6d149b49c92f9e68aa0c76033e1e13d9f5da upstream.

[Why]

Depending on when the HW latching event (vupdate) of double-buffered
registers happen relative to the PSR SDP (signals panel psr enter/exit)
deadline, and how bad the Panel clock has drifted since the last ALPM
off event, there can be up to 3 frames of delay between sending the PSR
exit cmd to DMUB fw, and when the panel starts displaying live frames.
This can manifest as micro-stuttering when userspace commit patterns
cause rapid toggling of the DRM vblank counter, since PSR enter/exit is
hooked up to DRM vblank disable/enable respectively.

In the ideal world, the panel should present the live frame immediately
on PSR exit cmd. But due to HW design and PSR limitations, immediate
exit can only happen by chance, when:

1. PSR exit cmd is ack'd by FW before HW latching (vupdate) event, and
2. Panel's SDP deadline -- determined by it's PSR Start Delay in DPCD
  71h -- is after the vupdate event. The PSR exit SDP can then be sent
  immediately after HW latches. Otherwise, we have to wait 1 frame. And
3. There is negligible drift between the panel's clock and source clock.
  Otherwise, there can be up to 1 frame of drift.

Note that this delay is not expected with Panel Replay.

[How]

Since PSR power savings can be quite substantial, and there are a lot of
systems in the wild with PSR panels, It'll be nice to have a middle
ground that balances user experience with power savings.

A simple way to achieve this is by extending the vblank offdelay, such
that additional PSR exit delays will be less perceivable.

We can set:

   20/100 * offdelay_ms = 3_frames_ms
=> offdelay_ms = 5 * 3_frames_ms

This ensures that `3_frames_ms` will only be experienced as a 20% delay
on top how long the panel has been static, and thus make the delay
less perceivable.

If this ends up being too high of a percentage, it can be dropped
further in a future change.

Fixes: 537ef0f88897 ("drm/amd/display: use new vblank enable policy for DCN35+")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   39 ++++++++++++++++++----
 1 file changed, 32 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8458,14 +8458,39 @@ static void manage_dm_interrupts(struct
 	int offdelay;
 
 	if (acrtc_state) {
-		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
-		    IP_VERSION(3, 5, 0) ||
-		    acrtc_state->stream->link->psr_settings.psr_version <
-		    DC_PSR_VERSION_UNSUPPORTED ||
-		    !(adev->flags & AMD_IS_APU)) {
-			timing = &acrtc_state->stream->timing;
+		timing = &acrtc_state->stream->timing;
 
-			/* at least 2 frames */
+		/*
+		 * Depending on when the HW latching event of double-buffered
+		 * registers happen relative to the PSR SDP deadline, and how
+		 * bad the Panel clock has drifted since the last ALPM off
+		 * event, there can be up to 3 frames of delay between sending
+		 * the PSR exit cmd to DMUB fw, and when the panel starts
+		 * displaying live frames.
+		 *
+		 * We can set:
+		 *
+		 * 20/100 * offdelay_ms = 3_frames_ms
+		 * => offdelay_ms = 5 * 3_frames_ms
+		 *
+		 * This ensures that `3_frames_ms` will only be experienced as a
+		 * 20% delay on top how long the display has been static, and
+		 * thus make the delay less perceivable.
+		 */
+		if (acrtc_state->stream->link->psr_settings.psr_version <
+		    DC_PSR_VERSION_UNSUPPORTED) {
+			offdelay = DIV64_U64_ROUND_UP((u64)5 * 3 * 10 *
+						      timing->v_total *
+						      timing->h_total,
+						      timing->pix_clk_100hz);
+			config.offdelay_ms = offdelay ?: 30;
+		} else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
+			   IP_VERSION(3, 5, 0) ||
+			   !(adev->flags & AMD_IS_APU)) {
+			/*
+			 * Older HW and DGPU have issues with instant off;
+			 * use a 2 frame offdelay.
+			 */
 			offdelay = DIV64_U64_ROUND_UP((u64)20 *
 						      timing->v_total *
 						      timing->h_total,



