Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9398E77AC97
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjHMVev (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjHMVeu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:34:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7646810DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CB4C62CC1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5FDC433C8;
        Sun, 13 Aug 2023 21:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962491;
        bh=EmbxsBuCkcU+lYKuhLcxhIQzZy3XmS69MODAfip8cDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgDEnq7sMuk7D3H2dQx+Ke927XMufWLPCC5Ny86ixpiRcPDMT9RUIRy5XkzkGA4Aw
         /Dlr21yBilyGnGevDxqT8Xul6NW6mMdMWtXk6RbyNP35lUvQKnmbg6annQb03NU7ME
         imWHQ3ucXyqTZ0tmfT6TiCEOMHyvJNqECZtgXF0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jun Lei <Jun.Lei@amd.com>,
        Brian Chang <Brian.Chang@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 048/149] drm/amd/display: Retain phantom plane/stream if validation fails
Date:   Sun, 13 Aug 2023 23:18:13 +0200
Message-ID: <20230813211720.256674641@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alvin Lee <Alvin.Lee2@amd.com>

commit 9b216b7e38f5381bcc3ad21c5ac614aa577ab8f2 upstream

[Description]
- If we fail validation, we should retain the phantom
  stream/planes
- Full updates assume that phantom pipes will be fully
  removed, but if validation fails we keep the phantom
  pipes
- Therefore we have to retain the plane/stream if validation
  fails (since the refcount is decremented before validation,
  and the expectation is that it's fully freed when the  old
  dc_state is released)

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                |   13 +++++++++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   |   22 ++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h   |    3 ++
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c |    1 
 drivers/gpu/drm/amd/display/dc/inc/core_types.h         |    1 
 5 files changed, 40 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3149,6 +3149,19 @@ static bool update_planes_and_stream_sta
 
 	if (update_type == UPDATE_TYPE_FULL) {
 		if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
+			/* For phantom pipes we remove and create a new set of phantom pipes
+			 * for each full update (because we don't know if we'll need phantom
+			 * pipes until after the first round of validation). However, if validation
+			 * fails we need to keep the existing phantom pipes (because we don't update
+			 * the dc->current_state).
+			 *
+			 * The phantom stream/plane refcount is decremented for validation because
+			 * we assume it'll be removed (the free comes when the dc_state is freed),
+			 * but if validation fails we have to increment back the refcount so it's
+			 * consistent.
+			 */
+			if (dc->res_pool->funcs->retain_phantom_pipes)
+				dc->res_pool->funcs->retain_phantom_pipes(dc, dc->current_state);
 			BREAK_TO_DEBUGGER();
 			goto fail;
 		}
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1719,6 +1719,27 @@ static struct dc_stream_state *dcn32_ena
 	return phantom_stream;
 }
 
+void dcn32_retain_phantom_pipes(struct dc *dc, struct dc_state *context)
+{
+	int i;
+	struct dc_plane_state *phantom_plane = NULL;
+	struct dc_stream_state *phantom_stream = NULL;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->top_pipe && !pipe->prev_odm_pipe &&
+				pipe->plane_state && pipe->stream &&
+				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+			phantom_plane = pipe->plane_state;
+			phantom_stream = pipe->stream;
+
+			dc_plane_state_retain(phantom_plane);
+			dc_stream_retain(phantom_stream);
+		}
+	}
+}
+
 // return true if removed piped from ctx, false otherwise
 bool dcn32_remove_phantom_pipes(struct dc *dc, struct dc_state *context)
 {
@@ -2035,6 +2056,7 @@ static struct resource_funcs dcn32_res_p
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.remove_phantom_pipes = dcn32_remove_phantom_pipes,
+	.retain_phantom_pipes = dcn32_retain_phantom_pipes,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -83,6 +83,9 @@ bool dcn32_release_post_bldn_3dlut(
 bool dcn32_remove_phantom_pipes(struct dc *dc,
 		struct dc_state *context);
 
+void dcn32_retain_phantom_pipes(struct dc *dc,
+		struct dc_state *context);
+
 void dcn32_add_phantom_pipes(struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1619,6 +1619,7 @@ static struct resource_funcs dcn321_res_
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.remove_phantom_pipes = dcn32_remove_phantom_pipes,
+	.retain_phantom_pipes = dcn32_retain_phantom_pipes,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -234,6 +234,7 @@ struct resource_funcs {
             unsigned int index);
 
 	bool (*remove_phantom_pipes)(struct dc *dc, struct dc_state *context);
+	void (*retain_phantom_pipes)(struct dc *dc, struct dc_state *context);
 	void (*get_panel_config_defaults)(struct dc_panel_config *panel_config);
 };
 


