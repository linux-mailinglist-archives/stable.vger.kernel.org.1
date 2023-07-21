Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D40975BF9E
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjGUHYK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGUHYJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3301715
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 554A0611A0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377CDC433C7;
        Fri, 21 Jul 2023 07:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924246;
        bh=nBPBvmziPvT0XKLooSe6DL0CoA6ODsaLNyDexQFN/t4=;
        h=Subject:To:Cc:From:Date:From;
        b=Ko7wPM7f48jmLnyXZpKmNvKMGg7yswRJRbVNVizb+sE+DVOrIN7i9VzC0qApJtlux
         cW4a/ArsJKZj7ydVUOwqWbepOc0Im815gjbSaEdtj3lkdtKjsR5DWjy6K5p45T2/x9
         bWbk7IATFFGlIh8nrA/nxGZpnfytgK+zUrEPPsnQ=
Subject: FAILED: patch "[PATCH] drm/amd/display: Block SubVP on displays that have pixclk >" failed to apply to 6.1-stable tree
To:     Alvin.Lee2@amd.com, Jun.Lei@amd.com, Nevenko.Stupar@amd.com,
        alex.hung@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, mario.limonciello@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:24:03 +0200
Message-ID: <2023072103-porthole-landside-b3fb@gregkh>
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
git cherry-pick -x 807a1c14276b6ba6dc7efb4784ac35bceea1413f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072103-porthole-landside-b3fb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

807a1c14276b ("drm/amd/display: Block SubVP on displays that have pixclk > 1800Mhz")
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

From 807a1c14276b6ba6dc7efb4784ac35bceea1413f Mon Sep 17 00:00:00 2001
From: Alvin Lee <Alvin.Lee2@amd.com>
Date: Fri, 28 Apr 2023 17:29:02 -0400
Subject: [PATCH] drm/amd/display: Block SubVP on displays that have pixclk >
 1800Mhz

[Description]
- Enabling SubVP on high refresh rate displays had a side effect
  of also enabling on high bandwidth displays such as 8K60
- However, these are not validated and should be blocked for
  the time being
- Block SubVP on displays that have pix rate > 1800Mhz (includes
  8K60 displays)

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 04be01ae1ecf..42ccfd13a37c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -41,6 +41,7 @@
 #define DCN3_2_DCFCLK_DS_INIT_KHZ 10000 // Choose 10Mhz for init DCFCLK DS freq
 #define DCN3_2_MIN_ACTIVE_SWITCH_MARGIN_FPO_US 100 // Only allow FPO + Vactive if active margin >= 100
 #define SUBVP_HIGH_REFRESH_LIST_LEN 3
+#define DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ 1800
 
 #define TO_DCN32_RES_POOL(pool)\
 	container_of(pool, struct dcn32_resource_pool, base)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index cd28980b2b56..f7e45d935a29 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -703,6 +703,7 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 * - Not TMZ surface
 		 */
 		if (pipe->plane_state && !pipe->top_pipe && !dcn32_is_center_timing(pipe) &&
+				!(pipe->stream->timing.pix_clk_100hz / 10000 > DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ) &&
 				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
 				pipe->stream->mall_stream_config.type == SUBVP_NONE &&
 				(refresh_rate < 120 || dcn32_allow_subvp_high_refresh_rate(dc, context, pipe)) &&

