Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053B674C34F
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjGILaq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjGILap (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:30:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D06C0
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:30:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 272A060B86
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377B0C433C7;
        Sun,  9 Jul 2023 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902243;
        bh=XElCneLf/khqTMq5VzgpKO5CKYZSyJY5tdz4h9V7YzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSwVbvikFZDuCVHSIWBxuqZBa0m1ERI8yIU6bOrm4xemIjQhqgfxbpinVdQIYf9zi
         K4KbdwYlHZHca1qxUld5YL5j7EOKPpo8zvV7yxy7UUEmuyUGw7wkRQ1+wECa2J6dYl
         G4bPchKSJBXwkePm+yU+gPufrV22NhJ39B/eSNuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 279/431] drm/amd/display: Fix artifacting on eDP panels when engaging freesync video mode
Date:   Sun,  9 Jul 2023 13:13:47 +0200
Message-ID: <20230709111457.686803968@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[ Upstream commit b18f05a0666aecd5cb19c26a8305bcfa4e9d6502 ]

[Why]
When freesync video mode is enabled, switching resolution from native
mode to one of the freesync video compatible modes can trigger continous
artifacts on some eDP panels when running under KDE. The articating can be seen in the
attached bug report.

[How]
Fix this by restricting updates that require full commit by using the same checks
for stream and scaling changes in the the enable pass of dm_update_crtc_state()
along with the check for compatible timings for freesync vide mode.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2162
Fixes: da5e14909776 ("drm/amd/display: Fix hang when skipping modeset")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2cbd6949804f5..261dbd417c2f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9276,6 +9276,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 		/* Now check if we should set freesync video mode */
 		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
+		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
+		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    is_timing_unchanged_for_freesync(new_crtc_state,
 						     old_crtc_state)) {
 			new_crtc_state->mode_changed = false;
-- 
2.39.2



