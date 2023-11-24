Return-Path: <stable+bounces-243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CD47F75B6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B36F1F20F18
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2772A28E26;
	Fri, 24 Nov 2023 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VZwBa5yp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB00F18041
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A879C433C8;
	Fri, 24 Nov 2023 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700834065;
	bh=ltQu9ApGL7q2oF4ex/vDgW1P/rEN2IqkbFp1N5Wjx8o=;
	h=Subject:To:Cc:From:Date:From;
	b=VZwBa5yp0Mc8XknwWCmsFXCVRmttH6OSM6p/qm+51ZKi53us/jKi2xpP5vbyrQxA8
	 lCI42MoTyfXzzMIMsKbOFodVWG0p1eFrwxDLmtoP2mrOoX+YRieF+Ti8CxQXwBfx6E
	 Apm/70r3YMJh1gPO+BAp5G5KBh9rnswB0ChyoufI=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix 2nd DPIA encoder Assignment" failed to apply to 6.1-stable tree
To: mghaddar@amd.com,alexander.deucher@amd.com,cruise.hung@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,meenakshikumar.somasundaram@amd.com,stylon.wang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:54:17 +0000
Message-ID: <2023112417-author-ellipse-c521@gregkh>
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
git cherry-pick -x 48468787c2b029e5c9f8abef777cd065647abf2e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112417-author-ellipse-c521@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

48468787c2b0 ("drm/amd/display: Fix 2nd DPIA encoder Assignment")
753b7e62c9cf ("drm/amd/display: Add DPIA Link Encoder Assignment Fix")
7ae1dbe6547c ("drm/amd/display: merge dc_link.h into dc.h and dc_types.h")
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
bd3149014dff ("drm/amd/display: Decrease messaging about DP alt mode state to debug")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 48468787c2b029e5c9f8abef777cd065647abf2e Mon Sep 17 00:00:00 2001
From: Mustapha Ghaddar <mghaddar@amd.com>
Date: Tue, 22 Aug 2023 16:18:03 -0400
Subject: [PATCH] drm/amd/display: Fix 2nd DPIA encoder Assignment

[HOW & Why]
There seems to be an issue with 2nd DPIA acquiring link encoder for tiled displays.
Solution is to remove check for eng_id before we get first dynamic encoder for it

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index b66eeac4d3d2..be5a6d008b29 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -395,8 +395,7 @@ void link_enc_cfg_link_encs_assign(
 					stream->link->dpia_preferred_eng_id != ENGINE_ID_UNKNOWN)
 				eng_id_req = stream->link->dpia_preferred_eng_id;
 
-			if (eng_id == ENGINE_ID_UNKNOWN)
-				eng_id = find_first_avail_link_enc(stream->ctx, state, eng_id_req);
+			eng_id = find_first_avail_link_enc(stream->ctx, state, eng_id_req);
 		}
 		else
 			eng_id =  link_enc->preferred_engine;
@@ -501,7 +500,6 @@ struct dc_link *link_enc_cfg_get_link_using_link_enc(
 	if (stream)
 		link = stream->link;
 
-	// dm_output_to_console("%s: No link using DIG(%d).\n", __func__, eng_id);
 	return link;
 }
 


