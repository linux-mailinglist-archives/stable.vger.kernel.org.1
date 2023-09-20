Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092FB7A7AED
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjITLr3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjITLr2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:47:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5155CE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:47:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E78C433C8;
        Wed, 20 Sep 2023 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210442;
        bh=tv835qELQ2hvSyxjKfy7C3bCqi4hvz0PeA8FPF9X/BY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nK86r6D7uPdO1djWUUgzzF3ajbHQTZWhk7SeNIkmAR2yH/ZdK5W16Ne0uwEv8Iwbv
         Koee1i2AyN3TfhYCz4IRThfo5X0FZmUJko2OyDiF3P2IzkZyr/gAtYOScBW+zhXCrE
         qjZbo9KTc+HyCEwObcM/QKAxCxQB+SVYPSyaOA/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alvin Lee <alvin.lee2@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Austin Zheng <austin.zheng@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 079/211] drm/amd/display: Use DTBCLK as refclk instead of DPREFCLK
Date:   Wed, 20 Sep 2023 13:28:43 +0200
Message-ID: <20230920112848.253849360@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 61ceff6bc0b19..921f58c0c729b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -281,7 +281,8 @@ static void dccg32_set_dpstreamclk(
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
 	/* set the dtbclk_p source */
-	dccg32_set_dtbclk_p_src(dccg, src, otg_inst);
+	/* always program refclk as DTBCLK. No use-case expected to require DPREFCLK as refclk */
+	dccg32_set_dtbclk_p_src(dccg, DTBCLK0, otg_inst);
 
 	/* enabled to select one of the DTBCLKs for pipe */
 	switch (dp_hpo_inst) {
-- 
2.40.1



