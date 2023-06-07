Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D58D726C14
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjFGUal (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjFGUaX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31175137
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E7B4644A5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1C2C4339B;
        Wed,  7 Jun 2023 20:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169805;
        bh=SJP1j1mqezHUwWoWnS+Bz2wz1y41OZ+EeoLAPXJhf1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yxG/lVpT1XqjpbZZpjGrVLVbhbRVk++AxtmB9IAfRgyDrYJjtkOA5ZNGX6+dQuf9e
         fjw0LKnADvczVupr3N1CZ5bJ6loMH5ohmtDs17JyYpUZ8u3eb574mBeAKf9AxZAX0d
         7Mx/69w772bQH4JkQTybrJZZa9vDQP2AtvRn3V64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tim Huang <Tim.Huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 220/286] drm/amd/pm: reverse mclk and fclk clocks levels for vangogh
Date:   Wed,  7 Jun 2023 22:15:19 +0200
Message-ID: <20230607200930.465347676@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tim Huang <Tim.Huang@amd.com>

commit bfc03568d9d81332382c73a1985a90c4506bd36c upstream.

This patch reverses the DPM clocks levels output of pp_dpm_mclk
and pp_dpm_fclk.

On dGPUs and older APUs we expose the levels from lowest clocks
to highest clocks. But for some APUs, the clocks levels that from
the DFPstateTable are given the reversed orders by PMFW. Like the
memory DPM clocks that are exposed by pp_dpm_mclk.

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
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -580,7 +580,7 @@ static int vangogh_print_legacy_clk_leve
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_legacy_t metrics;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
 
@@ -654,7 +654,8 @@ static int vangogh_print_legacy_clk_leve
 	case SMU_MCLK:
 	case SMU_FCLK:
 		for (i = 0; i < count; i++) {
-			ret = vangogh_get_dpm_clk_limited(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = vangogh_get_dpm_clk_limited(smu, clk_type, idx, &value);
 			if (ret)
 				return ret;
 			if (!value)
@@ -681,7 +682,7 @@ static int vangogh_print_clk_levels(stru
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
 	uint32_t min, max;
@@ -763,7 +764,8 @@ static int vangogh_print_clk_levels(stru
 	case SMU_MCLK:
 	case SMU_FCLK:
 		for (i = 0; i < count; i++) {
-			ret = vangogh_get_dpm_clk_limited(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = vangogh_get_dpm_clk_limited(smu, clk_type, idx, &value);
 			if (ret)
 				return ret;
 			if (!value)


