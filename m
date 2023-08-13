Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C86177ABF1
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjHMV1a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjHMV13 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:27:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D881B10D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E2EB629ED
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BB4C433C7;
        Sun, 13 Aug 2023 21:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962049;
        bh=M1WRojB2UIycePL8gVsWWfGes4fLCEsyOVERe6wxfQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0SXkml8OK9tLSmMvr0dV8Qf0voFk7GvYSdOlDBIazJntVF8a4LOH4fXRKH5Ecy0c
         j/Qk0EhrLAP0zyJz2oiYy/iYadntEogycr0aXcNW+3NeWSW1PZXWzBUGWHyr+VrQ2v
         e0hxZELcW7xoBxv+Nv/Ul28XuCG99Vpu086m22bY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Quan <evan.quan@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.4 065/206] drm/amd/pm: avoid unintentional shutdown due to temperature momentary fluctuation
Date:   Sun, 13 Aug 2023 23:17:15 +0200
Message-ID: <20230813211726.925866975@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

commit b75efe88b20c2be28b67e2821a794cc183e32374 upstream.

An intentional delay is added on soft ctf triggered. Then there will
be a double check for the GPU temperature before taking further
action. This can avoid unintended shutdown due to temperature
momentary fluctuation.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Hand-modified because XCP support added to amdgpu.h in kernel 6.5
  and is not necessary for this fix. ]
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1267
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2779
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                 |    3 +
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c    |   48 ++++++++++++++++++++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c |   27 +++--------
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h        |    2 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c           |   34 ++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h       |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c      |    9 ---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c      |    9 ---
 8 files changed, 102 insertions(+), 32 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -282,6 +282,9 @@ extern int amdgpu_sg_display;
 #define AMDGPU_SMARTSHIFT_MAX_BIAS (100)
 #define AMDGPU_SMARTSHIFT_MIN_BIAS (-100)
 
+/* Extra time delay(in ms) to eliminate the influence of temperature momentary fluctuation */
+#define AMDGPU_SWCTF_EXTRA_DELAY		50
+
 struct amdgpu_device;
 struct amdgpu_irq_src;
 struct amdgpu_fpriv;
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -26,6 +26,7 @@
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/firmware.h>
+#include <linux/reboot.h>
 #include "amd_shared.h"
 #include "amd_powerplay.h"
 #include "power_state.h"
@@ -91,6 +92,45 @@ static int pp_early_init(void *handle)
 	return 0;
 }
 
+static void pp_swctf_delayed_work_handler(struct work_struct *work)
+{
+	struct pp_hwmgr *hwmgr =
+		container_of(work, struct pp_hwmgr, swctf_delayed_work.work);
+	struct amdgpu_device *adev = hwmgr->adev;
+	struct amdgpu_dpm_thermal *range =
+				&adev->pm.dpm.thermal;
+	uint32_t gpu_temperature, size;
+	int ret;
+
+	/*
+	 * If the hotspot/edge temperature is confirmed as below SW CTF setting point
+	 * after the delay enforced, nothing will be done.
+	 * Otherwise, a graceful shutdown will be performed to prevent further damage.
+	 */
+	if (range->sw_ctf_threshold &&
+	    hwmgr->hwmgr_func->read_sensor) {
+		ret = hwmgr->hwmgr_func->read_sensor(hwmgr,
+						     AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
+						     &gpu_temperature,
+						     &size);
+		/*
+		 * For some legacy ASICs, hotspot temperature retrieving might be not
+		 * supported. Check the edge temperature instead then.
+		 */
+		if (ret == -EOPNOTSUPP)
+			ret = hwmgr->hwmgr_func->read_sensor(hwmgr,
+							     AMDGPU_PP_SENSOR_EDGE_TEMP,
+							     &gpu_temperature,
+							     &size);
+		if (!ret && gpu_temperature / 1000 < range->sw_ctf_threshold)
+			return;
+	}
+
+	dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
+	dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
+	orderly_poweroff(true);
+}
+
 static int pp_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = handle;
@@ -101,6 +141,10 @@ static int pp_sw_init(void *handle)
 
 	pr_debug("powerplay sw init %s\n", ret ? "failed" : "successfully");
 
+	if (!ret)
+		INIT_DELAYED_WORK(&hwmgr->swctf_delayed_work,
+				  pp_swctf_delayed_work_handler);
+
 	return ret;
 }
 
@@ -135,6 +179,8 @@ static int pp_hw_fini(void *handle)
 	struct amdgpu_device *adev = handle;
 	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 
+	cancel_delayed_work_sync(&hwmgr->swctf_delayed_work);
+
 	hwmgr_hw_fini(hwmgr);
 
 	return 0;
@@ -221,6 +267,8 @@ static int pp_suspend(void *handle)
 	struct amdgpu_device *adev = handle;
 	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 
+	cancel_delayed_work_sync(&hwmgr->swctf_delayed_work);
+
 	return hwmgr_suspend(hwmgr);
 }
 
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -603,21 +603,17 @@ int phm_irq_process(struct amdgpu_device
 			   struct amdgpu_irq_src *source,
 			   struct amdgpu_iv_entry *entry)
 {
+	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 	uint32_t client_id = entry->client_id;
 	uint32_t src_id = entry->src_id;
 
 	if (client_id == AMDGPU_IRQ_CLIENTID_LEGACY) {
 		if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_LOW_TO_HIGH) {
-			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
-			/*
-			 * SW CTF just occurred.
-			 * Try to do a graceful shutdown to prevent further damage.
-			 */
-			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
-			orderly_poweroff(true);
-		} else if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_HIGH_TO_LOW)
+			schedule_delayed_work(&hwmgr->swctf_delayed_work,
+					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
+		} else if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_HIGH_TO_LOW) {
 			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected!\n");
-		else if (src_id == VISLANDS30_IV_SRCID_GPIO_19) {
+		} else if (src_id == VISLANDS30_IV_SRCID_GPIO_19) {
 			dev_emerg(adev->dev, "ERROR: GPU HW Critical Temperature Fault(aka CTF) detected!\n");
 			/*
 			 * HW CTF just occurred. Shutdown to prevent further damage.
@@ -626,15 +622,10 @@ int phm_irq_process(struct amdgpu_device
 			orderly_poweroff(true);
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_THM) {
-		if (src_id == 0) {
-			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
-			/*
-			 * SW CTF just occurred.
-			 * Try to do a graceful shutdown to prevent further damage.
-			 */
-			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
-			orderly_poweroff(true);
-		} else
+		if (src_id == 0)
+			schedule_delayed_work(&hwmgr->swctf_delayed_work,
+					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
+		else
 			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected!\n");
 	} else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO) {
 		dev_emerg(adev->dev, "ERROR: GPU HW Critical Temperature Fault(aka CTF) detected!\n");
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -811,6 +811,8 @@ struct pp_hwmgr {
 	bool gfxoff_state_changed_by_workload;
 	uint32_t pstate_sclk_peak;
 	uint32_t pstate_mclk_peak;
+
+	struct delayed_work swctf_delayed_work;
 };
 
 int hwmgr_early_init(struct pp_hwmgr *hwmgr);
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -24,6 +24,7 @@
 
 #include <linux/firmware.h>
 #include <linux/pci.h>
+#include <linux/reboot.h>
 
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
@@ -1070,6 +1071,34 @@ static void smu_interrupt_work_fn(struct
 		smu->ppt_funcs->interrupt_work(smu);
 }
 
+static void smu_swctf_delayed_work_handler(struct work_struct *work)
+{
+	struct smu_context *smu =
+		container_of(work, struct smu_context, swctf_delayed_work.work);
+	struct smu_temperature_range *range =
+				&smu->thermal_range;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t hotspot_tmp, size;
+
+	/*
+	 * If the hotspot temperature is confirmed as below SW CTF setting point
+	 * after the delay enforced, nothing will be done.
+	 * Otherwise, a graceful shutdown will be performed to prevent further damage.
+	 */
+	if (range->software_shutdown_temp &&
+	    smu->ppt_funcs->read_sensor &&
+	    !smu->ppt_funcs->read_sensor(smu,
+					 AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
+					 &hotspot_tmp,
+					 &size) &&
+	    hotspot_tmp / 1000 < range->software_shutdown_temp)
+		return;
+
+	dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
+	dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
+	orderly_poweroff(true);
+}
+
 static int smu_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1112,6 +1141,9 @@ static int smu_sw_init(void *handle)
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 	smu->smu_dpm.requested_dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 
+	INIT_DELAYED_WORK(&smu->swctf_delayed_work,
+			  smu_swctf_delayed_work_handler);
+
 	ret = smu_smc_table_sw_init(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to sw init smc table!\n");
@@ -1592,6 +1624,8 @@ static int smu_smc_hw_cleanup(struct smu
 		return ret;
 	}
 
+	cancel_delayed_work_sync(&smu->swctf_delayed_work);
+
 	ret = smu_disable_dpms(smu);
 	if (ret) {
 		dev_err(adev->dev, "Fail to disable dpm features!\n");
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -573,6 +573,8 @@ struct smu_context
 	u32 debug_param_reg;
 	u32 debug_msg_reg;
 	u32 debug_resp_reg;
+
+	struct delayed_work		swctf_delayed_work;
 };
 
 struct i2c_adapter;
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1412,13 +1412,8 @@ static int smu_v11_0_irq_process(struct
 	if (client_id == SOC15_IH_CLIENTID_THM) {
 		switch (src_id) {
 		case THM_11_0__SRCID__THM_DIG_THERM_L2H:
-			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
-			/*
-			 * SW CTF just occurred.
-			 * Try to do a graceful shutdown to prevent further damage.
-			 */
-			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
-			orderly_poweroff(true);
+			schedule_delayed_work(&smu->swctf_delayed_work,
+					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
 		break;
 		case THM_11_0__SRCID__THM_DIG_THERM_H2L:
 			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected\n");
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1377,13 +1377,8 @@ static int smu_v13_0_irq_process(struct
 	if (client_id == SOC15_IH_CLIENTID_THM) {
 		switch (src_id) {
 		case THM_11_0__SRCID__THM_DIG_THERM_L2H:
-			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
-			/*
-			 * SW CTF just occurred.
-			 * Try to do a graceful shutdown to prevent further damage.
-			 */
-			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
-			orderly_poweroff(true);
+			schedule_delayed_work(&smu->swctf_delayed_work,
+					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
 			break;
 		case THM_11_0__SRCID__THM_DIG_THERM_H2L:
 			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected\n");


