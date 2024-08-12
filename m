Return-Path: <stable+bounces-66711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CCB94F0D2
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434ED1C21F82
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8EE17995B;
	Mon, 12 Aug 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V2DgdCqo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4434B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474494; cv=none; b=Btb6l9PB3aMKsuOWM0GqoIL70szSsy6nIK8IexE4STMyozaED1LB+aoKzwbVVQemEn11qNMdKzUe3P6cfUk/oNMCMPszFzYwgi8hSQEwLaTOinavw6IjvbRFYRdbiZ8bNPI/Ey5LMW6qc9IO2szeeb6dDDLeQ23HPqBV2rZw79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474494; c=relaxed/simple;
	bh=+94zNhvgyPBozuwD80lR3tiYZeyrcCKpIa51ZDBrZrg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OF81ftxocN65PqHBaWOXehfzLHL6/piwyDGHkTo0vmXl5Bv7RADIxIg0iE1YdrrV43j2sYZYwf6E8XSstMjqpAwVG2mU8bSx7Pt0hF59ypwyuQzymIHFUzXUiVNVZXFFWAVeBve9LCvw214Wlpt5NlMZaB5cM65Grt+b9k0gu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V2DgdCqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0D9C32782;
	Mon, 12 Aug 2024 14:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474494;
	bh=+94zNhvgyPBozuwD80lR3tiYZeyrcCKpIa51ZDBrZrg=;
	h=Subject:To:Cc:From:Date:From;
	b=V2DgdCqoUzvQ+nBhLoZOY9kVe8anx/NloEIPsgUxFOmwLeSU7zxPwhwg3QWkP4hwv
	 VdrU3xaiW85CJSpQ9TfpA8sXTcAv9gwPFM6JH1ZV5JRSICzpXmjXRDCDMGLaYvVQ9/
	 L4GsByRazW/6KkcMQ+HNuXp7UuRXDFX9S3Ov/LQE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Change ASSR disable sequence" failed to apply to 6.1-stable tree
To: swapnil.patel@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wayne.lin@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:52:15 +0200
Message-ID: <2024081215-smokiness-displease-771f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2d696cc837eaf5394d79bfd2b0b0483c4778aa83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081215-smokiness-displease-771f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

2d696cc837ea ("drm/amd/display: Change ASSR disable sequence")
1e88eb1b2c25 ("drm/amd/display: Drop CONFIG_DRM_AMD_DC_HDCP")
7ae1dbe6547c ("drm/amd/display: merge dc_link.h into dc.h and dc_types.h")
455ad25997ba ("drm/amdgpu: Select DRM_DISPLAY_HDCP_HELPER in amdgpu")
8e5cfe547bf3 ("drm/amd/display: upstream link_dp_dpia_bw.c")
5ca38a18b5a4 ("drm/amd/display: move public dc link function implementation to dc_link_exports")
54618888d1ea ("drm/amd/display: break down dc_link.c")
71d7e8904d54 ("drm/amd/display: Add HDMI manufacturer OUI and device id read")
65a4cfb45e0e ("drm/amdgpu/display: remove duplicate include header in files")
e322843e5e33 ("drm/amd/display: fix linux dp link lost handled only one time")
0c2bfcc338eb ("drm/amd/display: Add Function declaration in dc_link")
6ca7415f11af ("drm/amd/display: merge dc_link_dp into dc_link")
de3fb390175b ("drm/amd/display: move dp cts functions from dc_link_dp to link_dp_cts")
c5a31f178e35 ("drm/amd/display: move dp irq handler functions from dc_link_dp to link_dp_irq_handler")
e95afc1cf7c6 ("drm/amd/display: Enable AdaptiveSync in DC interface")
0078c924e733 ("drm/amd/display: move eDP panel control logic to link_edp_panel_control")
bc33f5e5f05b ("drm/amd/display: create accessories, hwss and protocols sub folders in link")
2daeb74b7d66 ("drm/amdgpu/display/mst: update mst_mgr relevant variable when long HPD")
028c4ccfb812 ("drm/amd/display: force connector state when bpc changes during compliance")
603a521ec279 ("drm/amd/display: remove duplicate included header files")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2d696cc837eaf5394d79bfd2b0b0483c4778aa83 Mon Sep 17 00:00:00 2001
From: Swapnil Patel <swapnil.patel@amd.com>
Date: Thu, 18 Apr 2024 14:30:39 -0400
Subject: [PATCH] drm/amd/display: Change ASSR disable sequence

[Why]
Currently disabling ASSR before stream is disabled causes visible
display corruption.

[How]
Move disable ASSR command to after stream has been disabled.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 16549068d836..8402ca0695cc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2317,8 +2317,6 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 
 	dc->hwss.disable_audio_stream(pipe_ctx);
 
-	edp_set_panel_assr(link, pipe_ctx, &panel_mode_dp, false);
-
 	update_psp_stream_config(pipe_ctx, true);
 	dc->hwss.blank_stream(pipe_ctx);
 
@@ -2372,6 +2370,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		dc->hwss.disable_stream(pipe_ctx);
 		disable_link(pipe_ctx->stream->link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
 	}
+	edp_set_panel_assr(link, pipe_ctx, &panel_mode_dp, false);
 
 	if (pipe_ctx->stream->timing.flags.DSC) {
 		if (dc_is_dp_signal(pipe_ctx->stream->signal))


