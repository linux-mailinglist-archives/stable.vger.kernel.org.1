Return-Path: <stable+bounces-12301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E67832FAA
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 21:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BCC1F21D80
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 20:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE25646F;
	Fri, 19 Jan 2024 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rgndQQsr"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FBB58AA2
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695329; cv=fail; b=TvZfvs6TZQkNjmni2jPEsRGQJ6htajar+IDstepBqwmX2PuFsITD3zDWp7dxy2Q/82DEUqQQf9o3gTz5kK8IQDHHnXC6LjfctO8l/+mLQolwqBGP7vMQ6dxu1NXqx7ZmdhIol2QV1ZYrMTxiEX2aglB6VXpNHX7Rq7cmVEAqNGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695329; c=relaxed/simple;
	bh=zWVtmo94+U4uEn1Xzj3uKM9J7sO2xNsRFKfXEKHf300=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Urr2+obWZFLsv0PIquwWdC2/yVytk9vTzt0zARS5WSiyXjPQaWH0vGO287EZP/PGj/AKJVIwe12Y3sL6w6HkOaciHSd6T3z+BR7kuPOkl3L8wLqYD22ciLqnYXuCNIDhnrcL4CxrltjyLzzOAPpSHh46zYUqU5gJot1k/JxuSeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rgndQQsr; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIs2fpCC9D5IN42Jc/dULMZz3BV2e971L2ianzqN1wrHbCnguJ1vVuorbF4doB3C6XU5bqcm6stD6JugZ0T39cBayxS/ec5YuwGqW/z6bOK+TBGNzlzxa6S7ORLGHg7QYvAJlAaLZwoopzI5/IwNe5VSW3VRyA3oJ1FNVlxHKFSM2Id40rc0mjPGCm/UA/APs6CL3vyHcZvZB0hWnGPW3TT+rgLiVZmi1Kb7OUTfJ1fJ9KjK+eM0xZLGMg7kprIVgutLiFyTrzLtAH4cBn/L2hn1tY6hrTmQuN0Q+4aDCoiWbJUaODmxphk2dpL4Cu0RN0pcjzi2Ks21gT5hsFHlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5vqgMhyg64ZaYeB0P8kMmrFGXOEMS1laEAV0w/8h5w=;
 b=LWoX8jADtuLz4QysQHS8E5c4J0n3sg2nLrVITT87g4XaFH8P5YtQ38tVvFA3yV8JhPnhNVz1hrlAfFwqm8Qyx0RA23GykJW0wSmPGyTI9oClnNs0nqNlMET5kpD12qqsgctz8tSz0qEXUo0L0Dtqz1PuCWl/mg6VnbkYFFkY8M77cKCKzJ/9FUcB/9PpOJWG8wGqNm4nbc4lRwsPkTem61RhiTrxG6gqtF/EI6zyvtIPMeMrHScAYZq+0hHd6WiwEUnCxqf6TTR3mR29+Fy5WWG/FuoKjg8R53vkX7LrLgz8zIZP4IDmXyyMT6Nnfe9NtkLwF6VftBcFiW1e9w0pEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5vqgMhyg64ZaYeB0P8kMmrFGXOEMS1laEAV0w/8h5w=;
 b=rgndQQsrz5qZ1eNWG6vTsmKiNse4scw80/1i/gzRTTrPdGlE8ilv5uJ+YUh0zQb8DiGH0CUgb71HRZdrj0hIT/2qNH11XPGd25hYGNsKg1hgr7Jh1Hn+wxS+trV6nEHQ8aHAhwU58rkeoqF5i2/e6cSIyE5q3yF0sOHY6CIcYeg=
Received: from CY5PR15CA0253.namprd15.prod.outlook.com (2603:10b6:930:66::20)
 by DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 20:15:22 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::11) by CY5PR15CA0253.outlook.office365.com
 (2603:10b6:930:66::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Fri, 19 Jan 2024 20:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 19 Jan 2024 20:15:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 14:15:20 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Kenneth Feng
	<kenneth.feng@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] Revert "drm/amd/pm: fix the high voltage and temperature issue"
Date: Fri, 19 Jan 2024 03:16:00 -0600
Message-ID: <20240119091600.30188-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DM6PR12MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: 132c29ab-2b75-4ff3-4835-08dc192b5d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L1t/cHng65El4Bnk2g8Bbdg57r3tVNGfqh5/0RYFbLLkzQom9TVkalCJ2psIXXDL2P9By0ZwskT0U8ELAtcjlxLONH01a+xqzV2li8lQmggjDuJB0X4HMa7y5uMBd5upUcOc1nXccDlafqBEvatQS7RD1MVowZSuHxGTyP2RlgOURQA7cILImIVAz8NXKkEn9+kxnLgu9zg6THK1H/zh4Xv/nZ1aYbT8VNe+wPMW9gObOriJzbcovYQZEhdiBvXbKw/dRVuDvWMOdUc4XWkywhjr+orQB0mjhQDvJgK44awnHkznOH5Wa0VTWJ1cGjEZ87SwYjds68wj57ykPAavV8EI1j4345EtEvQscilbETQK3THUG6+s7Kzs4JXSznCkusqOKnMuqxRz8Oy8y045abUKkcOa/owo+MdwrxU03nW7oj7h0hmxD5rASLgDOkp1jDm3cNu2ScH4sCE1wJ5+SmqSIazqezsLg0mcXnUIt4mfokJWAH9eU/rQXFVDTbmWhcXVqaFbJpsLjOEAnpM+ZCjridEU9nBvO+TJDdXCiP57q7460yuwqKsmIzgRyeBhyTxKMx92tGPzBxrIcof0RW+YlyocrNbjHv0jN3OLbu8FYfpCT9C7/t/XwSlsCwjAENTXNUBt5hRQqwg5Xq0081aKkWq+nSyRS+eTee0YlajPoqL2OUZIjIVpMgNXDCdE36RztH6KhKTaYHJri/WgmkxcpaFEGzagIXAodb8RMcdsuusu4H3f4HIqHgNBOXjfglVClxUN3ZnUlual//p7Ig==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(426003)(8936002)(966005)(336012)(2616005)(1076003)(83380400001)(47076005)(4326008)(8676002)(5660300002)(316002)(6916009)(7696005)(6666004)(70206006)(70586007)(54906003)(478600001)(44832011)(26005)(16526019)(81166007)(356005)(82740400003)(2906002)(36756003)(86362001)(41300700001)(36860700001)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 20:15:21.9840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132c29ab-2b75-4ff3-4835-08dc192b5d62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563

This reverts commit 5f38ac54e60562323ea4abb1bfb37d043ee23357.
This causes issues with rebooting and the 7800XT.

Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: stable@vger.kernel.org
Fixes: 5f38ac54e605 ("drm/amd/pm: fix the high voltage and temperature issue")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3062
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 24 ++++----------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 33 ++-----------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  8 +----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  8 +----
 5 files changed, 11 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b4c19e3d0bf1..56d9dfa61290 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4131,23 +4131,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				}
 			}
 		} else {
-			switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-			case IP_VERSION(13, 0, 0):
-			case IP_VERSION(13, 0, 7):
-			case IP_VERSION(13, 0, 10):
-				r = psp_gpu_reset(adev);
-				break;
-			default:
-				tmp = amdgpu_reset_method;
-				/* It should do a default reset when loading or reloading the driver,
-				 * regardless of the module parameter reset_method.
-				 */
-				amdgpu_reset_method = AMD_RESET_METHOD_NONE;
-				r = amdgpu_asic_reset(adev);
-				amdgpu_reset_method = tmp;
-				break;
-			}
-
+			tmp = amdgpu_reset_method;
+			/* It should do a default reset when loading or reloading the driver,
+			 * regardless of the module parameter reset_method.
+			 */
+			amdgpu_reset_method = AMD_RESET_METHOD_NONE;
+			r = amdgpu_asic_reset(adev);
+			amdgpu_reset_method = tmp;
 			if (r) {
 				dev_err(adev->dev, "asic reset on init failed\n");
 				goto failed;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c16703868e5c..961cd2aaf137 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -733,7 +733,7 @@ static int smu_early_init(void *handle)
 	smu->adev = adev;
 	smu->pm_enabled = !!amdgpu_dpm;
 	smu->is_apu = false;
-	smu->smu_baco.state = SMU_BACO_STATE_NONE;
+	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support = false;
 	smu->user_dpm_profile.fan_mode = -1;
 
@@ -1961,31 +1961,10 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 	return 0;
 }
 
-static int smu_reset_mp1_state(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
-
-	if ((!adev->in_runpm) && (!adev->in_suspend) &&
-		(!amdgpu_in_reset(adev)))
-		switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-		case IP_VERSION(13, 0, 0):
-		case IP_VERSION(13, 0, 7):
-		case IP_VERSION(13, 0, 10):
-			ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
-			break;
-		default:
-			break;
-		}
-
-	return ret;
-}
-
 static int smu_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret;
 
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
@@ -2003,15 +1982,7 @@ static int smu_hw_fini(void *handle)
 
 	adev->pm.dpm_enabled = false;
 
-	ret = smu_smc_hw_cleanup(smu);
-	if (ret)
-		return ret;
-
-	ret = smu_reset_mp1_state(smu);
-	if (ret)
-		return ret;
-
-	return 0;
+	return smu_smc_hw_cleanup(smu);
 }
 
 static void smu_late_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 2aa4fea87314..66e84defd0b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -424,7 +424,6 @@ enum smu_reset_mode {
 enum smu_baco_state {
 	SMU_BACO_STATE_ENTER = 0,
 	SMU_BACO_STATE_EXIT,
-	SMU_BACO_STATE_NONE,
 };
 
 struct smu_baco_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 231122622a9c..bc8bd67c48ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2748,13 +2748,7 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-											  SMU_MSG_PrepareMp1ForUnload,
-											  0x55, NULL);
-
-		if (!ret && smu->smu_baco.state == SMU_BACO_STATE_EXIT)
-			ret = smu_v13_0_disable_pmfw_state(smu);
-
+		ret = smu_cmn_set_mp1_state(smu, mp1_state);
 		break;
 	default:
 		/* Ignore others */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 59606a19e3d2..0906221231ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2504,13 +2504,7 @@ static int smu_v13_0_7_set_mp1_state(struct smu_context *smu,
 
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-											  SMU_MSG_PrepareMp1ForUnload,
-											  0x55, NULL);
-
-		if (!ret && smu->smu_baco.state == SMU_BACO_STATE_EXIT)
-			ret = smu_v13_0_disable_pmfw_state(smu);
-
+		ret = smu_cmn_set_mp1_state(smu, mp1_state);
 		break;
 	default:
 		/* Ignore others */
-- 
2.34.1


