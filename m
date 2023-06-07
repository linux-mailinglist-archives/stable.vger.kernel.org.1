Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2466726C15
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjFGUal (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjFGUaY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13646213D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A5FE644C9
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D3FC433EF;
        Wed,  7 Jun 2023 20:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169808;
        bh=S1Er6tAk46+EiTlGcl6Te+QtUjIMiIoQspoSNzceCOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsgBimUAKOfwyRzWj2zbKD2iIZ+wrs5/80u2Z1SXq1SBZ7NUvSZOE7yHNz0CJEz7Y
         FVJ1xk/PdtkVaLWsPsk4a6xmlly3WgyXP8jIF+RtlZI0bcmDidLtfAfPzjcYOu0aPv
         QeX5jnqfAOY5Mq6hB5UpiVpTA1w7PnM1o3AHjiIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhenneng Li <lizhenneng@kylinos.cn>,
        Guchun Chen <guchun.chen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 221/286] drm/amd/pm: resolve reboot exception for si oland
Date:   Wed,  7 Jun 2023 22:15:20 +0200
Message-ID: <20230607200930.496900441@linuxfoundation.org>
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

From: Guchun Chen <guchun.chen@amd.com>

commit e490d60a2f76bff636c68ce4fe34c1b6c34bbd86 upstream.

During reboot test on arm64 platform, it may failure on boot.

The error message are as follows:
[    1.706570][ 3] [  T273] [drm:si_thermal_enable_alert [amdgpu]] *ERROR* Could not enable thermal interrupts.
[    1.716547][ 3] [  T273] [drm:amdgpu_device_ip_late_init [amdgpu]] *ERROR* late_init of IP block <si_dpm> failed -22
[    1.727064][ 3] [  T273] amdgpu 0000:02:00.0: amdgpu_device_ip_late_init failed
[    1.734367][ 3] [  T273] amdgpu 0000:02:00.0: Fatal error during GPU init

v2: squash in built warning fix (Alex)

Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c |   29 -----------------------------
 1 file changed, 29 deletions(-)

--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -6925,23 +6925,6 @@ static int si_dpm_enable(struct amdgpu_d
 	return 0;
 }
 
-static int si_set_temperature_range(struct amdgpu_device *adev)
-{
-	int ret;
-
-	ret = si_thermal_enable_alert(adev, false);
-	if (ret)
-		return ret;
-	ret = si_thermal_set_temperature_range(adev, R600_TEMP_RANGE_MIN, R600_TEMP_RANGE_MAX);
-	if (ret)
-		return ret;
-	ret = si_thermal_enable_alert(adev, true);
-	if (ret)
-		return ret;
-
-	return ret;
-}
-
 static void si_dpm_disable(struct amdgpu_device *adev)
 {
 	struct rv7xx_power_info *pi = rv770_get_pi(adev);
@@ -7626,18 +7609,6 @@ static int si_dpm_process_interrupt(stru
 
 static int si_dpm_late_init(void *handle)
 {
-	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	if (!adev->pm.dpm_enabled)
-		return 0;
-
-	ret = si_set_temperature_range(adev);
-	if (ret)
-		return ret;
-#if 0 //TODO ?
-	si_dpm_powergate_uvd(adev, true);
-#endif
 	return 0;
 }
 


