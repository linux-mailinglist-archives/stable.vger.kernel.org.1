Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B461876ADD1
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjHAJdu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjHAJdD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:33:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60283A8E
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4DC2614FC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0319C433C8;
        Tue,  1 Aug 2023 09:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882242;
        bh=/ArQNZo8tyONr7yReGwjuNQOVX4Ox1yYPYDCocFzzgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdfxqIxMggD//jjRRwsMS89OQj6kZ6cnJTu4CPk7QWm1pkGr9mewWpHeU+gIcYwA3
         8V7aUSvIU2fu15fBP+Bs4xkFnW6Q8AQAD8yR3eObdbIBD3Cfd/WidbqkCDfiqMdfgb
         i0Oy0ighnDS7tjaUIDl9lKuwFZU50PYre78wbLo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 036/228] drm/amd/display: Enable new commit sequence only for DCN32x
Date:   Tue,  1 Aug 2023 11:18:14 +0200
Message-ID: <20230801091924.198196978@linuxfoundation.org>
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

[ Upstream commit 7b36f4d18e3e4941d12fe027ad6ad6123c257027 ]

Change commit sequence will impact all ASICs. It is prudent to run this
update in small steps to keep issues under control and avoid any
potential regression. With this idea in mind, this commit is preparation
work for the complete transition to the new commit sequence. To maintain
this change manageable across multiple ASICs, this commit adds a new
function named dc_commit_streams which is a copy of the dc_commit_state
with some minor changes. Finally, inside the dc_commit_state, we check
if we are using DCN32x or above and enable the new sequence only for
those devices.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 59de751e3845 ("drm/amd/display: add ODM case when looking for first split pipe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 46 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h      | 13 +++----
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 226c17e78d3e1..a457b87d23c41 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1913,11 +1913,57 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	return result;
 }
 
+enum dc_status dc_commit_streams(struct dc *dc, struct dc_state *context)
+{
+	enum dc_status res = DC_OK;
+	int i;
+
+	if (!streams_changed(dc, context->streams, context->stream_count))
+		return res;
+
+	DC_LOG_DC("%s: %d streams\n",
+				__func__, context->stream_count);
+
+	for (i = 0; i < context->stream_count; i++) {
+		struct dc_stream_state *stream = context->streams[i];
+
+		dc_stream_log(dc, stream);
+	}
+
+	/*
+	 * Previous validation was perfomred with fast_validation = true and
+	 * the full DML state required for hardware programming was skipped.
+	 *
+	 * Re-validate here to calculate these parameters / watermarks.
+	 */
+	res = dc_validate_global_state(dc, context, false);
+	if (res != DC_OK) {
+		DC_LOG_ERROR("DC commit global validation failure: %s (%d)",
+			     dc_status_to_str(res), res);
+		return res;
+	}
+
+	res = dc_commit_state_no_check(dc, context);
+
+	return (res == DC_OK);
+}
+
+/* TODO: When the transition to the new commit sequence is done, remove this
+ * function in favor of dc_commit_streams. */
 bool dc_commit_state(struct dc *dc, struct dc_state *context)
 {
 	enum dc_status result = DC_ERROR_UNEXPECTED;
 	int i;
 
+	/* TODO: Since change commit sequence can have a huge impact,
+	 * we decided to only enable it for DCN3x. However, as soon as
+	 * we get more confident about this change we'll need to enable
+	 * the new sequence for all ASICs. */
+	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
+		result = dc_commit_streams(dc, context);
+		return result == DC_OK;
+	}
+
 	if (!streams_changed(dc, context->streams, context->stream_count))
 		return DC_OK;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3f277009075fd..3db3554c289b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1326,15 +1326,10 @@ void dc_resource_state_destruct(struct dc_state *context);
 
 bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
 
-/*
- * TODO update to make it about validation sets
- * Set up streams and links associated to drive sinks
- * The streams parameter is an absolute set of all active streams.
- *
- * After this call:
- *   Phy, Encoder, Timing Generator are programmed and enabled.
- *   New streams are enabled with blank stream; no memory read.
- */
+enum dc_status dc_commit_streams(struct dc *dc, struct dc_state *context);
+
+/* TODO: When the transition to the new commit sequence is done, remove this
+ * function in favor of dc_commit_streams. */
 bool dc_commit_state(struct dc *dc, struct dc_state *context);
 
 struct dc_state *dc_create_state(struct dc *dc);
-- 
2.39.2



