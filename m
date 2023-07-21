Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCAF75BF9C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjGUHX6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGUHX5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBECD1999
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37B5361136
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C365C433C8;
        Fri, 21 Jul 2023 07:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924234;
        bh=csQYs1+5hD4EomYVC80K7wSDLYlHHB/pQWkPs6eizwM=;
        h=Subject:To:Cc:From:Date:From;
        b=pSeykkFD3KfOpIQ7D4g32AoWaHuMr0WHHlSfQ7JN04amBh0Up+pCrh9emNZvPocCd
         HmJShNLpL24hoLswHyOxt1D4SSe57jTW+zgl9gvNSc8fYsQvE4R9SKPlgI3ptQHTEq
         T/XEcJQNKY22ckehaAOT9ATNEvOw3Iq0BoAGThao=
Subject: FAILED: patch "[PATCH] drm/amd/display: Block SubVP high refresh when VRR active" failed to apply to 6.1-stable tree
To:     Alvin.Lee2@amd.com, Jun.Lei@amd.com, Nevenko.Stupar@amd.com,
        alex.hung@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, mario.limonciello@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:23:51 +0200
Message-ID: <2023072151-citable-abide-c304@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a00e595207d001432a85758954c3a6f6a9896368
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072151-citable-abide-c304@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a00e595207d0 ("drm/amd/display: Block SubVP high refresh when VRR active fixed")
87f0c16e0eeb ("drm/amd/display: Enable SubVP for high refresh rate displays")
b058e3999021 ("drm/amd/display: Enable SubVP on PSR panels if single stream")
ec341e0f4a02 ("drm/amd/display: add extra dc odm debug options")
e0a77e09c707 ("drm/amd/display: Add missing WA and MCLK validation")
d170e938f01f ("drm/amd/display: On clock init, maintain DISPCLK freq")
0289e0ed1b9a ("drm/amd/display: Add FPO + VActive support")
0cdf91bf67b7 ("drm/amd/display: Enable FPO optimization")
53c8ed46e816 ("drm/amd/display: Conditionally enable 6.75 GBps link rate")
4ed793083afc ("drm/amd/display: Use per pipe P-State force for FPO")
e8e5cc645b2d ("drm/amd/display: Add infrastructure for enabling FAMS for DCN30")
ac18b610fd95 ("drm/amd/display: Enable FPO for configs that could reduce vlevel")
7bd571b274fd ("drm/amd/display: DAL to program DISPCLK WDIVIDER if PMFW doesn't")
3d8fcc6740c9 ("drm/amd/display: Extract temp drm mst deallocation wa into its own function")
7cd07d9de871 ("drm/amd/display: Set max vratio for prefetch to 7.9 for YUV420 MPO")
54618888d1ea ("drm/amd/display: break down dc_link.c")
71d7e8904d54 ("drm/amd/display: Add HDMI manufacturer OUI and device id read")
65a4cfb45e0e ("drm/amdgpu/display: remove duplicate include header in files")
e322843e5e33 ("drm/amd/display: fix linux dp link lost handled only one time")
0c2bfcc338eb ("drm/amd/display: Add Function declaration in dc_link")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a00e595207d001432a85758954c3a6f6a9896368 Mon Sep 17 00:00:00 2001
From: Alvin Lee <Alvin.Lee2@amd.com>
Date: Thu, 27 Apr 2023 15:10:41 -0400
Subject: [PATCH] drm/amd/display: Block SubVP high refresh when VRR active
 fixed

[Description]
- SubVP high refresh is blocked when VRR is active variable, but
  we should also block it for when VRR is active fixed (video use
  case)

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 46fd7b68857c..cd28980b2b56 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2825,7 +2825,7 @@ bool dcn32_allow_subvp_high_refresh_rate(struct dc *dc, struct dc_state *context
 	uint32_t i;
 
 	if (!dc->debug.disable_subvp_high_refresh && pipe->stream &&
-			pipe->plane_state && !pipe->stream->vrr_active_variable) {
+			pipe->plane_state && !(pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed)) {
 		refresh_rate = (pipe->stream->timing.pix_clk_100hz * 100 +
 						pipe->stream->timing.v_total * pipe->stream->timing.h_total - 1)
 						/ (double)(pipe->stream->timing.v_total * pipe->stream->timing.h_total);

