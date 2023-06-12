Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359FA72C220
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbjFLLDF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbjFLLCa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:02:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0E87A8B
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB133623BC
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018CFC433D2;
        Mon, 12 Jun 2023 10:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567003;
        bh=ie+q36mO8uVMU+qIZqq4sYOQ7dSxd6RxKybRidk33v0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7cQCdhSxbZ6ks5AVoPT4F4gLpXZNPy0z9fyUmLS9JMKPhS4vh1vBAyqnwl7s1rsE
         gHknYkvfxAmAqYXFXhlzT0sONhrkTlA3bxnWGKOoHi+ucOjQHCRN2tyHr1M+2b8a69
         frWbOK3kYPSztMbN3X2UTEIpFrwTbxtqvhOoA4f8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 085/160] drm/amd/pm: conditionally disable pcie lane switching for some sienna_cichlid SKUs
Date:   Mon, 12 Jun 2023 12:26:57 +0200
Message-ID: <20230612101718.898209863@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

commit 38e4ced804796c5725e2a52ec3601951552c4a97 upstream.

Disable the pcie lane switching for some sienna_cichlid SKUs since it
might not work well on some platforms.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |   92 ++++++++++++----
 1 file changed, 74 insertions(+), 18 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2067,33 +2067,94 @@ static int sienna_cichlid_display_disabl
 	return ret;
 }
 
+static void sienna_cichlid_get_override_pcie_settings(struct smu_context *smu,
+						      uint32_t *gen_speed_override,
+						      uint32_t *lane_width_override)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	*gen_speed_override = 0xff;
+	*lane_width_override = 0xff;
+
+	switch (adev->pdev->device) {
+	case 0x73A0:
+	case 0x73A1:
+	case 0x73A2:
+	case 0x73A3:
+	case 0x73AB:
+	case 0x73AE:
+		/* Bit 7:0: PCIE lane width, 1 to 7 corresponds is x1 to x32 */
+		*lane_width_override = 6;
+		break;
+	case 0x73E0:
+	case 0x73E1:
+	case 0x73E3:
+		*lane_width_override = 4;
+		break;
+	case 0x7420:
+	case 0x7421:
+	case 0x7422:
+	case 0x7423:
+	case 0x7424:
+		*lane_width_override = 3;
+		break;
+	default:
+		break;
+	}
+}
+
+#define MAX(a, b)	((a) > (b) ? (a) : (b))
+
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_gen_cap,
 					 uint32_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-
-	uint32_t smu_pcie_arg;
+	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
+	uint32_t gen_speed_override, lane_width_override;
 	uint8_t *table_member1, *table_member2;
+	uint32_t min_gen_speed, max_gen_speed;
+	uint32_t min_lane_width, max_lane_width;
+	uint32_t smu_pcie_arg;
 	int ret, i;
 
 	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
 	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
 
-	/* lclk dpm table setup */
-	for (i = 0; i < MAX_PCIE_CONF; i++) {
-		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = table_member1[i];
-		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = table_member2[i];
+	sienna_cichlid_get_override_pcie_settings(smu,
+						  &gen_speed_override,
+						  &lane_width_override);
+
+	/* PCIE gen speed override */
+	if (gen_speed_override != 0xff) {
+		min_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
+		max_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
+	} else {
+		min_gen_speed = MAX(0, table_member1[0]);
+		max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
+		min_gen_speed = min_gen_speed > max_gen_speed ?
+				max_gen_speed : min_gen_speed;
 	}
+	pcie_table->pcie_gen[0] = min_gen_speed;
+	pcie_table->pcie_gen[1] = max_gen_speed;
+
+	/* PCIE lane width override */
+	if (lane_width_override != 0xff) {
+		min_lane_width = MIN(pcie_width_cap, lane_width_override);
+		max_lane_width = MIN(pcie_width_cap, lane_width_override);
+	} else {
+		min_lane_width = MAX(1, table_member2[0]);
+		max_lane_width = MIN(pcie_width_cap, table_member2[1]);
+		min_lane_width = min_lane_width > max_lane_width ?
+				 max_lane_width : min_lane_width;
+	}
+	pcie_table->pcie_lane[0] = min_lane_width;
+	pcie_table->pcie_lane[1] = max_lane_width;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
-		smu_pcie_arg = (i << 16) |
-			((table_member1[i] <= pcie_gen_cap) ?
-			 (table_member1[i] << 8) :
-			 (pcie_gen_cap << 8)) |
-			((table_member2[i] <= pcie_width_cap) ?
-			 table_member2[i] :
-			 pcie_width_cap);
+		smu_pcie_arg = (i << 16 |
+				pcie_table->pcie_gen[i] << 8 |
+				pcie_table->pcie_lane[i]);
 
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_OverridePcieParameters,
@@ -2101,11 +2162,6 @@ static int sienna_cichlid_update_pcie_pa
 				NULL);
 		if (ret)
 			return ret;
-
-		if (table_member1[i] > pcie_gen_cap)
-			dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pcie_gen_cap;
-		if (table_member2[i] > pcie_width_cap)
-			dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pcie_width_cap;
 	}
 
 	return 0;


