Return-Path: <stable+bounces-47794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020628D644A
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 16:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD94528B1A0
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEDC3207;
	Fri, 31 May 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0PxuZOZm"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6C1DA24
	for <stable@vger.kernel.org>; Fri, 31 May 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165115; cv=fail; b=qsTC0oTqWHZEBfTnv4zjuPJbEYQav7qIHtnKVabFihHiAKd+KaPX+Q43f81LSc0KDL5As7FCeXL/cjlmKljKruJakYvuJ1JY4Hi/485IEMMT3I16t7+PbxCKr+lrwfA2KaB2HfyH2jp1N9UfmOSFABbyo94nqDfYFt6sNrfVfq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165115; c=relaxed/simple;
	bh=zBqwXio8EAQZrMUXbi22vTYuMnsYiDIb1wkXYZ/RJjM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lJd5O7uA8EpIXsN66TgYZIAXB/GatbBbdRX3Y+HQtNB8Q8Zi7gJrZ8jAGNmST+GAuwdOfqncpxrZ072ei59DB9VPi6MJc3nV/CtKs1rWomTu/b2cnUry7bozlpwYYBV8AbxF342ftoBhA6Op9U9NxJQMGDLT3ZrYpxo3n8bCDFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0PxuZOZm; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIXaf0xbdeFfuW9txw1tn5GyMYlKtvsI+7cnK1NVxPp6oRTwS0liZSLLihFFx2HTsHDd8J5JazxcZZtDG5JMSP6s5eqte0fJszTcxjTCBHYMt0Qjpr381SDCZhC/OmHfrWgO1mza74UbauyGox/68N/7py0OVAc4Qukw71eQhh6ZpgcUZerufEzI2kNBE/18PRlFKj2W1L90dD8x6+lygX1pBx4G//jzpx2WDbLOgTv8fZuL5GmgISUelmSujQAzKElDoumyL47lkxm4fhwdjuLDYtGPnlyYnw9FWtj9El5wdkCJb1U06J8lkWbcCGxmEFhZqsY4AmPBZiBsGOF83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCrV2o7v/r1HLGKeeIRv+f5X3uWhsHWEJLP8w2xBXIw=;
 b=SKyY68V7qVarXIuhG8S2jtmCztilE+jHrWw7te7foTRQY5Q5rd9hiC1CBV1WhAURSq3SqnZt3A/A7Kho/kFhxptCaeZR2oMicqI534OBSmqDTUFzdaifw0xijoQefVQ3MnvRiaBhc3A9o284mEA+xWxiJWhkBMS7vXNEr+CcyX1I8mFobjR3NpuvQgB1ViKdMHGBWSbhJKEv9zo3qQ8tDGIORRb4CMEWPTMvDzzSAWMo6tF2pqlLFCk5Tn5HZ6E6siqzPC8pSNU759FF0UtoaVnR4jL5Se83Z1AQN1mLcVHyF9k3q1EuT2Wo6hTWTRB+rOjJCCE37T2WD7F6iJSC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCrV2o7v/r1HLGKeeIRv+f5X3uWhsHWEJLP8w2xBXIw=;
 b=0PxuZOZm4hJIjeLWlrurbaqgzHkxRKQ8oYAWql3W5yM+jaNXAiRO0dIfS26r60B0kcuTMIBdDTnPv0ZiMs1EJgrjx46aL1UnqrxPWu57JhOoymiaaPfczfLlwaFKA7OV0L2sB4cODjhgDLm/9PHXfEuoVCNV6ta9yXsp21Xpm+I=
Received: from PH1PEPF000132F7.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::3c)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 14:18:28 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2a01:111:f403:c91d::) by PH1PEPF000132F7.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 14:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 14:18:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 09:18:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Lang Yu <Lang.Yu@amd.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Trnka?=
	<trnka@scm.com>, Felix Kuehling <felix.kuehling@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: handle duplicate BOs in reserve_bo_and_cond_vms
Date: Fri, 31 May 2024 10:18:07 -0400
Message-ID: <20240531141807.3501061-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: a60e7ffb-3da3-46fb-7c88-08dc817c8ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amRLZHVRZVoxMCsxc0IvQ0tYR216SGozODRrblJVVE56Wk95K29QN0YwNnMv?=
 =?utf-8?B?ekJXcHBFZ2QvSlM2MkdLQjNpc0lCR0QrT2JqODAzVDBhMExScThUU2E4czFH?=
 =?utf-8?B?VWVkSTJ5M1BUbm5IR3NWZkMxdDV2Q2doNUFFREpycG8ybVRPcGVLdHFSWFN6?=
 =?utf-8?B?aDNDWjhNNWN5R0lWNU8rdHNEaERwSzY5bnNYYXViRjVjMWZHZ3Y3VU5uZXd2?=
 =?utf-8?B?ZWFwQjk2Q05JV25IMS94c2p6SkxvN2czNmtYNFpxYUxoYlhLd0FGcjExczg3?=
 =?utf-8?B?N0pnK2I1SWl0eEUvSmIrTlNNZDJ2R2pVSFAwYkxkOUY1RVBUOXdQL0tSWnlT?=
 =?utf-8?B?dmFhM01qc1JPVGZaUDJqajMza1cxRSswUHVYeUNZYzZJNkZDR0NVZ0l6ZlBa?=
 =?utf-8?B?TWk1TUl3M2pzRG9za1ZkZ3NYM1k0SmNlVjAyZGFiUVVoRGEyV2pvbm9zdEEz?=
 =?utf-8?B?L2QvTEowc1FIZTF0eGhqOWxZUnJaV2ltRy9wYVhsbXJ4TmpzVjQraDVVaThh?=
 =?utf-8?B?eFdqNEtHYzhBUnBycU82ZjNURUpCVFQ5T1BNYzRkZzFYeEVDb1grMVJtMzBB?=
 =?utf-8?B?dythTnNJUnNtSWwrRWZRNXhyZzM3bk53VlRRaFloRnNSQWxEZWFMLzdSYUE2?=
 =?utf-8?B?T05Cb3NEMk9SaURTdU9aVGlud2RER1c4SVdSNEpKME9DVzRYR01vdEl2WkNQ?=
 =?utf-8?B?MXZJZ1hKbW1WUWREZHMyYVhPQ2xuc2g4cHZBNGhPWTVLVlJjZXdLZUw1bElx?=
 =?utf-8?B?b0Z4ZUI3R1NobzFpMXRoRWxzT3hmTTZpc2srUGtDdXp0dDQ1QXZzL1Bqa1Ro?=
 =?utf-8?B?NCtQb0RnVXp6MWV1YTA4SUN1K3U5VC9FUCtPaGVVOVZMTXNWWlZQOUdzWmFy?=
 =?utf-8?B?TjRjZmlIVW5oVytCaUNWejVVV3B1b3Z6UGs4ZmRnRGxVQkdaOFZlYTZRVmlQ?=
 =?utf-8?B?VjB6eDBGQXNIK0VFaHdKa2FpbjdWRGNHNVBZK0lJaHFDZUxydEdYc2Q2em11?=
 =?utf-8?B?OEZlZFFpbU1hbEJVZkdDWGhZb0tkR1lxV0RHNVE3NFFqeWl2SFRsTzdUaUFp?=
 =?utf-8?B?Y1NsQ245aDB1aTk5WUtEa0pZMVRQV0RITXJHS3pkdEpKNnhBUmZETTlHNG5Z?=
 =?utf-8?B?SFpHeWM0WVJDQ0VpWjRQaVRqcjhBQ3BGWDR0NFZ4M0xxVGQxbDc2Qk5KNFdC?=
 =?utf-8?B?Yzk0QUVXTnJBMEU4ek5oUTlCMEpnaVBFcThyQ2hieXNCek84cEdySEJGYXdL?=
 =?utf-8?B?UWVRRnBEbzJxa2sza0wvMktVYUl6alE1Q0xuN2JPS1AvRTVpL1NZNmVaaWM2?=
 =?utf-8?B?dGd1KzhVdDVXR1BaQ3h5bTBHNFY5NXZIMXdOeGZGTkwzeTA0bVVOTzAxanZF?=
 =?utf-8?B?c2VGb0UyM09lT1V6aHVZUGpCQzlPYUJKL3Noc0Y1bytYbHB4K21tM2ZqOE5l?=
 =?utf-8?B?c3hOUlkyaTh5c1lRUTc1bUE4Sm5vS2hRcEtPTW0zOVo4cjNoVThuZjNqUTRZ?=
 =?utf-8?B?UlJwNWNDMnBIWHBZK0N4bFhyeXFCenZock52MDJucEtSL0xPSWtDeW1IdnZ4?=
 =?utf-8?B?TFJJMkcyTVZHNFV3S01DbmJiaDBud2dRQkhNTUJBQUdwbTJQOFprbHUwS1dJ?=
 =?utf-8?B?M2cwVk9GWDFRUnBsTDVIUHoxMDJBSkhxV25VQXRacHorWWVqbjNJa28vSUpp?=
 =?utf-8?B?OC9LY1JVeWVvVHJtT1d0ZjF3WGt3aEpYaCs5UmRBaENCS2NJaGc4K2hBaXVn?=
 =?utf-8?Q?x7xiybMcMO0Exwq2yFpwLhQFWKLqJ4L2L45SptS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 14:18:28.4100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a60e7ffb-3da3-46fb-7c88-08dc817c8ae0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793

From: Lang Yu <Lang.Yu@amd.com>

Observed on gfx8 ASIC where KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM is used.
Two attachments use the same VM, root PD would be locked twice.

[   57.910418] Call Trace:
[   57.793726]  ? reserve_bo_and_cond_vms+0x111/0x1c0 [amdgpu]
[   57.793820]  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x6c/0x1c0 [amdgpu]
[   57.793923]  ? idr_get_next_ul+0xbe/0x100
[   57.793933]  kfd_process_device_free_bos+0x7e/0xf0 [amdgpu]
[   57.794041]  kfd_process_wq_release+0x2ae/0x3c0 [amdgpu]
[   57.794141]  ? process_scheduled_works+0x29c/0x580
[   57.794147]  process_scheduled_works+0x303/0x580
[   57.794157]  ? __pfx_worker_thread+0x10/0x10
[   57.794160]  worker_thread+0x1a2/0x370
[   57.794165]  ? __pfx_worker_thread+0x10/0x10
[   57.794167]  kthread+0x11b/0x150
[   57.794172]  ? __pfx_kthread+0x10/0x10
[   57.794177]  ret_from_fork+0x3d/0x60
[   57.794181]  ? __pfx_kthread+0x10/0x10
[   57.794184]  ret_from_fork_asm+0x1b/0x30

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3007
Tested-by: Tomáš Trnka <trnka@scm.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
(cherry picked from commit 2a705f3e49d20b59cd9e5cc3061b2d92ebe1e5f0)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e4d4e55c08ad..0535b07987d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1188,7 +1188,8 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
 	int ret;
 
 	ctx->sync = &mem->sync;
-	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
+		      DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&ctx->exec) {
 		ctx->n_vms = 0;
 		list_for_each_entry(entry, &mem->attachments, list) {
-- 
2.45.1


