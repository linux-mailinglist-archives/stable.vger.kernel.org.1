Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20B677AC91
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjHMVeg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjHMVeg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:34:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEEE10FA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5BA862CA8
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93CDC433C7;
        Sun, 13 Aug 2023 21:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962475;
        bh=RRio2eXgpITEC/WhEUtqwNjVbX3B+00Ww7rxKpIv3Xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhy7XQ1G7TSpOKeBDYPFKQFgY3JZRFqG6kETMRZkozYhzuHsqLsOKfjRM8C7MyH1o
         8UM8D5SuRoUBbXcBROHzAhV3sceXIyiZao+3G/HvNG9WOhrIqNdKim1NKI3FIggO5p
         dg5QDMXuzeiKa92MqkcQkPRglOXVt62NDKVfGse0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 042/149] drm/amd/display: Add function for validate and update new stream
Date:   Sun, 13 Aug 2023 23:18:07 +0200
Message-ID: <20230813211720.070986407@linuxfoundation.org>
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

commit a5e39ae27c3a305c6aafc0e423b0cb2c677facde upstream

DC stream can be seen as a representation of the DCN backend or the data
struct that represents the center of the display pipeline. The front end
(i.e., planes) is connected to the DC stream, and in its turn, streams
are connected to the DC link. Due to this dynamic, DC must handle the
following scenarios:

1. A stream is removed;
2. A new stream is created;
3. An unchanged stream had some updates on its planes.

These combinations require that the new stream data struct become
updated and has a valid global state. For handling multiple corner cases
associated with stream operations, this commit introduces a function
dedicated to manipulating stream changes and invokes the state
validation function after that.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          |   16 -
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c |  219 +++++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h               |    6 
 3 files changed, 227 insertions(+), 14 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1987,21 +1987,17 @@ enum dc_status dc_commit_streams(struct
 
 	dc_resource_state_copy_construct_current(dc, context);
 
-	/*
-	 * Previous validation was perfomred with fast_validation = true and
-	 * the full DML state required for hardware programming was skipped.
-	 *
-	 * Re-validate here to calculate these parameters / watermarks.
-	 */
-	res = dc_validate_global_state(dc, context, false);
+	res = dc_validate_with_context(dc, set, stream_count, context, false);
 	if (res != DC_OK) {
-		DC_LOG_ERROR("DC commit global validation failure: %s (%d)",
-			     dc_status_to_str(res), res);
-		return res;
+		BREAK_TO_DEBUGGER();
+		goto fail;
 	}
 
 	res = dc_commit_state_no_check(dc, context);
 
+fail:
+	dc_release_state(context);
+
 context_alloc_fail:
 
 	DC_LOG_DC("%s Finished.\n", __func__);
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2616,15 +2616,226 @@ bool dc_resource_is_dsc_encoding_support
 	return dc->res_pool->res_cap->num_dsc > 0;
 }
 
+static bool planes_changed_for_existing_stream(struct dc_state *context,
+					       struct dc_stream_state *stream,
+					       const struct dc_validation_set set[],
+					       int set_count)
+{
+	int i, j;
+	struct dc_stream_status *stream_status = NULL;
+
+	for (i = 0; i < context->stream_count; i++) {
+		if (context->streams[i] == stream) {
+			stream_status = &context->stream_status[i];
+			break;
+		}
+	}
+
+	if (!stream_status)
+		ASSERT(0);
+
+	for (i = 0; i < set_count; i++)
+		if (set[i].stream == stream)
+			break;
+
+	if (i == set_count)
+		ASSERT(0);
+
+	if (set[i].plane_count != stream_status->plane_count)
+		return true;
+
+	for (j = 0; j < set[i].plane_count; j++)
+		if (set[i].plane_states[j] != stream_status->plane_states[j])
+			return true;
+
+	return false;
+}
 
 /**
- * dc_validate_global_state() - Determine if HW can support a given state
- * Checks HW resource availability and bandwidth requirement.
+ * dc_validate_with_context - Validate and update the potential new stream in the context object
+ *
+ * @dc: Used to get the current state status
+ * @set: An array of dc_validation_set with all the current streams reference
+ * @set_count: Total of streams
+ * @context: New context
+ * @fast_validate: Enable or disable fast validation
+ *
+ * This function updates the potential new stream in the context object. It
+ * creates multiple lists for the add, remove, and unchanged streams. In
+ * particular, if the unchanged streams have a plane that changed, it is
+ * necessary to remove all planes from the unchanged streams. In summary, this
+ * function is responsible for validating the new context.
+ *
+ * Return:
+ * In case of success, return DC_OK (1), otherwise, return a DC error.
+ */
+enum dc_status dc_validate_with_context(struct dc *dc,
+					const struct dc_validation_set set[],
+					int set_count,
+					struct dc_state *context,
+					bool fast_validate)
+{
+	struct dc_stream_state *unchanged_streams[MAX_PIPES] = { 0 };
+	struct dc_stream_state *del_streams[MAX_PIPES] = { 0 };
+	struct dc_stream_state *add_streams[MAX_PIPES] = { 0 };
+	int old_stream_count = context->stream_count;
+	enum dc_status res = DC_ERROR_UNEXPECTED;
+	int unchanged_streams_count = 0;
+	int del_streams_count = 0;
+	int add_streams_count = 0;
+	bool found = false;
+	int i, j, k;
+
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	/* First build a list of streams to be remove from current context */
+	for (i = 0; i < old_stream_count; i++) {
+		struct dc_stream_state *stream = context->streams[i];
+
+		for (j = 0; j < set_count; j++) {
+			if (stream == set[j].stream) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			del_streams[del_streams_count++] = stream;
+
+		found = false;
+	}
+
+	/* Second, build a list of new streams */
+	for (i = 0; i < set_count; i++) {
+		struct dc_stream_state *stream = set[i].stream;
+
+		for (j = 0; j < old_stream_count; j++) {
+			if (stream == context->streams[j]) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			add_streams[add_streams_count++] = stream;
+
+		found = false;
+	}
+
+	/* Build a list of unchanged streams which is necessary for handling
+	 * planes change such as added, removed, and updated.
+	 */
+	for (i = 0; i < set_count; i++) {
+		/* Check if stream is part of the delete list */
+		for (j = 0; j < del_streams_count; j++) {
+			if (set[i].stream == del_streams[j]) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			/* Check if stream is part of the add list */
+			for (j = 0; j < add_streams_count; j++) {
+				if (set[i].stream == add_streams[j]) {
+					found = true;
+					break;
+				}
+			}
+		}
+
+		if (!found)
+			unchanged_streams[unchanged_streams_count++] = set[i].stream;
+
+		found = false;
+	}
+
+	/* Remove all planes for unchanged streams if planes changed */
+	for (i = 0; i < unchanged_streams_count; i++) {
+		if (planes_changed_for_existing_stream(context,
+						       unchanged_streams[i],
+						       set,
+						       set_count)) {
+			if (!dc_rem_all_planes_for_stream(dc,
+							  unchanged_streams[i],
+							  context)) {
+				res = DC_FAIL_DETACH_SURFACES;
+				goto fail;
+			}
+		}
+	}
+
+	/* Remove all planes for removed streams and then remove the streams */
+	for (i = 0; i < del_streams_count; i++) {
+		/* Need to cpy the dwb data from the old stream in order to efc to work */
+		if (del_streams[i]->num_wb_info > 0) {
+			for (j = 0; j < add_streams_count; j++) {
+				if (del_streams[i]->sink == add_streams[j]->sink) {
+					add_streams[j]->num_wb_info = del_streams[i]->num_wb_info;
+					for (k = 0; k < del_streams[i]->num_wb_info; k++)
+						add_streams[j]->writeback_info[k] = del_streams[i]->writeback_info[k];
+				}
+			}
+		}
+
+		if (!dc_rem_all_planes_for_stream(dc, del_streams[i], context)) {
+			res = DC_FAIL_DETACH_SURFACES;
+			goto fail;
+		}
+
+		res = dc_remove_stream_from_ctx(dc, context, del_streams[i]);
+		if (res != DC_OK)
+			goto fail;
+	}
+
+	/* Add new streams and then add all planes for the new stream */
+	for (i = 0; i < add_streams_count; i++) {
+		calculate_phy_pix_clks(add_streams[i]);
+		res = dc_add_stream_to_ctx(dc, context, add_streams[i]);
+		if (res != DC_OK)
+			goto fail;
+
+		if (!add_all_planes_for_stream(dc, add_streams[i], set, set_count, context)) {
+			res = DC_FAIL_ATTACH_SURFACES;
+			goto fail;
+		}
+	}
+
+	/* Add all planes for unchanged streams if planes changed */
+	for (i = 0; i < unchanged_streams_count; i++) {
+		if (planes_changed_for_existing_stream(context,
+						       unchanged_streams[i],
+						       set,
+						       set_count)) {
+			if (!add_all_planes_for_stream(dc, unchanged_streams[i], set, set_count, context)) {
+				res = DC_FAIL_ATTACH_SURFACES;
+				goto fail;
+			}
+		}
+	}
+
+	res = dc_validate_global_state(dc, context, fast_validate);
+
+fail:
+	if (res != DC_OK)
+		DC_LOG_WARNING("%s:resource validation failed, dc_status:%d\n",
+			       __func__,
+			       res);
+
+	return res;
+}
+
+/**
+ * dc_validate_global_state() - Determine if hardware can support a given state
+ *
  * @dc: dc struct for this driver
  * @new_ctx: state to be validated
  * @fast_validate: set to true if only yes/no to support matters
  *
- * Return: DC_OK if the result can be programmed.  Otherwise, an error code.
+ * Checks hardware resource availability and bandwidth requirement.
+ *
+ * Return:
+ * DC_OK if the result can be programmed. Otherwise, an error code.
  */
 enum dc_status dc_validate_global_state(
 		struct dc *dc,
@@ -3757,4 +3968,4 @@ bool dc_resource_acquire_secondary_pipe_
 	}
 
 	return true;
-}
\ No newline at end of file
+}
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1298,6 +1298,12 @@ enum dc_status dc_validate_plane(struct
 
 void get_clock_requirements_for_state(struct dc_state *state, struct AsicStateEx *info);
 
+enum dc_status dc_validate_with_context(struct dc *dc,
+					const struct dc_validation_set set[],
+					int set_count,
+					struct dc_state *context,
+					bool fast_validate);
+
 bool dc_set_generic_gpio_for_stereo(bool enable,
 		struct gpio_service *gpio_service);
 


