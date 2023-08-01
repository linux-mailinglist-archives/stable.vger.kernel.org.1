Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A3C76ADCE
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjHAJds (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjHAJcg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:32:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650EB44B5
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 017E0614B2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BA2C433C8;
        Tue,  1 Aug 2023 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882239;
        bh=Pz3YqO73rXJKqjcY8D2uZ0PO5Tvlicb3eF3JALTnjMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zb3miEdFHvy47dahOl6e1JAwBABmFwEiX43imE3t6nmEQMAlXvwcE/sS6R852hGCW
         +qd489D/lWDBnRTbha7UfUL4kQ5pLTWAdMpoOYN9Ij8F1mGaXHeUCEbypLV5DGCcbe
         iOltPrb34tlo3oXnQxhbTKo6OwvoHJ6BLGHIq70o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 035/228] drm/amd/display: Rework context change check
Date:   Tue,  1 Aug 2023 11:18:13 +0200
Message-ID: <20230801091924.160281645@linuxfoundation.org>
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

[ Upstream commit 10fdb0a11c555e0d6f7698d2874581d06e99ee71 ]

Context change is all about streams; for this reason, this commit
renames context_changed to streams_changed. Additionally, to make this
function more flexible, this commit changes the function signature to
receive the stream array and the stream count as a parameter.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 59de751e3845 ("drm/amd/display: add ODM case when looking for first split pipe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index beb2d7f103c58..226c17e78d3e1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1505,19 +1505,19 @@ static void program_timing_sync(
 	}
 }
 
-static bool context_changed(
-		struct dc *dc,
-		struct dc_state *context)
+static bool streams_changed(struct dc *dc,
+			    struct dc_stream_state *streams[],
+			    uint8_t stream_count)
 {
 	uint8_t i;
 
-	if (context->stream_count != dc->current_state->stream_count)
+	if (stream_count != dc->current_state->stream_count)
 		return true;
 
 	for (i = 0; i < dc->current_state->stream_count; i++) {
-		if (dc->current_state->streams[i] != context->streams[i])
+		if (dc->current_state->streams[i] != streams[i])
 			return true;
-		if (!context->streams[i]->link->link_state_valid)
+		if (!streams[i]->link->link_state_valid)
 			return true;
 	}
 
@@ -1918,7 +1918,7 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
 	enum dc_status result = DC_ERROR_UNEXPECTED;
 	int i;
 
-	if (!context_changed(dc, context))
+	if (!streams_changed(dc, context->streams, context->stream_count))
 		return DC_OK;
 
 	DC_LOG_DC("%s: %d streams\n",
-- 
2.39.2



