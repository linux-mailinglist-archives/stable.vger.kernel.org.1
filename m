Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F328075520F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjGPUDV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjGPUDU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:03:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55949D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D4C760EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7270BC433C8;
        Sun, 16 Jul 2023 20:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537798;
        bh=QFKmsfYYypIQ0wETuJ1Aa2G3BmhLZCKvcY/Tc/GbVto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zl//nuAcBFB8v0UQjomXq1LtehaAtxLGpoQa7o7ovnqVnD/5qkDnArj1SMPJ6qjhF
         f+pPzmsxPVdXcloHOHU67LB//uQ3aojX8/vyIQkN1vvLPJx131xPwZ0qpADQZ77zVp
         TwDSaXWkSMvk66DQC7i6VJ8zlrV9TD+qG7MG5nmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 225/800] drm/amd/display: fix is_timing_changed() prototype
Date:   Sun, 16 Jul 2023 21:41:18 +0200
Message-ID: <20230716194954.318045655@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 3306ba4b60b2f3d9ac6bddc587a4d702e1ba2224 ]

Three functions in the amdgpu display driver cause -Wmissing-prototype
warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1858:6: error: no previous prototype for 'is_timing_changed' [-Werror=missing-prototypes]

is_timing_changed() is actually meant to be a global symbol, but needs
a proper name and prototype.

Fixes: 17ce8a6907f7 ("drm/amd/display: Add dsc pre-validation in atomic check")
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5 ++---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 6 +++---
 drivers/gpu/drm/amd/display/dc/dc.h                         | 3 +++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 810ab682f424f..46d0a8f57e552 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -45,8 +45,7 @@
 #endif
 
 #include "dc/dcn20/dcn20_resource.h"
-bool is_timing_changed(struct dc_stream_state *cur_stream,
-		       struct dc_stream_state *new_stream);
+
 #define PEAK_FACTOR_X1000 1006
 
 static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
@@ -1422,7 +1421,7 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 		struct dc_stream_state *stream = dm_state->context->streams[i];
 
 		if (local_dc_state->streams[i] &&
-		    is_timing_changed(stream, local_dc_state->streams[i])) {
+		    dc_is_timing_changed(stream, local_dc_state->streams[i])) {
 			DRM_INFO_ONCE("crtc[%d] needs mode_changed\n", i);
 		} else {
 			int ind = find_crtc_index_in_state_by_stream(state, stream);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index fe1551393b264..ba3eb36e75bc3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1878,7 +1878,7 @@ bool dc_add_all_planes_for_stream(
 	return add_all_planes_for_stream(dc, stream, &set, 1, context);
 }
 
-bool is_timing_changed(struct dc_stream_state *cur_stream,
+bool dc_is_timing_changed(struct dc_stream_state *cur_stream,
 		       struct dc_stream_state *new_stream)
 {
 	if (cur_stream == NULL)
@@ -1903,7 +1903,7 @@ static bool are_stream_backends_same(
 	if (stream_a == NULL || stream_b == NULL)
 		return false;
 
-	if (is_timing_changed(stream_a, stream_b))
+	if (dc_is_timing_changed(stream_a, stream_b))
 		return false;
 
 	if (stream_a->signal != stream_b->signal)
@@ -3528,7 +3528,7 @@ bool pipe_need_reprogram(
 	if (pipe_ctx_old->stream_res.stream_enc != pipe_ctx->stream_res.stream_enc)
 		return true;
 
-	if (is_timing_changed(pipe_ctx_old->stream, pipe_ctx->stream))
+	if (dc_is_timing_changed(pipe_ctx_old->stream, pipe_ctx->stream))
 		return true;
 
 	if (pipe_ctx_old->stream->dpms_off != pipe_ctx->stream->dpms_off)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 30f0ba05a6e6c..4d93ca9c627b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2226,4 +2226,7 @@ void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
 /* Disable acc mode Interfaces */
 void dc_disable_accelerated_mode(struct dc *dc);
 
+bool dc_is_timing_changed(struct dc_stream_state *cur_stream,
+		       struct dc_stream_state *new_stream);
+
 #endif /* DC_INTERFACE_H_ */
-- 
2.39.2



