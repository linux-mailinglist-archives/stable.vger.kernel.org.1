Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF9D73E89A
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjFZS13 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjFZS1O (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:27:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5AC9B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDF2A60F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85BAC433C8;
        Mon, 26 Jun 2023 18:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804004;
        bh=7aqut26EGQ+mODKBZ+s4r/H1RUE9kewyP+rKBlcRevA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aetk1jtALINDeo9K4RjQ3HRsug+jjulnYMgCVIc8jJUpng+k3Mk9CtNHfARkpYPNl
         RQshK8FEgBXRBIR1/9Pb/0/mTPuagRmsIyFM6SYxRixm/LU/I3jKbIKvP7PcaAdSpd
         mJhQ4jKj8h6Y62KLpWueFsVkdGkho82kH4mned7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <Harry.Wentland@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 001/170] drm/amd/display: Use dc_update_planes_and_stream
Date:   Mon, 26 Jun 2023 20:09:30 +0200
Message-ID: <20230626180800.552644952@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

[ Upstream commit f7511289821ffccc07579406d6ab520aa11049f5 ]

[Why & How]
The old dc_commit_updates_for_stream lacks manipulation for many corner
cases where the DC feature requires special attention; as a result, it
starts to show its limitation (e.g., the SubVP feature is not supported
by it, among other cases). To modernize and unify our internal API, this
commit replaces the old dc_commit_updates_for_stream with
dc_update_planes_and_stream, which has more features.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 53687de6c0530..a7bc57529e6c9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2632,10 +2632,12 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 			bundle->surface_updates[m].surface->force_full_update =
 				true;
 		}
-		dc_commit_updates_for_stream(
-			dm->dc, bundle->surface_updates,
+
+		dc_update_planes_and_stream(dm->dc,
+			bundle->surface_updates,
 			dc_state->stream_status->plane_count,
-			dc_state->streams[k], &bundle->stream_update, dc_state);
+			dc_state->streams[k],
+			&bundle->stream_update);
 	}
 
 cleanup:
@@ -7887,12 +7889,11 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				acrtc_state->stream->link->psr_settings.psr_allow_active)
 			amdgpu_dm_psr_disable(acrtc_state->stream);
 
-		dc_commit_updates_for_stream(dm->dc,
-						     bundle->surface_updates,
-						     planes_count,
-						     acrtc_state->stream,
-						     &bundle->stream_update,
-						     dc_state);
+		dc_update_planes_and_stream(dm->dc,
+					    bundle->surface_updates,
+					    planes_count,
+					    acrtc_state->stream,
+					    &bundle->stream_update);
 
 		/**
 		 * Enable or disable the interrupts on the backend.
@@ -8334,12 +8335,11 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 
 		mutex_lock(&dm->dc_lock);
-		dc_commit_updates_for_stream(dm->dc,
-						     dummy_updates,
-						     status->plane_count,
-						     dm_new_crtc_state->stream,
-						     &stream_update,
-						     dc_state);
+		dc_update_planes_and_stream(dm->dc,
+					    dummy_updates,
+					    status->plane_count,
+					    dm_new_crtc_state->stream,
+					    &stream_update);
 		mutex_unlock(&dm->dc_lock);
 	}
 
-- 
2.39.2



