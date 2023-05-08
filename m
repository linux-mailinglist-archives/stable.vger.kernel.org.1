Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8312C6FA409
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjEHJy3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjEHJy2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1A625721
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A638062204
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B388EC433D2;
        Mon,  8 May 2023 09:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539666;
        bh=1st2AWW9V0RFH38t0szpIQhSrPtjADkDuPIJmFvPIJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lETcx001iwsBhffV37RPjA4AOM8qNITv9eJEFQOuUYJ6kfnWwoo1lRj3p+x5b23pN
         CjjqhcJ+oAIUbJ6L+d+FHscmWa9Kv16D/P8jVQgEN/gLzPVfMwX2gWy6V7d5Apr9LB
         gxbyiK8SLklWyBLngGkIQywE6kgc9ctKf4mWaOyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tim Huang <tim.huang@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 098/611] drm/amd/pm: re-enable the gfx imu when smu resume
Date:   Mon,  8 May 2023 11:39:00 +0200
Message-Id: <20230508094425.399958702@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Tim Huang <tim.huang@amd.com>

commit f7f28f268b861c29dd18086bb636abedf0ff59ff upstream.

If the gfx imu is poweroff when suspend, then
it need to be re-enabled when resume.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |   40 +++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 12 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -161,10 +161,15 @@ int smu_get_dpm_freq_range(struct smu_co
 
 int smu_set_gfx_power_up_by_imu(struct smu_context *smu)
 {
-	if (!smu->ppt_funcs || !smu->ppt_funcs->set_gfx_power_up_by_imu)
-		return -EOPNOTSUPP;
+	int ret = 0;
+	struct amdgpu_device *adev = smu->adev;
 
-	return smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
+	if (smu->ppt_funcs->set_gfx_power_up_by_imu) {
+		ret = smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
+		if (ret)
+			dev_err(adev->dev, "Failed to enable gfx imu!\n");
+	}
+	return ret;
 }
 
 static u32 smu_get_mclk(void *handle, bool low)
@@ -195,6 +200,19 @@ static u32 smu_get_sclk(void *handle, bo
 	return clk_freq * 100;
 }
 
+static int smu_set_gfx_imu_enable(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
+		return 0;
+
+	if (amdgpu_in_reset(smu->adev) || adev->in_s0ix)
+		return 0;
+
+	return smu_set_gfx_power_up_by_imu(smu);
+}
+
 static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 				  bool enable)
 {
@@ -1386,15 +1404,9 @@ static int smu_hw_init(void *handle)
 	}
 
 	if (smu->is_apu) {
-		if ((smu->ppt_funcs->set_gfx_power_up_by_imu) &&
-				likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
-			ret = smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
-			if (ret) {
-				dev_err(adev->dev, "Failed to Enable gfx imu!\n");
-				return ret;
-			}
-		}
-
+		ret = smu_set_gfx_imu_enable(smu);
+		if (ret)
+			return ret;
 		smu_dpm_set_vcn_enable(smu, true);
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_set_gfx_cgpg(smu, true);
@@ -1670,6 +1682,10 @@ static int smu_resume(void *handle)
 		return ret;
 	}
 
+	ret = smu_set_gfx_imu_enable(smu);
+	if (ret)
+		return ret;
+
 	smu_set_gfx_cgpg(smu, true);
 
 	smu->disable_uclk_switch = 0;


