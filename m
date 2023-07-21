Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E065C75D4BD
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjGUTYf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjGUTYe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:24:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E764273F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:24:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0C2761B24
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DB1C433C7;
        Fri, 21 Jul 2023 19:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967472;
        bh=vqVtjAtUUOuMF/rsBjgh1hFPIlxc/ahw7/o+qLYwtSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMOjzfK6bhSa65hQOulmxDcW8BkwI8cAg6DXfm6n34FGnC2hSbxgd1jBaN3wwvpws
         zHSQv6nG59sZOKZ6FljYUjeYYuFFZwxcJqkpSb3eCEhyVYqW/fapoTWsZ7Rb+FYWVm
         sVRFha5vxzgDtJQ+0lXU1UEgj6q3uwvlQKW/3rkM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Wheeler <daniel.wheeler@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Austin Zheng <austin.zheng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 147/223] drm/amd/display: Remove Phantom Pipe Check When Calculating K1 and K2
Date:   Fri, 21 Jul 2023 18:06:40 +0200
Message-ID: <20230721160527.139318359@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Austin Zheng <austin.zheng@amd.com>

commit 1966bbfdfe476d271b338336254854c5edd5a907 upstream.

[Why]
K1 and K2 not being setting properly when subVP is active.

[How]
Have phantom pipes use the same programing as the main pipes without
checking the paired stream

Cc: stable@vger.kernel.org
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1165,10 +1165,6 @@ unsigned int dcn32_calculate_dccg_k1_k2_
 	unsigned int odm_combine_factor = 0;
 	bool two_pix_per_container = false;
 
-	// For phantom pipes, use the same programming as the main pipes
-	if (pipe_ctx->stream->mall_stream_config.type == SUBVP_PHANTOM) {
-		stream = pipe_ctx->stream->mall_stream_config.paired_stream;
-	}
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 


