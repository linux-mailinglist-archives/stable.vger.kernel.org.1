Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB89726FFD
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbjFGVDt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjFGVD0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:03:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F782683
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04AE764971
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15704C433D2;
        Wed,  7 Jun 2023 21:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171783;
        bh=BX/o3mQSaNXJq8BCOI6sAsu5Q3OMswu/6KlxY8FXanw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tznmRS8fH+3Ygl53WVgEPnQoTBSyqGl0ut+BB0GD6R/xQ9emAZHd4aUpLZr5c+kIb
         58WRbr4skuZdNpmq0Qm+02t8m8zAU0Ve3h8t+wYetcIC9Sk51gOwWrp4FyoYgjw6LB
         5zswbWHPv+4BrUNfZ0Z8PHnXouIGHJzpl9EwETa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tim Huang <Tim.Huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 118/159] drm/amd/pm: reverse mclk and fclk clocks levels for renoir
Date:   Wed,  7 Jun 2023 22:17:01 +0200
Message-ID: <20230607200907.538459407@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tim Huang <Tim.Huang@amd.com>

commit 55e02c14f9b5fd973ba32a16a715baa42617f9c6 upstream.

This patch reverses the DPM clocks levels output of pp_dpm_mclk
and pp_dpm_fclk for renoir.

On dGPUs and older APUs we expose the levels from lowest clocks
to highest clocks. But for some APUs, the clocks levels are
given the reversed orders by PMFW. Like the memory DPM clocks
that are exposed by pp_dpm_mclk.

It's not intuitive that they are reversed on these APUs. All tools
and software that talks to the driver then has to know different ways
to interpret the data depending on the asic.

So we need to reverse them to expose the clocks levels from the
driver consistently.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -485,7 +485,7 @@ static int renoir_set_fine_grain_gfx_fre
 static int renoir_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	SmuMetrics_t metrics;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
@@ -585,7 +585,8 @@ static int renoir_print_clk_levels(struc
 	case SMU_VCLK:
 	case SMU_DCLK:
 		for (i = 0; i < count; i++) {
-			ret = renoir_get_dpm_clk_limited(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = renoir_get_dpm_clk_limited(smu, clk_type, idx, &value);
 			if (ret)
 				return ret;
 			if (!value)


