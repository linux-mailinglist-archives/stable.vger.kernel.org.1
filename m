Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046A370C849
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjEVThm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjEVThb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:37:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEE4E6E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F51862965
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCCEC433EF;
        Mon, 22 May 2023 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784201;
        bh=1n+5oq/O5rK/qLs2dcvIk3aXhtB8+jhON8YO0GpoZ88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TO82ZmAoassHuWg4pzrJGE1sAvxiJJ80QD0cQOzSpULd64olwyhtK5I6os7fDWjST
         Gr8lB2rHHgKzd0ksKbjNIwwD/W5C8WgXBDHZuGgVz1bBf4l5BSAxJ9eZDdSL1LHLUP
         vReFJuk37Cr9gEV8nMP6BhWRplQItHgJgsUKaUYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Quan <evan.quan@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 270/292] drm/amd/pm: fix possible power mode mismatch between driver and PMFW
Date:   Mon, 22 May 2023 20:10:27 +0100
Message-Id: <20230522190412.689457898@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

commit bf4823267a817f7c155876a125b94336d7113e77 upstream.

PMFW may boots the ASIC with a different power mode from the system's
real one. Notify PMFW explicitly the power mode the system in. This
is needed only when ACDC switch via gpio is not supported.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            |   18 +++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c      |   20 -------------------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c |    1 
 3 files changed, 20 insertions(+), 19 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -723,6 +723,24 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
+	/*
+	 * Explicitly notify PMFW the power mode the system in. Since
+	 * the PMFW may boot the ASIC with a different mode.
+	 * For those supporting ACDC switch via gpio, PMFW will
+	 * handle the switch automatically. Driver involvement
+	 * is unnecessary.
+	 */
+	if (!smu->dc_controlled_by_gpio) {
+		ret = smu_set_power_source(smu,
+					   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
+					   SMU_POWER_SOURCE_DC);
+		if (ret) {
+			dev_err(adev->dev, "Failed to switch to %s mode!\n",
+				adev->pm.ac_power ? "AC" : "DC");
+			return ret;
+		}
+	}
+
 	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 1)) ||
 	    (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 3)))
 		return 0;
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3406,26 +3406,8 @@ static int navi10_post_smu_init(struct s
 		return 0;
 
 	ret = navi10_run_umc_cdr_workaround(smu);
-	if (ret) {
+	if (ret)
 		dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");
-		return ret;
-	}
-
-	if (!smu->dc_controlled_by_gpio) {
-		/*
-		 * For Navi1X, manually switch it to AC mode as PMFW
-		 * may boot it with DC mode.
-		 */
-		ret = smu_v11_0_set_power_source(smu,
-						 adev->pm.ac_power ?
-						 SMU_POWER_SOURCE_AC :
-						 SMU_POWER_SOURCE_DC);
-		if (ret) {
-			dev_err(adev->dev, "Failed to switch to %s mode!\n",
-					adev->pm.ac_power ? "AC" : "DC");
-			return ret;
-		}
-	}
 
 	return ret;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1767,6 +1767,7 @@ static const struct pptable_funcs smu_v1
 	.enable_mgpu_fan_boost = smu_v13_0_7_enable_mgpu_fan_boost,
 	.get_power_limit = smu_v13_0_7_get_power_limit,
 	.set_power_limit = smu_v13_0_set_power_limit,
+	.set_power_source = smu_v13_0_set_power_source,
 	.get_power_profile_mode = smu_v13_0_7_get_power_profile_mode,
 	.set_power_profile_mode = smu_v13_0_7_set_power_profile_mode,
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,


