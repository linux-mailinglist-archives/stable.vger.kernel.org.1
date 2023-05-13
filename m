Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC630701502
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 09:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjEMHjb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 03:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMHj3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 03:39:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE13A59FD
        for <stable@vger.kernel.org>; Sat, 13 May 2023 00:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 642B661827
        for <stable@vger.kernel.org>; Sat, 13 May 2023 07:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DEBC433D2;
        Sat, 13 May 2023 07:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683963567;
        bh=FmK9dRSwHf4Uu/bnqCJgJjy92v57eJPI0C6ngQZ5ShI=;
        h=Subject:To:Cc:From:Date:From;
        b=cwHHWWn+cwCo8ohbRUWeC6zmr5iJNBER+u/aRYk+K3BFAnXJJr3Lz4a3UB4mtlRbF
         HR9U7B9bjmNND7iDX0KzA8Rcsk1DV9QxrbgFACkF7T1eKEDSAI/EbgXXfnYmSVTG5E
         pSdWRlTbVmoLBP2cxpK6p1qND87YBUKRhZWzmfxI=
Subject: FAILED: patch "[PATCH] drm/amd/display: disconnect MPCC only on OTG change" failed to apply to 6.2-stable tree
To:     ayugupta@amd.com, Alvin.Lee2@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, mario.limonciello@amd.com,
        qingqing.zhuo@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 16:20:27 +0900
Message-ID: <2023051327-squad-epidermis-5e80@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.2.y
git checkout FETCH_HEAD
git cherry-pick -x 562e08223a85f315122cd65e8f99b8c0a42b8771
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051327-squad-epidermis-5e80@gregkh' --subject-prefix 'PATCH 6.2.y' HEAD^..

Possible dependencies:

562e08223a85 ("drm/amd/display: disconnect MPCC only on OTG change")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 562e08223a85f315122cd65e8f99b8c0a42b8771 Mon Sep 17 00:00:00 2001
From: Ayush Gupta <ayugupta@amd.com>
Date: Thu, 2 Mar 2023 09:58:05 -0500
Subject: [PATCH] drm/amd/display: disconnect MPCC only on OTG change

[Why]
Framedrops are observed while playing Vp9 and Av1 10 bit
video on 8k resolution using VSR while playback controls
are disappeared/appeared

[How]
Now ODM 2 to 1 is disabled for 5k or greater resolutions on VSR.

Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Ayush Gupta <ayugupta@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index f6f72e7c9e86..633491331722 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1914,6 +1914,7 @@ int dcn32_populate_dml_pipes_from_context(
 	struct pipe_ctx *pipe;
 	bool subvp_in_use = false;
 	struct dc_crtc_timing *timing;
+	bool vsr_odm_support = false;
 
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 
@@ -1931,12 +1932,15 @@ int dcn32_populate_dml_pipes_from_context(
 		timing = &pipe->stream->timing;
 
 		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+		vsr_odm_support = (res_ctx->pipe_ctx[i].stream->src.width >= 5120 &&
+				res_ctx->pipe_ctx[i].stream->src.width > res_ctx->pipe_ctx[i].stream->dst.width);
 		if (context->stream_count == 1 &&
 				context->stream_status[0].plane_count == 1 &&
 				!dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal) &&
 				is_h_timing_divisible_by_2(res_ctx->pipe_ctx[i].stream) &&
 				pipe->stream->timing.pix_clk_100hz * 100 > DCN3_2_VMIN_DISPCLK_HZ &&
-				dc->debug.enable_single_display_2to1_odm_policy) {
+				dc->debug.enable_single_display_2to1_odm_policy &&
+				!vsr_odm_support) { //excluding 2to1 ODM combine on >= 5k vsr
 			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
 		}
 		pipe_cnt++;

