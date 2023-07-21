Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFF075BF91
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGUHXV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGUHXA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:23:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9581C3A8D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1100261136
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB94CC433C8;
        Fri, 21 Jul 2023 07:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924171;
        bh=w3OkuP2fu9Es74S/3HC9Nzy67WTcqYne0X9IxBX7qa4=;
        h=Subject:To:Cc:From:Date:From;
        b=0lUyfsU12pKO1ofwf/+mXJgRbunX4DYLIXOEUOhokawqWS58HH3OCCI9te7S4iJ4m
         o2p3IFFV10iRp0IIVN73WEx6jIisk3UpofoeXNQ5/ovmMt2FewJg3WU3NqMMGfS3Vg
         Rt2yJvxTKC3hhA3Olhyq8Kmh/yx/VZiUnzmi8vvs=
Subject: FAILED: patch "[PATCH] drm/amd/display: Limit DCN32 8 channel or less parts to DPM1" failed to apply to 6.1-stable tree
To:     Alvin.Lee2@amd.com, Rodrigo.Siqueira@amd.com,
        SyedSaaem.Rizvi@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:22:48 +0200
Message-ID: <2023072148-sulphuric-snowdrift-8d72@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
git cherry-pick -x ee7be8f3de1ccc9665281fe996f9b6d45191ec1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072148-sulphuric-snowdrift-8d72@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

ee7be8f3de1c ("drm/amd/display: Limit DCN32 8 channel or less parts to DPM1 for FPO")
2c30f8555121 ("drm/amd/display: Isolate remaining FPU code in DCN32")
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
e3834491b92a ("drm/amd/display: Add Debug Log for MST and PCON")
6ca7415f11af ("drm/amd/display: merge dc_link_dp into dc_link")
de3fb390175b ("drm/amd/display: move dp cts functions from dc_link_dp to link_dp_cts")
c5a31f178e35 ("drm/amd/display: move dp irq handler functions from dc_link_dp to link_dp_irq_handler")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee7be8f3de1ccc9665281fe996f9b6d45191ec1a Mon Sep 17 00:00:00 2001
From: Alvin Lee <Alvin.Lee2@amd.com>
Date: Mon, 10 Apr 2023 14:37:27 -0400
Subject: [PATCH] drm/amd/display: Limit DCN32 8 channel or less parts to DPM1
 for FPO

- Due to hardware related QoS issues, we need to limit certain
  SKUs with less memory channels to DPM1 and above.
- At DPM0 + workload running, the urgent return latency can
  exceed 15us (the expected maximum is 4us) which results in underflow

Cc: stable@vger.kernel.org
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 4f8286ae699b..0085ea78ea31 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1888,6 +1888,8 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 
 	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
 
+	dcn32_override_min_req_memclk(dc, context);
+
 	BW_VAL_TRACE_END_WATERMARKS();
 
 	goto validate_out;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index b8a2518faecc..ed7ea4c42412 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2887,3 +2887,18 @@ void dcn32_set_clock_limits(const struct _vcs_dpi_soc_bounding_box_st *soc_bb)
 	dc_assert_fp_enabled();
 	dcn3_2_soc.clock_limits[0].dcfclk_mhz = 1200.0;
 }
+
+void dcn32_override_min_req_memclk(struct dc *dc, struct dc_state *context)
+{
+	// WA: restrict FPO and SubVP to use first non-strobe mode (DCN32 BW issue)
+	if ((context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dcn32_subvp_in_use(dc, context)) &&
+			dc->dml.soc.num_chans <= 8) {
+		int num_mclk_levels = dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels;
+
+		if (context->bw_ctx.dml.vba.DRAMSpeed <= dc->clk_mgr->bw_params->clk_table.entries[0].memclk_mhz * 16 &&
+				num_mclk_levels > 1) {
+			context->bw_ctx.dml.vba.DRAMSpeed = dc->clk_mgr->bw_params->clk_table.entries[1].memclk_mhz * 16;
+			context->bw_ctx.bw.dcn.clk.dramclk_khz = context->bw_ctx.dml.vba.DRAMSpeed * 1000 / 16;
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index dcf512cd3072..a4206b71d650 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -80,6 +80,8 @@ void dcn32_assign_fpo_vactive_candidate(struct dc *dc, const struct dc_state *co
 
 bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, uint32_t vactive_margin_req);
 
+void dcn32_override_min_req_memclk(struct dc *dc, struct dc_state *context);
+
 void dcn32_set_clock_limits(const struct _vcs_dpi_soc_bounding_box_st *soc_bb);
 
 #endif

