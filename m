Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDDB75BF9D
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGUHYI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGUHYG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:24:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663C6171A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAC2961136
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3B0C433C8;
        Fri, 21 Jul 2023 07:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924243;
        bh=qeZejkS6vDDRdH9PNTVDWj+X9g6ETaCu82F8ghpNwmI=;
        h=Subject:To:Cc:From:Date:From;
        b=HNIIwjEsIebglJlS7Z9dlCX5uB19z9PvRGZVn8/LnjI5XksVnP+Z0n0MrAOjreNn1
         R6WtepoEi7FIuN+ISdiAvSrg+S26qMgbrjyu+6NP+BWBRSD9veksvL2G29GeESMXqJ
         sEm90aU7c1XbsHGGZRu9Cbk3HHTJzpVPllOJiAZI=
Subject: FAILED: patch "[PATCH] drm/amd/display: Block SubVP high refresh when VRR active" failed to apply to 6.4-stable tree
To:     Alvin.Lee2@amd.com, Jun.Lei@amd.com, Nevenko.Stupar@amd.com,
        alex.hung@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, mario.limonciello@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:23:52 +0200
Message-ID: <2023072152-disbelief-wrongdoer-e9f2@gregkh>
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


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x a00e595207d001432a85758954c3a6f6a9896368
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072152-disbelief-wrongdoer-e9f2@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



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

