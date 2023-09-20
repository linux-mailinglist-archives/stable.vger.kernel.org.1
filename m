Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99C97A7AF1
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjITLrk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjITLrj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:47:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EEDA3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:47:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DBDC433C7;
        Wed, 20 Sep 2023 11:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210453;
        bh=lRz83hanFkKgvBdIrIvCdpKySEsXgbeQL+3BI11enbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/dE0D0WSFxWGLBj1tNvdfuRs3+mCgUgqiY4HWoz5KdeX5ovEgSJA1dpKrAnx+L2Z
         enw006E1lYjFJfEFBxQqGw2GzDhYTZp+ay65kOOhsbWc25PQlsupYb7IKgti/FEfhO
         ODfU+rWzEcSGHOf3pzCx5oV6NdYbMxyh1se+e2QI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Samson Tam <samson.tam@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 082/211] drm/amd/display: Use max memclk variable when setting max memclk
Date:   Wed, 20 Sep 2023 13:28:46 +0200
Message-ID: <20230920112848.353359815@linuxfoundation.org>
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

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit 2b1b838ea8e5437ef06a29818d16e9efdfaf0037 ]

[Description]
In overclocking scenarios the max memclk could be higher
than the DC mode limit. However, for configs that don't
support MCLK switching we need to set the max memclk to
the overclocked max instead of the DC mode max or we
could result in underflow.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index cb992aca760dc..5fc78bf927bbc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -802,7 +802,7 @@ static void dcn32_set_hard_min_memclk(struct clk_mgr *clk_mgr_base, bool current
 					khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 		else
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels - 1].memclk_mhz);
+					clk_mgr_base->bw_params->max_memclk_mhz);
 	} else {
 		dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
 				clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz);
-- 
2.40.1



