Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6B77794E4
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 18:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjHKQke (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 12:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbjHKQkd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 12:40:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B0F18F
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 09:40:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrPd9oPOu7xvLITlLGvtw+LE95PN4IunFaM7/rxfTY8CXMy75eau5pA1aEr1QUp6vnsW+u3jobCNd85oviUq1qNjStWPu1gY0DM+kN+sH2bICZf/JZa6JXtbwfxHNzmFzMY/AxtPLiisLibmjdStMCFi0oVQ+WMN95C+OyUdxnuAC7zbIrETmI8Phuv5xaWyRAGOYQrnzzVeDvdSbgS2fCbP4XHBZKTp21v+NwLM5vXlrX0VADbjBhJNl8uW3xH1Ut427sUAQHHNX5OejeQVkPIId9mg6hVJOJvLNVhJGrTD6H8qYxVw2y1p7AGg4Mnjx264xqnFsSUakQf2GC11fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBnJrAZJXpH4mx/bOVTKMRXr47Ci3v4TTtnj5Z4tD9A=;
 b=Wqhqc0k1Ep8MZ9rXKQ2aPJBtSxhfTrIaDrjfrsmW15TJeIz3z/JharPHTcUl2WxKMY4wAKw0MNKSky7pRB459Xf4/gboxlpK4vXaaSmgw+7YQzUNRSfiuS742BhhmJfnP8+PfWju6gL/0AfSoLBS2Ekz59CUgMwd7bRGjTwHUdnpIBflsmjWmG26jnhMTVJmbTenWOrVjVWqFKN/lyx1El9am5XmEAvvUFhMP0qSScapTh9bPTEEX0C9E4YS52PnmBo6Hy2sip7n1Jx7eewnpz75OgslmNaYTyRn7la4JaxawGn1+eF6cE9HSO7yQ63/b8Hbc7JiG02V5QPB5rYUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBnJrAZJXpH4mx/bOVTKMRXr47Ci3v4TTtnj5Z4tD9A=;
 b=cu5bkZRwtrsBBT6hsp7qro+nW1rWo5SrCXav5M/YLNDHk8LdHyvVifyjOr+D6HWyW9oG+379T9aFfcqYiSIxX4QkBM+j1qmYzJF8ETLympxZ0+g96mwxluA+V27BYwhy2eG1N6CZXCO73J8bjaiVo5trj+xFWhTlVl3CH3jT8YM=
Received: from BN8PR16CA0007.namprd16.prod.outlook.com (2603:10b6:408:4c::20)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 16:40:28 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:408:4c:cafe::25) by BN8PR16CA0007.outlook.office365.com
 (2603:10b6:408:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 16:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 16:40:27 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 11:40:25 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.4.y 2/2] drm/amd/pm: avoid unintentional shutdown due to temperature momentary fluctuation
Date:   Fri, 11 Aug 2023 11:39:51 -0500
Message-ID: <20230811163951.24631-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811163951.24631-1-mario.limonciello@amd.com>
References: <20230811163951.24631-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|MW3PR12MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 2beb69b7-3e29-492d-b830-08db9a89ab30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQGzdIGxqHwQE17OVFVKItDmOuob5dL1WLyj4LhiO66X6gLdjB2bJCks9KRAh9TsBmEU/tgy6wu/+MxYxRCHn0WlbFYiDV3G1lvpREMB72AmijJJ6hH15SZDjacFy4CRYDY56I7w3CPK5CUxTJNFnCr6y5CVaZLc+k4wMvhrP0LxUJ0P51ITe2pPLzEV3xufmFx8AjiZm7q93+quHYB99Ky7wuhq3ZEcKK46MOW5UpLgwNeKdALVlEwwai9EsXT2sHG7lo6B6n+p8WNuq9n5FXEWXnNFSz4MQLoOkh76/DM4VUihw1iU+Y8TEhIFzrdwkf2QeLuZPWWGoSqHfBz4lYywMfI5LWZ97OKor/AE+N6yOOYGv8cEIutYO6LzCqf2S8m3kTAe8vF2QKU7p6i3yBvdRell9lQ3LXJ71ewlkMxDvyeRlfhen5OrHNq9Bu//SOrG93gwTw9KVIqWuraRjQZDY1i21I4Wnw14Jo+Xv7QA4/EXw4bF65kTmybTEMoxAAZjoGaUS3Ih6I7soK2gVZQptPNvORxgf6zbM4kknghpPY0sttQtLF3PBB4jeWYgySjHXv3Xy1k8Ww49l4+QrHdMVPKxAI7WJW20Cryd5VNqNNGmdWqh0DvY4MCm3TDgIbyQ/HYzBXki7Lh/6EkO0xr9x3GK1/sYARsurtBEmf/r9GLS5wKFh9YXfFhcdasx/hxskecK5sknUcVOfO13kFPvI6KK+1nepxVavPCMV4z2Sl27/fbDLEHkWNBir0MfS1Bw3QUlaYq4QHeAHiZQLVT7+1yVS0ENpcQq4Xs3y0c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(82310400008)(1800799006)(186006)(36840700001)(46966006)(40470700004)(16526019)(336012)(426003)(30864003)(6916009)(41300700001)(70586007)(70206006)(316002)(7696005)(966005)(478600001)(5660300002)(44832011)(1076003)(8936002)(8676002)(2616005)(4326008)(83380400001)(2906002)(26005)(36860700001)(47076005)(6666004)(81166007)(356005)(40480700001)(40460700003)(86362001)(82740400003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:40:27.5569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2beb69b7-3e29-492d-b830-08db9a89ab30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

An intentional delay is added on soft ctf triggered. Then there will
be a double check for the GPU temperature before taking further
action. This can avoid unintended shutdown due to temperature
momentary fluctuation.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b75efe88b20c2be28b67e2821a794cc183e32374)
Hand-modified because XCP support added to amdgpu.h in kernel 6.5
and is not necessary for this fix.
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1267
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2779
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 ++
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 48 +++++++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   | 27 ++++-------
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34 +++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  9 +---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 +---
 8 files changed, 102 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 129081ffa0a5..c895aa204238 100644
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
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 11b7b4cffaae..ff360c699171 100644
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
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index bfe80ac0ad8c..d0b1ab6c4523 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -603,21 +603,17 @@ int phm_irq_process(struct amdgpu_device *adev,
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
@@ -626,15 +622,10 @@ int phm_irq_process(struct amdgpu_device *adev,
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
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 5ce433e2c16a..ec10643edea3 100644
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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2ddf5198e5c4..ea03e8d9a3f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -24,6 +24,7 @@
 
 #include <linux/firmware.h>
 #include <linux/pci.h>
+#include <linux/reboot.h>
 
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
@@ -1070,6 +1071,34 @@ static void smu_interrupt_work_fn(struct work_struct *work)
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
@@ -1592,6 +1624,8 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 		return ret;
 	}
 
+	cancel_delayed_work_sync(&smu->swctf_delayed_work);
+
 	ret = smu_disable_dpms(smu);
 	if (ret) {
 		dev_err(adev->dev, "Fail to disable dpm features!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 09469c750a96..6e2069dcb6b9 100644
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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index e1ef88ee1ed3..aa4a5498a12f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1412,13 +1412,8 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 79e9230fc796..048f4018d0b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1377,13 +1377,8 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
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
-- 
2.34.1

