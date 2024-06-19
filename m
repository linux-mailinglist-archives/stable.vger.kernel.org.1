Return-Path: <stable+bounces-53772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C0B90E61A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863E2283452
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204A37B3E5;
	Wed, 19 Jun 2024 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bjtHEY1s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566E71743
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786407; cv=none; b=cPIhObmVPUgIc+5rR2tpOlRaftIXrJSl8NYhkmMht/ci8udCyKkgx8My+50+cldCS4Jwhst+otmi3VGZEqLWEjJONWdxTII7B65YNeS+JUU7C3HKUwqDKYU6WiPupoUBbCTHWa7ueFudp9vgUKKDUCygUyiVzp+SrWYc7mq6Ui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786407; c=relaxed/simple;
	bh=AwvwZGV1Ro27NZIKUvBUPxFRZTri6ALBgg8gPXBTuUs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j2E+nhJWTXS32/yIIP6rJ4bW5nUvKfP1sSGPQjltIEuA9+p8+A0/kPlDmT4ZqOtmq4pLzU7Oqun+UMpkveGTG8ery/nZdwl7sCtQp5kszdP8dJu3qCzMn0XZF6RaraRwS4Xygb/V9C+bfb6FuWYoKkAmpYFJ73MDLQpS1P3obXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bjtHEY1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8E6C2BBFC;
	Wed, 19 Jun 2024 08:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786407;
	bh=AwvwZGV1Ro27NZIKUvBUPxFRZTri6ALBgg8gPXBTuUs=;
	h=Subject:To:Cc:From:Date:From;
	b=bjtHEY1sWUgwIi+oC0Jgxz6zjah2vFDQ2kKfH3UoABHbjkm6ZZMGiOJ2b/XRk8L9i
	 Zcqg7t4R1zWz0DjIjDP++f35eqn9+aCn2h21yRML7DIxVl9Jn3Ix2w9nEhZbxF8W2X
	 zN6UfvtYbbWDuUPl2s+dDGJjFEpVAhYIspJZYAII=
Subject: FAILED: patch "[PATCH] drm/amd/display: Program VSC SDP colorimetry for all DP sinks" failed to apply to 5.10-stable tree
To: harry.wentland@amd.com,Agustin.Gutierrez@amd.com,agustin.gutierrez@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,joshua@froggi.es,mwen@igalia.com,xaver.hugl@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:39:18 +0200
Message-ID: <2024061918-native-refurnish-9161@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1abfb9f9c767ca4c98c12ba2754abfe3ecf5ce8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061918-native-refurnish-9161@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

1abfb9f9c767 ("drm/amd/display: Program VSC SDP colorimetry for all DP sinks >= 1.4")
5daa29473cf6 ("Revert "drm/amd/display: Fix sending VSC (+ colorimetry) packets for DP/eDP displays without PSR"")
30afdffb3f60 ("drm/amd/display: Fix sending VSC (+ colorimetry) packets for DP/eDP displays without PSR")
81a7be799af7 ("drm/amd/display: Update adaptive sync infopackets for replay")
5b49da02ddbe ("drm/amd/display: Enable Freesync over PCon")
e95afc1cf7c6 ("drm/amd/display: Enable AdaptiveSync in DC interface")
028c4ccfb812 ("drm/amd/display: force connector state when bpc changes during compliance")
d5a43956b73b ("drm/amd/display: move dp capability related logic to link_dp_capability")
94dfeaa46925 ("drm/amd/display: move dp phy related logic to link_dp_phy")
630168a97314 ("drm/amd/display: move dp link training logic to link_dp_training")
238debcaebe4 ("drm/amd/display: Use DML for MALL SS and Subvp allocation calculations")
d144b40a4833 ("drm/amd/display: move dc_link_dpia logic to link_dp_dpia")
a28d0bac0956 ("drm/amd/display: move dpcd logic from dc_link_dpcd to link_dpcd")
a98cdd8c4856 ("drm/amd/display: refactor ddc logic from dc_link_ddc to link_ddc")
4370f72e3845 ("drm/amd/display: refactor hpd logic from dc_link to link_hpd")
0e8cf83a2b47 ("drm/amd/display: allow hpo and dio encoder switching during dp retrain test")
7462475e3a06 ("drm/amd/display: move dccg programming from link hwss hpo dp to hwss")
e85d59885409 ("drm/amd/display: use encoder type independent hwss instead of accessing enc directly")
ebf13b72020a ("drm/amd/display: Revert Scaler HCBlank issue workaround")
639f6ad6df7f ("drm/amd/display: Revert Reduce delay when sink device not able to ACK 00340h write")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1abfb9f9c767ca4c98c12ba2754abfe3ecf5ce8c Mon Sep 17 00:00:00 2001
From: Harry Wentland <harry.wentland@amd.com>
Date: Tue, 12 Mar 2024 11:55:52 -0400
Subject: [PATCH] drm/amd/display: Program VSC SDP colorimetry for all DP sinks
 >= 1.4

In order for display colorimetry to work correctly on DP displays
we need to send the VSC SDP packet. We should only do so for
panels with DPCD revision greater or equal to 1.4 as older
receivers might have problems with it.

Cc: stable@vger.kernel.org
Cc: Joshua Ashton <joshua@froggi.es>
Cc: Xaver Hugl <xaver.hugl@gmail.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Agustin Gutierrez <Agustin.Gutierrez@amd.com>
Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e80a75312cf7..7b016a2125e0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6326,7 +6326,9 @@ create_stream_for_sink(struct drm_connector *connector,
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
 
-	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
+	    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
+	    stream->signal == SIGNAL_TYPE_EDP) {
 		//
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
@@ -6336,7 +6338,8 @@ create_stream_for_sink(struct drm_connector *connector,
 			stream->use_vsc_sdp_for_colorimetry =
 				aconnector->dc_sink->is_vsc_sdp_colorimetry_supported;
 		} else {
-			if (stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
+			if (stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
+			    stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
 				stream->use_vsc_sdp_for_colorimetry = true;
 		}
 		if (stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22)


