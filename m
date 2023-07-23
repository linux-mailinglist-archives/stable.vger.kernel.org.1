Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F64375E247
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 16:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGWOGL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 10:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWOGL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 10:06:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9744E70
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 07:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48DA160BB8
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 14:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58607C433C7;
        Sun, 23 Jul 2023 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690121168;
        bh=v04fEqwk/Qbis0kx9PtkITJ54Ydbk0pHAEI3Objguzk=;
        h=Subject:To:Cc:From:Date:From;
        b=2HxE2W3xQyfl+eTvlebzN1dCuiT2+XKQql90A+GAiOggQ5Xiev9JSZm3idvwMaeXn
         1jem1BbA5P0QnN2W0vo5CTOh4kWLCg25NtW8DeiitCmLb9muEZ+tVLXs11wddCJYTa
         WOF1SJpOj3rchE5fsNWPRhdd6qh9PyCWxnCA0nHs=
Subject: FAILED: patch "[PATCH] drm/amd/display: Prevent vtotal from being set to 0" failed to apply to 6.4-stable tree
To:     daniel.miess@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, haoping.liu@amd.com,
        mario.limonciello@amd.com, nicholas.kazlauskas@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 16:06:00 +0200
Message-ID: <2023072300-thwarting-luckiness-18bd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2a9482e55968ed7368afaa9c2133404069117320
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072300-thwarting-luckiness-18bd@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



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

