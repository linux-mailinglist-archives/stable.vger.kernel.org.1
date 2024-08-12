Return-Path: <stable+bounces-66714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C1894F0D5
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E67C281011
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CB817995B;
	Mon, 12 Aug 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EZD2Uhru"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F54B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474504; cv=none; b=G0bPyrvItDMPt3OOkdLQ9qZ5tt5ZNXHYLqeBkdiuwK6GEQ9DwJnoSAP51Z2Wzc/rub3gIdvQxzvhO8ZlFUoNr/DRqz+9KZk8bjvL/0uc7FS6f8CPoPGyEgWIGnUWM53PYa/w1+rIq3WFIK+yDYnpbpY2ggLbOHf8uL0lSVfTMaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474504; c=relaxed/simple;
	bh=fyhCZriKWwu5+DLXuUC8rdNl44ocq6G6BHUGGHC+VRE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FUMrM6j2A1RSYvooQ/MutsiPGSrJr9TYxVs20xIN2z+6nt+s2th4e83qVomTLSdkwVdAVXXt06U7CaFDHXid2JKrbshSK0cYaGlxHmgv3stcyvDISYXKdZIYH5dLutA5zyKqL85AmfMFyDUNB8gNRd19/NR59Z5gn56fGUV0xvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EZD2Uhru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF893C32782;
	Mon, 12 Aug 2024 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474504;
	bh=fyhCZriKWwu5+DLXuUC8rdNl44ocq6G6BHUGGHC+VRE=;
	h=Subject:To:Cc:From:Date:From;
	b=EZD2Uhru4TVJxUsksYuwM7Neis66XGXur37CG3gp7gz+sY5ZRpfelw5UTmRY/fuFG
	 i5AAgcBSdTdnFVH9w/0Q86im8FPVG6YJb2VWEUWHGNO0BRZBHjvIQ9nKtb9eQWy670
	 bltJu+/UPJ2M/RojJDpDVJfD0bW0JPKJmIIRVjHQ=
Subject: FAILED: patch "[PATCH] drm/amd/display: Change ASSR disable sequence" failed to apply to 5.10-stable tree
To: swapnil.patel@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wayne.lin@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:52:17 +0200
Message-ID: <2024081216-wistful-halogen-6e44@gregkh>
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
git cherry-pick -x 2d696cc837eaf5394d79bfd2b0b0483c4778aa83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081216-wistful-halogen-6e44@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


