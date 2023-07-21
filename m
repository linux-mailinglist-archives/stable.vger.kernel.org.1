Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954A075C6AC
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 14:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjGUMNL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 08:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjGUMNL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 08:13:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95610FE
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7418761934
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6008EC433C8;
        Fri, 21 Jul 2023 12:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689941588;
        bh=4rvXRe0olBuvR/Eqjn1mBihd8vLHa7vKnJIqfmwyBzk=;
        h=Subject:To:Cc:From:Date:From;
        b=y+Pcxucyfd7W9qd9wto93L9xw0ISDZKLNm11aW+tXqv0Z8xD73EQxjPp3C/ghcXoI
         488jo6OdS/+Fk7f0gYWSrdg6LpM57USOOc/hHrWY8ZPW3Zv35n2xrhAD7mi5l2i0YM
         FWMQQWQJNPa39JkKZneJZUoCfhP4taILZf0js9LI=
Subject: FAILED: patch "[PATCH] drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters" failed to apply to 6.4-stable tree
To:     mario.limonciello@amd.com, alexander.deucher@amd.com,
        evan.quan@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 14:12:58 +0200
Message-ID: <2023072158-spindle-hardhat-3c74@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x e701156ccc6c7a5f104a968dda74cd6434178712
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072158-spindle-hardhat-3c74@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e701156ccc6c7a5f104a968dda74cd6434178712 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Fri, 7 Jul 2023 21:26:09 -0500
Subject: [PATCH] drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters
 implementation with SMU13

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

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 8fe2e1716da4..f6599c00a6fd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2077,89 +2077,36 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
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
+	/* PCIE gen speed and lane width override */
+	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
+		if (pcie_table->pcie_gen[NUM_LINK_LEVELS - 1] < pcie_gen_cap)
+			pcie_gen_cap = pcie_table->pcie_gen[NUM_LINK_LEVELS - 1];
 
-	sienna_cichlid_get_override_pcie_settings(smu,
-						  &gen_speed_override,
-						  &lane_width_override);
+		if (pcie_table->pcie_lane[NUM_LINK_LEVELS - 1] < pcie_width_cap)
+			pcie_width_cap = pcie_table->pcie_lane[NUM_LINK_LEVELS - 1];
 
-	/* PCIE gen speed override */
-	if (gen_speed_override != 0xff) {
-		min_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
-		max_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
+		/* Force all levels to use the same settings */
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			pcie_table->pcie_gen[i] = pcie_gen_cap;
+			pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
 	} else {
-		min_gen_speed = MAX(0, table_member1[0]);
-		max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
-		min_gen_speed = min_gen_speed > max_gen_speed ?
-				max_gen_speed : min_gen_speed;
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+				pcie_table->pcie_gen[i] = pcie_gen_cap;
+			if (pcie_table->pcie_lane[i] > pcie_width_cap)
+				pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
 	}
-	pcie_table->pcie_gen[0] = min_gen_speed;
-	pcie_table->pcie_gen[1] = max_gen_speed;
-
-	/* PCIE lane width override */
-	if (lane_width_override != 0xff) {
-		min_lane_width = MIN(pcie_width_cap, lane_width_override);
-		max_lane_width = MIN(pcie_width_cap, lane_width_override);
-	} else {
-		min_lane_width = MAX(1, table_member2[0]);
-		max_lane_width = MIN(pcie_width_cap, table_member2[1]);
-		min_lane_width = min_lane_width > max_lane_width ?
-				 max_lane_width : min_lane_width;
-	}
-	pcie_table->pcie_lane[0] = min_lane_width;
-	pcie_table->pcie_lane[1] = max_lane_width;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
 		smu_pcie_arg = (i << 16 |

