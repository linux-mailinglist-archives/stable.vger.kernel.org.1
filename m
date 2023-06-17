Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C218733F9B
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 10:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjFQIXT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 04:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbjFQIXS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 04:23:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5717C2722
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 01:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E77DF60FA0
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 08:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08451C433C0;
        Sat, 17 Jun 2023 08:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686990194;
        bh=HW9bh8y96gyjyJ290h8SurB9YxXcqKUSJu3/fup1eFs=;
        h=Subject:To:Cc:From:Date:From;
        b=nz7MoVG313mgU0Rbg4csKHWrG+zBOiUBo7XWSjUY3N3fDuMnCdTFBD+hfsetlVMB/
         I63bGf+TPcL2c7//RexUa+1icenlGoEExPepH4QdehH0m3Qr6i1T3u4nwYicpQJ2yC
         Zt/5r/1kqkhvpMbc6qtwIXrb7RrbnPiMtaBN5AXs=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix the system hang while disable PSR" failed to apply to 5.15-stable tree
To:     chiahsuan.chung@amd.com, Wayne.Lin@amd.com,
        alexander.deucher@amd.com, daniel.wheeler@amd.com,
        mario.limonciello@amd.com, stylon.wang@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 17 Jun 2023 10:23:02 +0200
Message-ID: <2023061702-flashily-lent-a5c4@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ea2062dd1f0384ae1b136d333ee4ced15bedae38
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061702-flashily-lent-a5c4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea2062dd1f0384ae1b136d333ee4ced15bedae38 Mon Sep 17 00:00:00 2001
From: Tom Chung <chiahsuan.chung@amd.com>
Date: Mon, 29 May 2023 18:00:09 +0800
Subject: [PATCH] drm/amd/display: fix the system hang while disable PSR

[Why]
When the PSR enabled. If you try to adjust the timing parameters,
it may cause system hang. Because the timing mismatch with the
DMCUB settings.

[How]
Disable the PSR before adjusting timing parameters.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2b8d42de1f73..7acd73e5004f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8204,6 +8204,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		if (acrtc_state->abm_level != dm_old_crtc_state->abm_level)
 			bundle->stream_update.abm_level = &acrtc_state->abm_level;
 
+		mutex_lock(&dm->dc_lock);
+		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
+				acrtc_state->stream->link->psr_settings.psr_allow_active)
+			amdgpu_dm_psr_disable(acrtc_state->stream);
+		mutex_unlock(&dm->dc_lock);
+
 		/*
 		 * If FreeSync state on the stream has changed then we need to
 		 * re-adjust the min/max bounds now that DC doesn't handle this
@@ -8217,10 +8223,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 		}
 		mutex_lock(&dm->dc_lock);
-		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
-				acrtc_state->stream->link->psr_settings.psr_allow_active)
-			amdgpu_dm_psr_disable(acrtc_state->stream);
-
 		update_planes_and_stream_adapter(dm->dc,
 					 acrtc_state->update_type,
 					 planes_count,

