Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453A075D4CD
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjGUTZP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjGUTZN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4595F3A82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 906DF61D82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0BFC433C8;
        Fri, 21 Jul 2023 19:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967501;
        bh=+CrbqVMtLVbs4Zb/mWW+CdoydzZyVO2+pTA3COn/eD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xgo7LwynMexH9aQuc3I7hTQE5Q6rrAC1oPSGU1/NAe6OHgJOF4Z8IdSp18sc2kf//
         mBASVCrOZliisFKJK7p/8v+6N37EuUzC0GS+oGU5AVYoMWQ1qXpyzmp6mWEC7bwe85
         rxV5sgz3YYnozzkczaWLgmHDNuzOCI1B9YehN4LU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Quan <evan.quan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 185/223] drm/amd/pm: share the code around SMU13 pcie parameters update
Date:   Fri, 21 Jul 2023 18:07:18 +0200
Message-ID: <20230721160528.770059720@linuxfoundation.org>
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

From: Evan Quan <evan.quan@amd.com>

commit dcb489bae65d92cfd26da22c7a0d6665b06ecc63 upstream.

So that SMU13.0.0 and SMU13.0.7 do not need to have one copy each.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h         |    4 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       |   31 +++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c |   33 -------------------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c |   33 -------------------
 4 files changed, 37 insertions(+), 64 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -297,5 +297,9 @@ int smu_v13_0_get_pptable_from_firmware(
 					uint32_t *size,
 					uint32_t pptable_id);
 
+int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
+				     uint32_t pcie_gen_cap,
+				     uint32_t pcie_width_cap);
+
 #endif
 #endif
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2489,3 +2489,34 @@ int smu_v13_0_mode1_reset(struct smu_con
 
 	return ret;
 }
+
+int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
+				     uint32_t pcie_gen_cap,
+				     uint32_t pcie_width_cap)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct smu_13_0_pcie_table *pcie_table =
+				&dpm_context->dpm_tables.pcie_table;
+	uint32_t smu_pcie_arg;
+	int ret, i;
+
+	for (i = 0; i < pcie_table->num_of_link_levels; i++) {
+		if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+			pcie_table->pcie_gen[i] = pcie_gen_cap;
+		if (pcie_table->pcie_lane[i] > pcie_width_cap)
+			pcie_table->pcie_lane[i] = pcie_width_cap;
+
+		smu_pcie_arg = i << 16;
+		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+		smu_pcie_arg |= pcie_table->pcie_lane[i];
+
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_OverridePcieParameters,
+						      smu_pcie_arg,
+						      NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1216,37 +1216,6 @@ static int smu_v13_0_0_force_clk_levels(
 	return ret;
 }
 
-static int smu_v13_0_0_update_pcie_parameters(struct smu_context *smu,
-					      uint32_t pcie_gen_cap,
-					      uint32_t pcie_width_cap)
-{
-	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_pcie_table *pcie_table =
-				&dpm_context->dpm_tables.pcie_table;
-	uint32_t smu_pcie_arg;
-	int ret, i;
-
-	for (i = 0; i < pcie_table->num_of_link_levels; i++) {
-		if (pcie_table->pcie_gen[i] > pcie_gen_cap)
-			pcie_table->pcie_gen[i] = pcie_gen_cap;
-		if (pcie_table->pcie_lane[i] > pcie_width_cap)
-			pcie_table->pcie_lane[i] = pcie_width_cap;
-
-		smu_pcie_arg = i << 16;
-		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
-		smu_pcie_arg |= pcie_table->pcie_lane[i];
-
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_OverridePcieParameters,
-						      smu_pcie_arg,
-						      NULL);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static const struct smu_temperature_range smu13_thermal_policy[] = {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
@@ -2033,7 +2002,7 @@ static const struct pptable_funcs smu_v1
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.print_clk_levels = smu_v13_0_0_print_clk_levels,
 	.force_clk_levels = smu_v13_0_0_force_clk_levels,
-	.update_pcie_parameters = smu_v13_0_0_update_pcie_parameters,
+	.update_pcie_parameters = smu_v13_0_update_pcie_parameters,
 	.get_thermal_temperature_range = smu_v13_0_0_get_thermal_temperature_range,
 	.register_irq_handler = smu_v13_0_register_irq_handler,
 	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1225,37 +1225,6 @@ static int smu_v13_0_7_force_clk_levels(
 	return ret;
 }
 
-static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
-					      uint32_t pcie_gen_cap,
-					      uint32_t pcie_width_cap)
-{
-	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_pcie_table *pcie_table =
-				&dpm_context->dpm_tables.pcie_table;
-	uint32_t smu_pcie_arg;
-	int ret, i;
-
-	for (i = 0; i < pcie_table->num_of_link_levels; i++) {
-		if (pcie_table->pcie_gen[i] > pcie_gen_cap)
-			pcie_table->pcie_gen[i] = pcie_gen_cap;
-		if (pcie_table->pcie_lane[i] > pcie_width_cap)
-			pcie_table->pcie_lane[i] = pcie_width_cap;
-
-		smu_pcie_arg = i << 16;
-		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
-		smu_pcie_arg |= pcie_table->pcie_lane[i];
-
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_OverridePcieParameters,
-						      smu_pcie_arg,
-						      NULL);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static const struct smu_temperature_range smu13_thermal_policy[] =
 {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
@@ -1750,7 +1719,7 @@ static const struct pptable_funcs smu_v1
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.print_clk_levels = smu_v13_0_7_print_clk_levels,
 	.force_clk_levels = smu_v13_0_7_force_clk_levels,
-	.update_pcie_parameters = smu_v13_0_7_update_pcie_parameters,
+	.update_pcie_parameters = smu_v13_0_update_pcie_parameters,
 	.get_thermal_temperature_range = smu_v13_0_7_get_thermal_temperature_range,
 	.register_irq_handler = smu_v13_0_register_irq_handler,
 	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,


