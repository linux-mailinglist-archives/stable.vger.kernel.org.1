Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECF67552A4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGPUKN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjGPUKL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:10:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F83E57
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B71E60EB3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E866C433C8;
        Sun, 16 Jul 2023 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538208;
        bh=nehc9UeoDg/AFZKaXKFYGmUBU8oSUPIovkkEZ2zK570=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DP+o5401ZLnTV8S6l0Vh6Ax3Cokz2GaPxzqGyHXgWh58Plde5Lf52MUVi/n652c0/
         WVFZulluvW+jMDvwPjkCmwyDDR+h97kW7MRjMsuk+m/1iV3Xy/rZbBYEDpLLQSyjjE
         3I2WDoJGH9flZ20+R73fMPq5kHOLcXW8TO+fNctw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 369/800] drm/amd/display: Fix artifacting on eDP panels when engaging freesync video mode
Date:   Sun, 16 Jul 2023 21:43:42 +0200
Message-ID: <20230716194957.646246341@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9259,6 +9259,8 @@ static int dm_update_crtc_state(struct a
 
 		/* Now check if we should set freesync video mode */
 		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
+		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
+		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    is_timing_unchanged_for_freesync(new_crtc_state,
 						     old_crtc_state)) {
 			new_crtc_state->mode_changed = false;


