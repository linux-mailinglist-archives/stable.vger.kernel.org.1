Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E29C74C2D0
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjGILZD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjGILZC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884BE13D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E52C60BCC
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFE8C433C7;
        Sun,  9 Jul 2023 11:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901900;
        bh=t5kppTVDtydrcMnWFPQJieEi7Cy2DCG1zIdibxQNoEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ybzsGM4UgTTCpJX2duA3oSckXJ5mG4B611cNYojybGDl+r8uQ75VYLhSd1Cc50Eu
         SSvm9AZ2e/Gkqln3sBZd4okfAvTYKsovgBVWrKgladU93HetxhmbCS3ASPczQ6MDYh
         JqQilcfgM7ggMFzNLXCTHaYR9hd5zz5Kb6IlSmNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 157/431] drm/amd/display: Add logging for display MALL refresh setting
Date:   Sun,  9 Jul 2023 13:11:45 +0200
Message-ID: <20230709111454.846607421@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[ Upstream commit cd8f067a46d34dee3188da184912ae3d64d98444 ]

[WHY]
Add log entry for when display refresh from MALL
settings are sent to SMU.

Fixes: 1664641ea946 ("drm/amd/display: Add logger for SMU msg")
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
index 1fbf1c105dc12..bdbf183066981 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
@@ -312,6 +312,9 @@ void dcn30_smu_set_display_refresh_from_mall(struct clk_mgr_internal *clk_mgr, b
 	/* bits 8:7 for cache timer scale, bits 6:1 for cache timer delay, bit 0 = 1 for enable, = 0 for disable */
 	uint32_t param = (cache_timer_scale << 7) | (cache_timer_delay << 1) | (enable ? 1 : 0);
 
+	smu_print("SMU Set display refresh from mall: enable = %d, cache_timer_delay = %d, cache_timer_scale = %d\n",
+		enable, cache_timer_delay, cache_timer_scale);
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_SetDisplayRefreshFromMall, param, NULL);
 }
-- 
2.39.2



