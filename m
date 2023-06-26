Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F47673E77E
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjFZSPn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjFZSPl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FC4E74
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 017C760F51
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D6CC433C8;
        Mon, 26 Jun 2023 18:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803339;
        bh=G5SjpQi4WJrnZjX7/hfj2W+R9UBvGuge3Dn5mvhWqsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0WRtVao7o7BlvOqsPqTEQjZJni8P7AkaXywWW0CbsD3QGg74jORfT8zfXx6tndAS
         /JreFmn6Q4dJs8ux7boRw2w8MilW8IIxkdF5Vwgheb0qd/DGbxqzDwH988rOH1AdFN
         vn28dPlOuXHHjBYR3/ebde5gVCbodus/ZXJPTMto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <Harry.Wentland@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 003/199] drm/amd/display: Add wrapper to call planes and stream update
Date:   Mon, 26 Jun 2023 20:08:29 +0200
Message-ID: <20230626180805.792591707@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[ Upstream commit 81f743a08f3b214638aa389e252ae5e6c3592e7c ]

[Why & How]
This commit is part of a sequence of changes that replaces the commit
sequence used in the DC with a new one. As a result of this transition,
we moved some specific parts from the commit sequence and brought them
to amdgpu_dm. This commit adds a wrapper inside DM that enable our
drivers to do any necessary preparation or change before we offload the
plane/stream update to DC.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 +++++++++++++++----
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ae58f24be511c..51a3130f607e0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -350,6 +350,35 @@ static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 		return false;
 }
 
+/**
+ * update_planes_and_stream_adapter() - Send planes to be updated in DC
+ *
+ * DC has a generic way to update planes and stream via
+ * dc_update_planes_and_stream function; however, DM might need some
+ * adjustments and preparation before calling it. This function is a wrapper
+ * for the dc_update_planes_and_stream that does any required configuration
+ * before passing control to DC.
+ */
+static inline bool update_planes_and_stream_adapter(struct dc *dc,
+						    int update_type,
+						    int planes_count,
+						    struct dc_stream_state *stream,
+						    struct dc_stream_update *stream_update,
+						    struct dc_surface_update *array_of_surface_update)
+{
+	/*
+	 * Previous frame finished and HW is ready for optimization.
+	 */
+	if (update_type == UPDATE_TYPE_FAST)
+		dc_post_update_surfaces_to_stream(dc);
+
+	return dc_update_planes_and_stream(dc,
+					   array_of_surface_update,
+					   planes_count,
+					   stream,
+					   stream_update);
+}
+
 /**
  * dm_pflip_high_irq() - Handle pageflip interrupt
  * @interrupt_params: ignored
@@ -2684,11 +2713,12 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 				true;
 		}
 
-		dc_update_planes_and_stream(dm->dc,
-			bundle->surface_updates,
-			dc_state->stream_status->plane_count,
-			dc_state->streams[k],
-			&bundle->stream_update);
+		update_planes_and_stream_adapter(dm->dc,
+					 UPDATE_TYPE_FULL,
+					 dc_state->stream_status->plane_count,
+					 dc_state->streams[k],
+					 &bundle->stream_update,
+					 bundle->surface_updates);
 	}
 
 cleanup:
@@ -8200,11 +8230,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				acrtc_state->stream->link->psr_settings.psr_allow_active)
 			amdgpu_dm_psr_disable(acrtc_state->stream);
 
-		dc_update_planes_and_stream(dm->dc,
-					    bundle->surface_updates,
-					    planes_count,
-					    acrtc_state->stream,
-					    &bundle->stream_update);
+		update_planes_and_stream_adapter(dm->dc,
+					 acrtc_state->update_type,
+					 planes_count,
+					 acrtc_state->stream,
+					 &bundle->stream_update,
+					 bundle->surface_updates);
 
 		/**
 		 * Enable or disable the interrupts on the backend.
-- 
2.39.2



