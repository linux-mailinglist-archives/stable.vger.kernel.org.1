Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D81F75BFA7
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGUHZN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGUHZM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B960B189
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:25:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FD4361136
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37066C433C8;
        Fri, 21 Jul 2023 07:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924310;
        bh=1C5aEZ9xbahovNtnfOlxxqr7mZufFHBbCXX91iQztuA=;
        h=Subject:To:Cc:From:Date:From;
        b=qmr26/ZjdARgYnWOes/1LopVon5/MoMRAxSp11fCUXBfA1DRoB5IlqZDTGDyeBB/b
         OpfUof+kxtLnTjpqJj7UtudYotp0DBmPfNAxzNKGxUwaJ8IJzol/us9uc02R+yDsQp
         mc5sUTACu1snnY3AAyVvxBUOC6zWe0VVRgmHnxYI=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix dcn315 single stream crb allocation" failed to apply to 6.1-stable tree
To:     dmytro.laktyushkin@amd.com, Charlene.Liu@amd.com,
        alexander.deucher@amd.com, daniel.wheeler@amd.com,
        mario.limonciello@amd.com, stylon.wang@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:25:08 +0200
Message-ID: <2023072107-stifling-ribcage-0deb@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 49f26218c344741cb3eaa740b1e44e960551a87f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072107-stifling-ribcage-0deb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

49f26218c344 ("drm/amd/display: fix dcn315 single stream crb allocation")
9ba90d760e93 ("drm/amd/display: add pixel rate based CRB allocation support")
655435df0936 ("drm/amd/display: fix unbounded requesting for high pixel rate modes on dcn315")
2641c7b78081 ("drm/amd/display: use low clocks for no plane configs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49f26218c344741cb3eaa740b1e44e960551a87f Mon Sep 17 00:00:00 2001
From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Date: Tue, 16 May 2023 15:50:40 -0400
Subject: [PATCH] drm/amd/display: fix dcn315 single stream crb allocation

Change to improve avoiding asymetric crb calculations for single stream
scenarios.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index cb95e978417b..8570bdc292b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1628,6 +1628,10 @@ static bool allow_pixel_rate_crb(struct dc *dc, struct dc_state *context)
 	int i;
 	struct resource_context *res_ctx = &context->res_ctx;
 
+	/*Don't apply for single stream*/
+	if (context->stream_count < 2)
+		return false;
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!res_ctx->pipe_ctx[i].stream)
 			continue;
@@ -1727,19 +1731,23 @@ static int dcn315_populate_dml_pipes_from_context(
 		pipe_cnt++;
 	}
 
-	/* Spread remaining unreserved crb evenly among all pipes, use default policy if not enough det or single pipe */
+	/* Spread remaining unreserved crb evenly among all pipes*/
 	if (pixel_rate_crb) {
 		for (i = 0, pipe_cnt = 0, crb_idx = 0; i < dc->res_pool->pipe_count; i++) {
 			pipe = &res_ctx->pipe_ctx[i];
 			if (!pipe->stream)
 				continue;
 
+			/* Do not use asymetric crb if not enough for pstate support */
+			if (remaining_det_segs < 0) {
+				pipes[pipe_cnt].pipe.src.det_size_override = 0;
+				continue;
+			}
+
 			if (!pipe->top_pipe && !pipe->prev_odm_pipe) {
 				bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
 						|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
 
-				if (remaining_det_segs < 0 || crb_pipes == 1)
-					pipes[pipe_cnt].pipe.src.det_size_override = 0;
 				if (remaining_det_segs > MIN_RESERVED_DET_SEGS)
 					pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
 							(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
@@ -1755,6 +1763,7 @@ static int dcn315_populate_dml_pipes_from_context(
 				}
 				/* Convert segments into size for DML use */
 				pipes[pipe_cnt].pipe.src.det_size_override *= DCN3_15_CRB_SEGMENT_SIZE_KB;
+
 				crb_idx++;
 			}
 			pipe_cnt++;

