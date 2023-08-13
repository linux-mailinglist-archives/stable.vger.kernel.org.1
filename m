Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B5E77AC92
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjHMVek (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjHMVej (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:34:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F67B10FA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B4DA62CB1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C42C433C8;
        Sun, 13 Aug 2023 21:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962478;
        bh=B5/TGXiFgftkeJfHdpd4CJwxcB49HhSZvGtdb5vFrYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9RiY9YabhFpz/Qf3JaGgQ3QuAJFUT6SvLyfAYp/6ILjijihy+nQL3eE6xHnHOGiD
         ORZovLbSoeoPM2TOgf8ZvWQvbzfyRMte0m5ZF1uJ1BaTPaInDi5U+bEMg4zBVJ33aV
         flhr+2nK7qbsZkWB0mYZ7hHakKq58mLR1urGRMkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 043/149] drm/amd/display: Handle seamless boot stream
Date:   Sun, 13 Aug 2023 23:18:08 +0200
Message-ID: <20230813211720.100146543@linuxfoundation.org>
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

commit 170390e587a69b2a24abac39eb3ae6ec28a4d7f2 upstream

A seamless boot stream has hardware resources assigned to it, and adding
a new stream means rebuilding the current assignment. It is desirable to
avoid this situation since it may cause light-up issues on the VGA
monitor on USB-C. This commit swaps the seamless boot stream to pipe 0
(if necessary) to ensure that the pipe context matches.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2788,6 +2788,21 @@ enum dc_status dc_validate_with_context(
 			goto fail;
 	}
 
+	/* Swap seamless boot stream to pipe 0 (if needed) to ensure pipe_ctx
+	 * matches. This may change in the future if seamless_boot_stream can be
+	 * multiple.
+	 */
+	for (i = 0; i < add_streams_count; i++) {
+		mark_seamless_boot_stream(dc, add_streams[i]);
+		if (add_streams[i]->apply_seamless_boot_optimization && i != 0) {
+			struct dc_stream_state *temp = add_streams[0];
+
+			add_streams[0] = add_streams[i];
+			add_streams[i] = temp;
+			break;
+		}
+	}
+
 	/* Add new streams and then add all planes for the new stream */
 	for (i = 0; i < add_streams_count; i++) {
 		calculate_phy_pix_clks(add_streams[i]);


