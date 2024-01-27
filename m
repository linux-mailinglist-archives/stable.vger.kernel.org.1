Return-Path: <stable+bounces-16175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937B283F18A
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3B6282E94
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574EC200AC;
	Sat, 27 Jan 2024 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0aO6VZbp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18218200A0
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397021; cv=none; b=iqccXGpAXDWbtNb9N9aWdBRT2sVE4Sn/8bkWfTbPaaMdRwUXGbvlQ0Kn5pnPF+u7XmDg7m/sQVLuJyoUMiuBxwf3+m5zRpPhWVii8syqkMVJ+34D7KBWdksY6IGV1vYcl2Tjf3vdpy4h33mFN4WkiDfBMdc7S2UWy/klzsybJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397021; c=relaxed/simple;
	bh=9K/Uk5HCMT9Kf5xwILZQ1dCDNu/DlNq1ZwDE2QsqPkY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pV0jamqusg00So3Ji2najzwml4WZlW4nC6Hm9FwIt/2eHVWjbkaYijVAl6waGBubW7mRbDpikdnGAmpoE/+EzUa5UAM0WKr993vQfi0N7/+iJGjV9k3RFMomBpIuVGEK0WJTI6NGe25YVwPOf0xR0o+bqYQHXzACp6HGYQNliC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0aO6VZbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54C8C433C7;
	Sat, 27 Jan 2024 23:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397020;
	bh=9K/Uk5HCMT9Kf5xwILZQ1dCDNu/DlNq1ZwDE2QsqPkY=;
	h=Subject:To:Cc:From:Date:From;
	b=0aO6VZbpfKC669LBXvao6QjMYo29AeUUixIvAjKrRYDZueUufXGgNPLGsOn/kehs3
	 4iuOSqZTZFkv76RV1bEqogjueZ7Jsve87s1LWdfjYy/XUrVPbMJ4GuC7bpcZGySRJr
	 zW3GMX+R1q5BVMgHJOgcUYytgkj/guI6RHyUgZlM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix sending VSC (+ colorimetry) packets for" failed to apply to 6.6-stable tree
To: joshua@froggi.es,alexander.deucher@amd.com,hamza.mahfooz@amd.com,harry.wentland@amd.com,mwen@igalia.com,simon@berz.me,xaver.hugl@gmail.com,xaver.hugl@kde.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:10:20 -0800
Message-ID: <2024012719-tightness-crested-0fe3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 30afdffb3f600d8fd1d5afa1b7187081e1ac85be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012719-tightness-crested-0fe3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

30afdffb3f60 ("drm/amd/display: Fix sending VSC (+ colorimetry) packets for DP/eDP displays without PSR")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30afdffb3f600d8fd1d5afa1b7187081e1ac85be Mon Sep 17 00:00:00 2001
From: Joshua Ashton <joshua@froggi.es>
Date: Mon, 1 Jan 2024 18:28:22 +0000
Subject: [PATCH] drm/amd/display: Fix sending VSC (+ colorimetry) packets for
 DP/eDP displays without PSR

The check for sending the vsc infopacket to the display was gated behind
PSR (Panel Self Refresh) being enabled.

The vsc infopacket also contains the colorimetry (specifically the
container color gamut) information for the stream on modern DP.

PSR is typically only supported on mobile phone eDP displays, thus this
was not getting sent for typical desktop monitors or TV screens.

This functionality is needed for proper HDR10 functionality on DP as it
wants BT2020 RGB/YCbCr for the container color space.

Cc: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>
Cc: Melissa Wen <mwen@igalia.com>
Fixes: 15f9dfd545a1 ("drm/amd/display: Register Colorspace property for DP and HDMI")
Tested-by: Simon Berz <simon@berz.me>
Tested-by: Xaver Hugl <xaver.hugl@kde.org>
Signed-off-by: Joshua Ashton <joshua@froggi.es>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d869d0d7bf4c..d9729cf5ceea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6236,8 +6236,9 @@ create_stream_for_sink(struct drm_connector *connector,
 
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
-
-	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
+	else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
+			 stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
+			 stream->signal == SIGNAL_TYPE_EDP) {
 		//
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
@@ -6253,8 +6254,9 @@ create_stream_for_sink(struct drm_connector *connector,
 		if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
 			tf = TRANSFER_FUNC_GAMMA_22;
 		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
-		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 
+		if (stream->link->psr_settings.psr_feature_enabled)
+			aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 	}
 finish:
 	dc_sink_release(sink);
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 84f9b412a4f1..738ee763f24a 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -147,12 +147,15 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	}
 
 	/* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
-	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
-		vsc_packet_revision = vsc_packet_rev4;
-	else if (stream->link->replay_settings.config.replay_supported)
+	if (stream->link->psr_settings.psr_feature_enabled) {
+		if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+			vsc_packet_revision = vsc_packet_rev4;
+		else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
+			vsc_packet_revision = vsc_packet_rev2;
+	}
+
+	if (stream->link->replay_settings.config.replay_supported)
 		vsc_packet_revision = vsc_packet_rev4;
-	else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
-		vsc_packet_revision = vsc_packet_rev2;
 
 	/* Update to revision 5 for extended colorimetry support */
 	if (stream->use_vsc_sdp_for_colorimetry)


