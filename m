Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F1276ADCF
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjHAJdt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjHAJdA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:33:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2567E46BF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:30:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88BB7614FD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D26C433C8;
        Tue,  1 Aug 2023 09:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882245;
        bh=ZUEM5gtuK5KL/3xPXOgeoS+TMs+rf462y61AIhwHGoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXbYhpdnLelBLrWySoFij/LfkmPW1R4Q1MZbGxcSUffG5BcAq+xD7Si5wQwVEPMzg
         ySmV82PMkrVeCdrJKF2GQBk72OiGNPYqmhXrpXVpNA5+XqtmXK4uSRyJZqGn+nrVJM
         S0qpiqZYyJDL4nFdOfCsAYmzD6k0/necoH0liI2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 037/228] drm/amd/display: Copy DC context in the commit streams
Date:   Tue,  1 Aug 2023 11:18:15 +0200
Message-ID: <20230801091924.235954396@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[ Upstream commit 0e986cea0347902b2c72b09c8fe9c0f30d7decb4 ]

DC adds an instance of DML (which contains VBA) to each context, and
multiple threads might write back to the global VBA resulting in data
overwriting. To keep the consistency with other parts of the DC code,
this commit changes dc_commit_streams to copy the current DC state, and
as a result, it also changes the function signature to expect streams
instead of a context.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 59de751e3845 ("drm/amd/display: add ODM case when looking for first split pipe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 41 +++++++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dc.h      |  4 ++-
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a457b87d23c41..31791c557c8f8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1913,23 +1913,44 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	return result;
 }
 
-enum dc_status dc_commit_streams(struct dc *dc, struct dc_state *context)
+/**
+ * dc_commit_streams - Commit current stream state
+ *
+ * @dc: DC object with the commit state to be configured in the hardware
+ * @streams: Array with a list of stream state
+ * @stream_count: Total of streams
+ *
+ * Function responsible for commit streams change to the hardware.
+ *
+ * Return:
+ * Return DC_OK if everything work as expected, otherwise, return a dc_status
+ * code.
+ */
+enum dc_status dc_commit_streams(struct dc *dc,
+				 struct dc_stream_state *streams[],
+				 uint8_t stream_count)
 {
-	enum dc_status res = DC_OK;
 	int i;
+	struct dc_state *context;
+	enum dc_status res = DC_OK;
 
-	if (!streams_changed(dc, context->streams, context->stream_count))
+	if (!streams_changed(dc, streams, stream_count))
 		return res;
 
-	DC_LOG_DC("%s: %d streams\n",
-				__func__, context->stream_count);
+	DC_LOG_DC("%s: %d streams\n", __func__, stream_count);
 
-	for (i = 0; i < context->stream_count; i++) {
-		struct dc_stream_state *stream = context->streams[i];
+	for (i = 0; i < stream_count; i++) {
+		struct dc_stream_state *stream = streams[i];
 
 		dc_stream_log(dc, stream);
 	}
 
+	context = dc_create_state(dc);
+	if (!context)
+		goto context_alloc_fail;
+
+	dc_resource_state_copy_construct_current(dc, context);
+
 	/*
 	 * Previous validation was perfomred with fast_validation = true and
 	 * the full DML state required for hardware programming was skipped.
@@ -1945,6 +1966,10 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_state *context)
 
 	res = dc_commit_state_no_check(dc, context);
 
+context_alloc_fail:
+
+	DC_LOG_DC("%s Finished.\n", __func__);
+
 	return (res == DC_OK);
 }
 
@@ -1960,7 +1985,7 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
 	 * we get more confident about this change we'll need to enable
 	 * the new sequence for all ASICs. */
 	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
-		result = dc_commit_streams(dc, context);
+		result = dc_commit_streams(dc, context->streams, context->stream_count);
 		return result == DC_OK;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3db3554c289b4..78b7dbd23a3b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1326,7 +1326,9 @@ void dc_resource_state_destruct(struct dc_state *context);
 
 bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
 
-enum dc_status dc_commit_streams(struct dc *dc, struct dc_state *context);
+enum dc_status dc_commit_streams(struct dc *dc,
+				 struct dc_stream_state *streams[],
+				 uint8_t stream_count);
 
 /* TODO: When the transition to the new commit sequence is done, remove this
  * function in favor of dc_commit_streams. */
-- 
2.39.2



