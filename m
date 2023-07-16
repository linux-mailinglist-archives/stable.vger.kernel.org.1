Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C9E75520D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjGPUDS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjGPUDP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:03:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3567E1B4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C00E660E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3B6C433C8;
        Sun, 16 Jul 2023 20:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537793;
        bh=qsRsyjKwGYzo1SKm2y9hvXgv3bsPDwmuh6U/WYPvxRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAq6h4PEaOeB0MOwotbCWlN8bOORs/CGvJ1wi/3tzShsOf5dJFzOf5QfjWHshZ6TM
         i8sxQL2DC1eH7+8gcGsuvXguUDknAXC25qGBvtW1MIRd1YQZIbgxlS8H/FhQS+819X
         vtW1HB5NSm7CEi5vRwkzBz2QJheqY6bg+/rJFGlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 223/800] drm/amd/display: Unconditionally print when DP sink power state fails
Date:   Sun, 16 Jul 2023 21:41:16 +0200
Message-ID: <20230716194954.271818060@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit e4dfd94d5e3851df607b26ab5b20ad8d94f5ccff ]

The previous 'commit ca9beb8aac68 ("drm/amd/display: Add logging when
setting DP sink power state fails")', it is better to unconditionally
print "failed to power up sink", because we are returning
DC_ERROR_UNEXPECTED.

Fixes: ca9beb8aac68 ("drm/amd/display: Add logging when setting DP sink power state fails")
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c    | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index ba98013fecd00..6d2d10da2b77c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1043,9 +1043,7 @@ static enum dc_status wake_up_aux_channel(struct dc_link *link)
 				DP_SET_POWER,
 				&dpcd_power_state,
 				sizeof(dpcd_power_state));
-		if (status < 0)
-			DC_LOG_DC("%s: Failed to power up sink: %s\n", __func__,
-				  dpcd_power_state == DP_SET_POWER_D0 ? "D0" : "D3");
+		DC_LOG_DC("%s: Failed to power up sink\n", __func__);
 		return DC_ERROR_UNEXPECTED;
 	}
 
-- 
2.39.2



