Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F8C77AC94
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjHMVen (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjHMVen (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C73310DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1290F62CB6
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9D5C433C8;
        Sun, 13 Aug 2023 21:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962483;
        bh=S7kcNkwOY/aLyZ5rLqk9v5gRpyt1q4Um99CFQVNDPW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVd58UsRiIz6GBsT754gzxfW//SRf1AhWVF4Ge2L6rdi7Jd55Dzr5HoYM1HMsxWB9
         ij9tIoslD8N1amGymMrjqHGqQXHtPeHajK5n99v12WSqBv19TjgMEzXAiMzOQSWcV0
         dpBtGKRa5ePwcjzfejuK3ZN6VhOG1c5x5Jgko/sI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 045/149] drm/amd/display: Avoid ABM when ODM combine is enabled for eDP
Date:   Sun, 13 Aug 2023 23:18:10 +0200
Message-ID: <20230813211720.164608726@linuxfoundation.org>
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

commit 7fffb03b4045c862f904a88b852dc509c4e46406 upstream

ODM to combine on the eDP panel with ABM causes the color difference to
the panel since the ABM module only sets one pipe. Hence, this commit
blocks ABM in case of ODM combined on eDP.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1996,9 +1996,19 @@ enum dc_status dc_commit_streams(struct
 	res = dc_commit_state_no_check(dc, context);
 
 	for (i = 0; i < stream_count; i++) {
-		for (j = 0; j < context->stream_count; j++)
+		for (j = 0; j < context->stream_count; j++) {
 			if (streams[i]->stream_id == context->streams[j]->stream_id)
 				streams[i]->out.otg_offset = context->stream_status[j].primary_otg_inst;
+
+			if (dc_is_embedded_signal(streams[i]->signal)) {
+				struct dc_stream_status *status = dc_stream_get_status_from_state(context, streams[i]);
+
+				if (dc->hwss.is_abm_supported)
+					status->is_abm_supported = dc->hwss.is_abm_supported(dc, context, streams[i]);
+				else
+					status->is_abm_supported = true;
+			}
+		}
 	}
 
 fail:


