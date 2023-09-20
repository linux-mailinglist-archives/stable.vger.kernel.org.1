Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE037A7BD4
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjITLz6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbjITLz4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:55:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3370D8
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:55:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D73C433B8;
        Wed, 20 Sep 2023 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210942;
        bh=4/fgkIzMGh+W57i7eLyS+EX5coEmRYg8jgj3jU16DLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thgoyY0f2eRH7qvpFuN6N6zMmRdLIYRlx7cWAwCjiRuF7DHyoxe71wq9bKZRs5bc1
         1+L6YjA3PmyJp4bE/RspQpkGPy6uU9rrX4T9fWK3w1Ik1FlvhvxqMKKRMX1bXPF2lN
         mRwvuxbW7vWahHoMKcmqeMib3XC00a1mHWjPchSw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alvin Lee <alvin.lee2@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Austin Zheng <austin.zheng@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 050/139] drm/amd/display: Use DTBCLK as refclk instead of DPREFCLK
Date:   Wed, 20 Sep 2023 13:29:44 +0200
Message-ID: <20230920112837.520126770@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Austin Zheng <austin.zheng@amd.com>

[ Upstream commit 4a30cc2bd281fa176a68b5305cd3695d636152ad ]

[Why]
Flash of corruption observed when UCLK switching after transitioning
from DTBCLK to DPREFCLK on subVP(DP) + subVP(HDMI) config
Scenario where DPREFCLK is required instead of DTBCLK is not expected

[How]
Always set the DTBCLK source as DTBCLK0

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index ffbb739d85b69..8496ff4a25e35 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -290,7 +290,8 @@ static void dccg32_set_dpstreamclk(
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
 	/* set the dtbclk_p source */
-	dccg32_set_dtbclk_p_src(dccg, src, otg_inst);
+	/* always program refclk as DTBCLK. No use-case expected to require DPREFCLK as refclk */
+	dccg32_set_dtbclk_p_src(dccg, DTBCLK0, otg_inst);
 
 	/* enabled to select one of the DTBCLKs for pipe */
 	switch (dp_hpo_inst) {
-- 
2.40.1



