Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AD8701516
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 09:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjEMHmV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 03:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjEMHmT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 03:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF902738
        for <stable@vger.kernel.org>; Sat, 13 May 2023 00:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8667561C04
        for <stable@vger.kernel.org>; Sat, 13 May 2023 07:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4ECC433EF;
        Sat, 13 May 2023 07:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683963738;
        bh=zAUhxbqwxPgl2Ha4E8MvFHG74PJUGbe94onXQM6BlgA=;
        h=Subject:To:Cc:From:Date:From;
        b=MOXp9qMnuRXiJROHXf0JjuvTn5uZkCs1HbXLl2Ss6ss1k3DkjM/981Ye198+4ohDI
         i8hAiT6nMlVHdZcS0iBBYNxOlHR5+x+Cy/JAI5dVTYiwLEa5r0WzPKuVR0itjCiCjU
         FsyT0rN+sC3o9GttK+GiIRPFRqtNeHTD2GQdWhsQ=
Subject: FAILED: patch "[PATCH] drm/amd/display: Do not set DRR on pipe Commit" failed to apply to 6.1-stable tree
To:     Wesley.Chalmers@amd.com, Jun.Lei@amd.com,
        alexander.deucher@amd.com, daniel.wheeler@amd.com,
        mario.limonciello@amd.com, qingqing.zhuo@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 16:21:39 +0900
Message-ID: <2023051339-deprive-cacti-1d84@gregkh>
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
git cherry-pick -x 825b3772a2047bd32ed3b3914234da0de19ef2e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051339-deprive-cacti-1d84@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

825b3772a204 ("drm/amd/display: Do not set DRR on pipe Commit")
36951fc9460f ("Revert "drm/amd/display: Do not set DRR on pipe commit"")
4f1b5e739dfd ("drm/amd/display: Do not set DRR on pipe commit")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 825b3772a2047bd32ed3b3914234da0de19ef2e0 Mon Sep 17 00:00:00 2001
From: Wesley Chalmers <Wesley.Chalmers@amd.com>
Date: Thu, 3 Nov 2022 22:29:31 -0400
Subject: [PATCH] drm/amd/display: Do not set DRR on pipe Commit

[WHY]
Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as a
pipe commit can cause underflow.

Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 586de81fc2da..6d328b7e07a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -990,8 +990,5 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
-
-	dc_dmub_srv_p_state_delegate(dc,
-		context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching, context);
 }
 

