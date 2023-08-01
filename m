Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF5F76ADB4
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjHAJbu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjHAJbf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:31:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDED3AB4
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3CDD614F3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE23AC433C8;
        Tue,  1 Aug 2023 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882211;
        bh=6yYoTQ/WN45aLACgt3kxuHv4ey876XlhEV+Z/YxN8z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ilbI9WQUh2JiB+i/F0TlDQ/LQYcZW5gN/47JpNPsd6EKy8FpYlNBklcivinWs9ijs
         RIwmW26FKidr7EVOGIdxAT9edL/2jCbW+0mczC9YXvp/DWTkZWa70wAXf/cN99S+pP
         dk8ak1jI56XMqt19cSfYMSxBUIg5dvgbuSclFs00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 008/228] drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters implementation with SMU13
Date:   Tue,  1 Aug 2023 11:17:46 +0200
Message-ID: <20230801091923.123178826@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

commit e701156ccc6c7a5f104a968dda74cd6434178712 upstream.

SMU13 overrides dynamic PCIe lane width and dynamic speed by when on
certain hosts. commit 38e4ced80479 ("drm/amd/pm: conditionally disable
pcie lane switching for some sienna_cichlid SKUs") worked around this
issue by setting up certain SKUs to set up certain limits, but the same
fundamental problem with those hosts affects all SMU11 implmentations
as well, so align the SMU11 and SMU13 driver handling.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |   93 +++-------------
 1 file changed, 20 insertions(+), 73 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2081,89 +2081,36 @@ static int sienna_cichlid_display_disabl
 	return ret;
 }
 
-static void sienna_cichlid_get_override_pcie_settings(struct smu_context *smu,
-						      uint32_t *gen_speed_override,
-						      uint32_t *lane_width_override)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	*gen_speed_override = 0xff;
-	*lane_width_override = 0xff;
-
-	switch (adev->pdev->device) {
-	case 0x73A0:
-	case 0x73A1:
-	case 0x73A2:
-	case 0x73A3:
-	case 0x73AB:
-	case 0x73AE:
-		/* Bit 7:0: PCIE lane width, 1 to 7 corresponds is x1 to x32 */
-		*lane_width_override = 6;
-		break;
-	case 0x73E0:
-	case 0x73E1:
-	case 0x73E3:
-		*lane_width_override = 4;
-		break;
-	case 0x7420:
-	case 0x7421:
-	case 0x7422:
-	case 0x7423:
-	case 0x7424:
-		*lane_width_override = 3;
-		break;
-	default:
-		break;
-	}
-}
-
-#define MAX(a, b)	((a) > (b) ? (a) : (b))
-
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_gen_cap,
 					 uint32_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
-	uint32_t gen_speed_override, lane_width_override;
-	uint8_t *table_member1, *table_member2;
-	uint32_t min_gen_speed, max_gen_speed;
-	uint32_t min_lane_width, max_lane_width;
-	uint32_t smu_pcie_arg;
+	u32 smu_pcie_arg;
 	int ret, i;
 
-	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
-	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
-
-	sienna_cichlid_get_override_pcie_settings(smu,
-						  &gen_speed_override,
-						  &lane_width_override);
-
-	/* PCIE gen speed override */
-	if (gen_speed_override != 0xff) {
-		min_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
-		max_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
-	} else {
-		min_gen_speed = MAX(0, table_member1[0]);
-		max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
-		min_gen_speed = min_gen_speed > max_gen_speed ?
-				max_gen_speed : min_gen_speed;
-	}
-	pcie_table->pcie_gen[0] = min_gen_speed;
-	pcie_table->pcie_gen[1] = max_gen_speed;
-
-	/* PCIE lane width override */
-	if (lane_width_override != 0xff) {
-		min_lane_width = MIN(pcie_width_cap, lane_width_override);
-		max_lane_width = MIN(pcie_width_cap, lane_width_override);
+	/* PCIE gen speed and lane width override */
+	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
+		if (pcie_table->pcie_gen[NUM_LINK_LEVELS - 1] < pcie_gen_cap)
+			pcie_gen_cap = pcie_table->pcie_gen[NUM_LINK_LEVELS - 1];
+
+		if (pcie_table->pcie_lane[NUM_LINK_LEVELS - 1] < pcie_width_cap)
+			pcie_width_cap = pcie_table->pcie_lane[NUM_LINK_LEVELS - 1];
+
+		/* Force all levels to use the same settings */
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			pcie_table->pcie_gen[i] = pcie_gen_cap;
+			pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
 	} else {
-		min_lane_width = MAX(1, table_member2[0]);
-		max_lane_width = MIN(pcie_width_cap, table_member2[1]);
-		min_lane_width = min_lane_width > max_lane_width ?
-				 max_lane_width : min_lane_width;
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+				pcie_table->pcie_gen[i] = pcie_gen_cap;
+			if (pcie_table->pcie_lane[i] > pcie_width_cap)
+				pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
 	}
-	pcie_table->pcie_lane[0] = min_lane_width;
-	pcie_table->pcie_lane[1] = max_lane_width;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
 		smu_pcie_arg = (i << 16 |


