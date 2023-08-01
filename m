Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA8A76ADC8
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjHAJdn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjHAJdF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:33:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9BA4200
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A83561507
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674EFC433C9;
        Tue,  1 Aug 2023 09:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882247;
        bh=rDz+xYDGJkjUgseg2h1usRidbWl7V2tmGo4HId7wXMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaA+PO7COshJCNMXZqNjpCX8MMHgp6H32J2L2bTq0K6LecP01CGcmJ3LXnuBE0EcD
         Wvz9zgF3tXlSZpc6nQgoi5i22C75nbMJlT/gOfgcKYmWMF1bddMj3Td+xI6GSTaGRd
         ECXmiZ5BPLdwhy3td4CAjHcRk6+ddl3IjnDjO0o4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 038/228] drm/amd/display: Include surface of unaffected streams
Date:   Tue,  1 Aug 2023 11:18:16 +0200
Message-ID: <20230801091924.270192789@linuxfoundation.org>
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

[ Upstream commit f6ae69f49fcf697b6ffa93d58eb3746897f61cf8 ]

The commit stream function does not include surfaces of unaffected
streams, which may lead to some blank screens during mode change in some
edge cases. This commit adds surfaces of unaffected streams followed by
kernel-doc for documenting some of the fields that participate in this
change.

v2: squash in kerneldoc warning fix (Alex)

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 59de751e3845 ("drm/amd/display: add ODM case when looking for first split pipe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c   | 12 +++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h        | 15 +++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h |  4 ++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 31791c557c8f8..cbbad496cfc63 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1930,9 +1930,10 @@ enum dc_status dc_commit_streams(struct dc *dc,
 				 struct dc_stream_state *streams[],
 				 uint8_t stream_count)
 {
-	int i;
+	int i, j;
 	struct dc_state *context;
 	enum dc_status res = DC_OK;
+	struct dc_validation_set set[MAX_STREAMS] = {0};
 
 	if (!streams_changed(dc, streams, stream_count))
 		return res;
@@ -1941,8 +1942,17 @@ enum dc_status dc_commit_streams(struct dc *dc,
 
 	for (i = 0; i < stream_count; i++) {
 		struct dc_stream_state *stream = streams[i];
+		struct dc_stream_status *status = dc_stream_get_status(stream);
 
 		dc_stream_log(dc, stream);
+
+		set[i].stream = stream;
+
+		if (status) {
+			set[i].plane_count = status->plane_count;
+			for (j = 0; j < status->plane_count; j++)
+				set[i].plane_states[j] = status->plane_states[j];
+		}
 	}
 
 	context = dc_create_state(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 78b7dbd23a3b7..e2c5a68bbc807 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1274,12 +1274,23 @@ void dc_post_update_surfaces_to_stream(
 
 #include "dc_stream.h"
 
-/*
- * Structure to store surface/stream associations for validation
+/**
+ * struct dc_validation_set - Struct to store surface/stream associations for validation
  */
 struct dc_validation_set {
+	/**
+	 * @stream: Stream state properties
+	 */
 	struct dc_stream_state *stream;
+
+	/**
+	 * @plane_state: Surface state
+	 */
 	struct dc_plane_state *plane_states[MAX_SURFACES];
+
+	/**
+	 * @plane_count: Total of active planes
+	 */
 	uint8_t plane_count;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 9e6025c98db91..73dccd485895d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -41,6 +41,10 @@ struct timing_sync_info {
 struct dc_stream_status {
 	int primary_otg_inst;
 	int stream_enc_inst;
+
+	/**
+	 * @plane_count: Total of planes attached to a single stream
+	 */
 	int plane_count;
 	int audio_inst;
 	struct timing_sync_info timing_sync_info;
-- 
2.39.2



