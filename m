Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21EA7CA37A
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjJPJGl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjJPJGk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:06:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C4095
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:06:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EABC433CC;
        Mon, 16 Oct 2023 09:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697447198;
        bh=i22vy0oegiiLPSQ0ORzujqN8B00tRnRG3CzxTTPFPF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcY5GzmJ4PRhjNWmKUHi6/jMraTnez6OCBGC8vZujX7AljNjtuALtHFdoO6P31Gdg
         DMe1ijcbO9SLuMfTVftH7zRTZuNRth9zIvae4dYAlgfUBbaAUzG097qnpPTcMuyyYh
         6lJq409RHi9wyDpNLkXNU4UoVR3kruBexyQFt408=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jun Lei <jun.lei@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.5 011/191] drm/amd/display: implement pipe type definition and adding accessors
Date:   Mon, 16 Oct 2023 10:39:56 +0200
Message-ID: <20231016084015.666849889@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenjing Liu <wenjing.liu@amd.com>

commit 53f3288079460ec7c86a39871af5c8b2a5d48685 upstream.

[why]
There is a lack of encapsulation of pipe connection representation in pipe context.
This has caused many challenging bugs and coding errors with repeated
logic to identify the same pipe type.

[how]
Formally define pipe types and provide getters to identify a pipe type and
find a pipe based on specific requirements. Update existing logic in non dcn
specific files and dcn32 and future versions to use the new accessors.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Reduced to only introduce resource_is_pipe_type() to make candidate for stable 6.5.y. ]
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c |   35 +++++++
 drivers/gpu/drm/amd/display/dc/inc/resource.h     |  106 ++++++++++++++++++++++
 2 files changed, 141 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1348,6 +1348,41 @@ struct pipe_ctx *find_idle_secondary_pip
 	return secondary_pipe;
 }
 
+bool resource_is_pipe_type(const struct pipe_ctx *pipe_ctx, enum pipe_type type)
+{
+#ifdef DBG
+	if (pipe_ctx->stream == NULL) {
+		/* a free pipe with dangling states */
+		ASSERT(!pipe_ctx->plane_state);
+		ASSERT(!pipe_ctx->prev_odm_pipe);
+		ASSERT(!pipe_ctx->next_odm_pipe);
+		ASSERT(!pipe_ctx->top_pipe);
+		ASSERT(!pipe_ctx->bottom_pipe);
+	} else if (pipe_ctx->top_pipe) {
+		/* a secondary DPP pipe must be signed to a plane */
+		ASSERT(pipe_ctx->plane_state)
+	}
+	/* Add more checks here to prevent corrupted pipe ctx. It is very hard
+	* to debug this issue afterwards because we can't pinpoint the code
+	* location causing inconsistent pipe context states.
+	*/
+#endif
+	switch (type) {
+	case OTG_MASTER:
+		return !pipe_ctx->prev_odm_pipe &&
+				!pipe_ctx->top_pipe &&
+				pipe_ctx->stream;
+	case OPP_HEAD:
+		return !pipe_ctx->top_pipe && pipe_ctx->stream;
+	case DPP_PIPE:
+		return pipe_ctx->plane_state && pipe_ctx->stream;
+	case FREE_PIPE:
+		return !pipe_ctx->plane_state && !pipe_ctx->stream;
+	default:
+		return false;
+	}
+}
+
 struct pipe_ctx *resource_get_head_pipe_for_stream(
 		struct resource_context *res_ctx,
 		struct dc_stream_state *stream)
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -153,6 +153,112 @@ bool resource_attach_surfaces_to_context
 		struct dc_state *context,
 		const struct resource_pool *pool);
 
+/*
+ * pipe types are identified based on MUXes in DCN front end that are capable
+ * of taking input from one DCN pipeline to another DCN pipeline. The name is
+ * in a form of XXXX_YYYY, where XXXX is the DCN front end hardware block the
+ * pipeline ends with and YYYY is the rendering role that the pipe is in.
+ *
+ * For instance OTG_MASTER is a pipe ending with OTG hardware block in its
+ * pipeline and it is in a role of a master pipe for timing generation.
+ *
+ * For quick reference a diagram of each pipe type's areas of responsibility
+ * for outputting timings on the screen is shown below:
+ *
+ *       Timing Active for Stream 0
+ *        __________________________________________________
+ *       |OTG master 0 (OPP head 0)|OPP head 2 (DPP pipe 2) |
+ *       |             (DPP pipe 0)|                        |
+ *       | Top Plane 0             |                        |
+ *       |           ______________|____                    |
+ *       |          |DPP pipe 1    |DPP |                   |
+ *       |          |              |pipe|                   |
+ *       |          |  Bottom      |3   |                   |
+ *       |          |  Plane 1     |    |                   |
+ *       |          |              |    |                   |
+ *       |          |______________|____|                   |
+ *       |                         |                        |
+ *       |                         |                        |
+ *       | ODM slice 0             | ODM slice 1            |
+ *       |_________________________|________________________|
+ *
+ *       Timing Active for Stream 1
+ *        __________________________________________________
+ *       |OTG master 4 (OPP head 4)                         |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |               Blank Pixel Data                   |
+ *       |              (generated by DPG4)                 |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |__________________________________________________|
+ *
+ *       Inter-pipe Relation
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------MPC---------ODM----------- |
+ *       |        |  plane 1    | |         | |             |
+ *       |   1    | ------------- |         | |             |
+ *       |        |  plane 0      | slice 1 | |             |
+ *       |   2    | -------------MPC--------- |             |
+ *       |        |  plane 1    | |           |             |
+ *       |   3    | ------------- |           |             |
+ *       |        |               | blank     |             |
+ *       |   4    |               | ----------------------- |
+ *       |        |               |           |             |
+ *       |   5    |  (FREE)       |           |             |
+ *       |________|_______________|___________|_____________|
+ */
+enum pipe_type {
+	/* free pipe - free pipe is an uninitialized pipe without a stream
+	* associated with it. It is a free DCN pipe resource. It can be
+	* acquired as any type of pipe.
+	*/
+	FREE_PIPE,
+
+	/* OTG master pipe - the master pipe of its OPP head pipes with a
+	* functional OTG. It merges all its OPP head pipes pixel data in ODM
+	* block and output to backend DIG. OTG master pipe is responsible for
+	* generating entire crtc timing to backend DIG. An OTG master pipe may
+	* or may not have a plane. If it has a plane it blends it as the left
+	* most MPC slice of the top most layer. If it doesn't have a plane it
+	* can output pixel data from its OPP head pipes' test pattern
+	* generators (DPG) such as solid black pixel data to blank the screen.
+	*/
+	OTG_MASTER,
+
+	/* OPP head pipe - the head pipe of an MPC blending tree with a
+	* functional OPP outputting to an OTG. OPP head pipe is responsible for
+	* processing output pixels in its own ODM slice. It may or may not have
+	* a plane. If it has a plane it blends it as the top most layer within
+	* its own ODM slice. If it doesn't have a plane it can output pixel
+	* data from its DPG such as solid black pixel data to blank the pixel
+	* data in its own ODM slice. OTG master pipe is also an OPP head pipe
+	* but with more responsibility.
+	*/
+	OPP_HEAD,
+
+	/* DPP pipe - the pipe with a functional DPP outputting to an OPP head
+	* pipe's MPC. DPP pipe is responsible for processing pixel data from
+	* its own MPC slice of a plane. It must be connected to an OPP head
+	* pipe and it must have a plane associated with it.
+	*/
+	DPP_PIPE,
+};
+
+/*
+ * Determine if the input pipe ctx is of a pipe type.
+ * return - true if pipe ctx is of the input type.
+ */
+bool resource_is_pipe_type(const struct pipe_ctx *pipe_ctx, enum pipe_type type);
+
 struct pipe_ctx *find_idle_secondary_pipe(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,


