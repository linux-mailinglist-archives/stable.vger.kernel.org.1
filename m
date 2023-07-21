Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F1775BFAA
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGUHZg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGUHZf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C16A189
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2444F6112C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A98EC433C9;
        Fri, 21 Jul 2023 07:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924333;
        bh=LGMWorbpUrUOJrA9wD5nOZSqiN+kFqEYphxRhT7yhx8=;
        h=Subject:To:Cc:From:Date:From;
        b=USC8rvKPheTguuL/oTwOdggCL5aJeHgwrnEBQMqCsdq6bX460MOC90TlYm/LGQXfu
         mQYaqhzGrwJoDJ1Y7HMmXR3BnEofa+CB1sSsj81ryLAU5lnBcM6Fssg+c8BcFzI8CW
         AlurVcQoLjTuQRzqVizZ8W0bX8X+EF9M72i2+lUA=
Subject: FAILED: patch "[PATCH] drm/amd/display: Do not disable phantom pipes in driver" failed to apply to 6.4-stable tree
To:     syedsaaem.rizvi@amd.com, Alvin.Lee2@amd.com,
        alexander.deucher@amd.com, daniel.wheeler@amd.com,
        mario.limonciello@amd.com, stylon.wang@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:25:22 +0200
Message-ID: <2023072122-selector-jawed-3fc9@gregkh>
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


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x d62088ba314ecf098871874898ed760347d1fbd8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072122-selector-jawed-3fc9@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d62088ba314ecf098871874898ed760347d1fbd8 Mon Sep 17 00:00:00 2001
From: Saaem Rizvi <syedsaaem.rizvi@amd.com>
Date: Tue, 30 May 2023 13:21:10 -0400
Subject: [PATCH] drm/amd/display: Do not disable phantom pipes in driver

[Why and How]
We should not disable phantom pipes in this sequence, as this should be
controlled by FW. Furthermore, the previous programming sequence would
have enabled the phantom pipe in driver as well, causing corruption.
This change should avoid this from occuring.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Saaem Rizvi <syedsaaem.rizvi@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 00f32ffe0079..e5bd76c6b1d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1211,7 +1211,8 @@ void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
 
-		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
+		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))
+			&& pipe->stream->mall_stream_config.type != SUBVP_PHANTOM) {
 			pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
 			reset_sync_context_for_pipe(dc, context, i);
 			otg_disabled[i] = true;

