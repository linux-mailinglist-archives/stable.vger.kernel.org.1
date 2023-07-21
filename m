Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1C875CEDA
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjGUQZG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjGUQYt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:24:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276AF3C25
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6ECD61D48
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9484CC43395;
        Fri, 21 Jul 2023 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956460;
        bh=fOk4TtPQ00xcnVxjBFG2/79tzX745u1MGI8ciu6g3RM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ropXCmwNTFibgP9TMM4HeoXgZH7BNmh4FWPZHNREBORRcLTM6NtWqhBGxnUf/HR1z
         BT6E+zaKW3aoo/dCSXLN0StorUHqItYxXg2h2ox+uaCa1IpkWaj+otLNQjKc2bi3WX
         cxH/wirDX4J/vCU93hWt8mDQw80oXn38kdb57bIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Wheeler <daniel.wheeler@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Austin Zheng <austin.zheng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 201/292] drm/amd/display: Remove Phantom Pipe Check When Calculating K1 and K2
Date:   Fri, 21 Jul 2023 18:05:10 +0200
Message-ID: <20230721160537.519027291@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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
@@ -1125,10 +1125,6 @@ unsigned int dcn32_calculate_dccg_k1_k2_
 	unsigned int odm_combine_factor = 0;
 	bool two_pix_per_container = false;
 
-	// For phantom pipes, use the same programming as the main pipes
-	if (pipe_ctx->stream->mall_stream_config.type == SUBVP_PHANTOM) {
-		stream = pipe_ctx->stream->mall_stream_config.paired_stream;
-	}
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 


