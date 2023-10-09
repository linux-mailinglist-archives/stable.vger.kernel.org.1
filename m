Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FAC7BDE58
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377028AbjJINSf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377018AbjJINSe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:18:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C1EA6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:18:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7A6C433C8;
        Mon,  9 Oct 2023 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857512;
        bh=JPsKtMXQInEAo+651aSbbOJLq5byv/NCruFkm1BTD2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iE0/9naClWeV1xxRDnIgTHF6w+rXdkdtnkWc23la73f3C/FDoHh1/GBtbxdIlhw28
         M8n/cgDG8F7MPKfk42/UQiRKV91M+Y5WVdasYLcjLfiqoE6OWF1DEd00jL8POHvrgf
         H22m5O/HpTQSXzqZogMr+k3c8DJlYa797UwZv/mA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Umio Yasuno <coelacanth_dream@protonmail.com>
Subject: [PATCH 6.1 069/162] drm/amd: Fix logic error in sienna_cichlid_update_pcie_parameters()
Date:   Mon,  9 Oct 2023 15:00:50 +0200
Message-ID: <20231009130124.830640358@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 2a1fe39a5be785e962e387146aed34fa9a829f3f upstream.

While aligning SMU11 with SMU13 implementation an assumption was made that
`dpm_context->dpm_tables.pcie_table` was populated in dpm table initialization
like in SMU13 but it isn't.

So restore some of the original logic and instead just check for
amdgpu_device_pcie_dynamic_switching_supported() to decide whether to hardcode
values; erring on the side of performance.

Cc: stable@vger.kernel.org # 6.1+
Reported-and-tested-by: Umio Yasuno <coelacanth_dream@protonmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1447#note_2101382
Fixes: e701156ccc6c ("drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters implementation with SMU13")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |   41 ++++++++--------
 1 file changed, 23 insertions(+), 18 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2081,36 +2081,41 @@ static int sienna_cichlid_display_disabl
 	return ret;
 }
 
+#define MAX(a, b)	((a) > (b) ? (a) : (b))
+
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_gen_cap,
 					 uint32_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
-	u32 smu_pcie_arg;
+	uint8_t *table_member1, *table_member2;
+	uint32_t min_gen_speed, max_gen_speed;
+	uint32_t min_lane_width, max_lane_width;
+	uint32_t smu_pcie_arg;
 	int ret, i;
 
-	/* PCIE gen speed and lane width override */
-	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
-		if (pcie_table->pcie_gen[NUM_LINK_LEVELS - 1] < pcie_gen_cap)
-			pcie_gen_cap = pcie_table->pcie_gen[NUM_LINK_LEVELS - 1];
+	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
+	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
 
-		if (pcie_table->pcie_lane[NUM_LINK_LEVELS - 1] < pcie_width_cap)
-			pcie_width_cap = pcie_table->pcie_lane[NUM_LINK_LEVELS - 1];
+	min_gen_speed = MAX(0, table_member1[0]);
+	max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
+	min_gen_speed = min_gen_speed > max_gen_speed ?
+			max_gen_speed : min_gen_speed;
+	min_lane_width = MAX(1, table_member2[0]);
+	max_lane_width = MIN(pcie_width_cap, table_member2[1]);
+	min_lane_width = min_lane_width > max_lane_width ?
+			 max_lane_width : min_lane_width;
 
-		/* Force all levels to use the same settings */
-		for (i = 0; i < NUM_LINK_LEVELS; i++) {
-			pcie_table->pcie_gen[i] = pcie_gen_cap;
-			pcie_table->pcie_lane[i] = pcie_width_cap;
-		}
+	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
+		pcie_table->pcie_gen[0] = max_gen_speed;
+		pcie_table->pcie_lane[0] = max_lane_width;
 	} else {
-		for (i = 0; i < NUM_LINK_LEVELS; i++) {
-			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
-				pcie_table->pcie_gen[i] = pcie_gen_cap;
-			if (pcie_table->pcie_lane[i] > pcie_width_cap)
-				pcie_table->pcie_lane[i] = pcie_width_cap;
-		}
+		pcie_table->pcie_gen[0] = min_gen_speed;
+		pcie_table->pcie_lane[0] = min_lane_width;
 	}
+	pcie_table->pcie_gen[1] = max_gen_speed;
+	pcie_table->pcie_lane[1] = max_lane_width;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
 		smu_pcie_arg = (i << 16 |


