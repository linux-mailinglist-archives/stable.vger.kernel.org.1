Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A175E249
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 16:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjGWOGR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 10:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGWOGQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 10:06:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B54CE70
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 07:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 187A460BB8
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 14:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FBBC433C8;
        Sun, 23 Jul 2023 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690121174;
        bh=5d/jiIVh2nV1wI/pcgwFVLoma6dUncXnbcXkycSu0CI=;
        h=Subject:To:Cc:From:Date:From;
        b=TgT8UhLtLh7RYN38oJYDiP/zljeeoSG0rFbp3/OGFUwNNBjAMkCTOW7cko+buZV2N
         h36o97pwiZPubaXSc+TtU5DbA2BT3nDu6lBSMOLTg3pJDeaW1b9BTfDuR1WRWzzTaC
         jrwvq2a8t7qNeo9MXYebcIi2KOIwkxzeRSx6huK0=
Subject: FAILED: patch "[PATCH] drm/amd/display: Prevent vtotal from being set to 0" failed to apply to 5.15-stable tree
To:     daniel.miess@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, haoping.liu@amd.com,
        mario.limonciello@amd.com, nicholas.kazlauskas@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 16:06:02 +0200
Message-ID: <2023072302-unengaged-strum-b2ad@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2a9482e55968ed7368afaa9c2133404069117320
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072302-unengaged-strum-b2ad@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

2a9482e55968 ("drm/amd/display: Prevent vtotal from being set to 0")
1a4bcdbea431 ("drm/amd/display: Fix possible underflow for displays with large vblank")
469a62938a45 ("drm/amd/display: update extended blank for dcn314 onwards")
e3416e872f84 ("drm/amd/display: Add FAMS validation before trying to use it")
0db13eae41fc ("drm/amd/display: Add minimum Z8 residency debug option")
73dd4ca4b5a0 ("drm/amd/display: Fix Z8 support configurations")
db4107e92a81 ("drm/amd/display: fix dc/core/dc.c kernel-doc")
00812bfc7bcb ("drm/amd/display: Add debug option to skip PSR CRTC disable")
80676936805e ("drm/amd/display: Add Z8 allow states to z-state support list")
e366f36958f6 ("drm/amd/display: Rework comments on dc file")
bd829d570773 ("drm/amd/display: Refactor eDP PSR codes")
6f4f8ff567c4 ("drm/amd/display: Display does not light up after S4 resume")
4f5bdde386d3 ("drm/amd/display: Update PMFW z-state interface for DCN314")
8cab4ef0ad95 ("drm/amd/display: Keep OTG on when Z10 is disable")
1178ac68dc28 ("drm/amd/display: Refactor edp ILR caps codes")
5d4b59146078 ("drm/amd/display: Add ABM control to panel_config struct.")
936675464b1f ("drm/amd/display: Add debug option for exiting idle optimizations on cursor updates")
eccff6cdde6f ("drm/amd/display: Refactor edp panel power sequencer(PPS) codes")
9f6f6be163df ("drm/amd/display: Add comments.")
c17a34e0526f ("drm/amd/display: Refactor edp dsc codes.")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a9482e55968ed7368afaa9c2133404069117320 Mon Sep 17 00:00:00 2001
From: Daniel Miess <daniel.miess@amd.com>
Date: Thu, 22 Jun 2023 08:11:48 -0400
Subject: [PATCH] drm/amd/display: Prevent vtotal from being set to 0

[Why]
In dcn314 DML the destination pipe vtotal was being set
to the crtc adjustment vtotal_min value even in cases
where that value is 0.

[How]
Only set vtotal to the crtc adjustment vtotal_min value
in cases where the value is non-zero.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index d9e049e7ff0a..ed8ddb75b333 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -295,7 +295,11 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
-		pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
+		if (pipe->stream->adjust.v_total_min != 0)
+			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
+		else
+			pipes[pipe_cnt].pipe.dest.vtotal = timing->v_total;
+
 		pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
 		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, dcn3_14_ip.VBlankNomDefaultUS);
 		pipes[pipe_cnt].pipe.dest.vblank_nom = max(pipes[pipe_cnt].pipe.dest.vblank_nom, timing->v_sync_width);

