Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C407A39F7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbjIQT4v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbjIQT4j (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:56:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB41F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:56:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DF8C433C8;
        Sun, 17 Sep 2023 19:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980594;
        bh=/NjWOCnx9kQugUiLJWtVegaaRP9CrH+fZiNDh6rHtKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4odR902xhd4Iuro8Fu+8jGYA6V7RDHPCKZXzBhsLHcWT+af/+D052JpZjwC2ajbZ
         lzpVbdry77iSslkz/PylYxOf2LcVfB2Wnkp4oMCPg+71f1TrP2nP4GsuSZT1QINr2i
         NTHGTqEPkS6pjcALoXKqY7TK4rBt6ePFb6Aic0HI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dillon Varone <dillon.varone@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.5 238/285] drm/amd/display: always switch off ODM before committing more streams
Date:   Sun, 17 Sep 2023 21:13:58 +0200
Message-ID: <20230917191059.629110657@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenjing Liu <wenjing.liu@amd.com>

commit 49a30c3d1a2258fc93cfe6eea8e4951dabadc824 upstream.

ODM power optimization is only supported with single stream. When ODM
power optimization is enabled, we might not have enough free pipes for
enabling other stream. So when we are committing more than 1 stream we
should first switch off ODM power optimization to make room for new
stream and then allocating pipe resource for the new stream.

Cc: stable@vger.kernel.org
Fixes: 59de751e3845 ("drm/amd/display: add ODM case when looking for first split pipe")
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2061,12 +2061,12 @@ enum dc_status dc_commit_streams(struct
 		}
 	}
 
-	/* Check for case where we are going from odm 2:1 to max
-	 *  pipe scenario.  For these cases, we will call
-	 *  commit_minimal_transition_state() to exit out of odm 2:1
-	 *  first before processing new streams
+	/* ODM Combine 2:1 power optimization is only applied for single stream
+	 * scenario, it uses extra pipes than needed to reduce power consumption
+	 * We need to switch off this feature to make room for new streams.
 	 */
-	if (stream_count == dc->res_pool->pipe_count) {
+	if (stream_count > dc->current_state->stream_count &&
+			dc->current_state->stream_count == 1) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 			if (pipe->next_odm_pipe)


