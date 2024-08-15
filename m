Return-Path: <stable+bounces-68725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF36F9533AD
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A651C24127
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C517F1A01DA;
	Thu, 15 Aug 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OX6u/YXL"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AAF1AC8BB
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731468; cv=fail; b=TQ0KnavGnOjr3urdd2sps1sTMzBFEqOGX/1eNkLlfM+QkArVOEgurxj+l3MNPJWDGHC3nu+SlJg/yXIqKTzkOkt6cn8YKwz5kZqY6lcy9JTBKYVlSYUmuO1MtjYvnTrmdfejrHa0Ncj7H/pJ09QS5ZawpubMXNQZBF6dsktoPfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731468; c=relaxed/simple;
	bh=WaI8IdFbn+8HM1mSHTq7YYM6j5iTKBaSla0ITKTHDsY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FrOLjhHHQnMh1WlL1sYTGBXhA7EG7oSpGYS2ei807ckFHv7frWbVWtT58x+daUREdwi/eP8jbFQ2vtI74PE1WPrRy3iE7JrjnHxIGgU7cT+1eOkCCDnygKsd0uvc4/WQ/qsPygFCZw7DkoqDf46Ru+LmXRV0inDqoS0xhHH/9qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OX6u/YXL; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYdvGoHX8qRnRRKefifzhDg0oBEbeYmP1Y/CdBwG3KWJdQMPkvznxCsLKac1OWrqPBRHpg9BIQHQpe2tYv7rJxLw04pWsJMRYJohXb2l1ASOs1Qw9fhMq2qp/pnGmTrkZw/+6TNIV9kSRErs8yX0x+zsYx8RKklvGJLG+zATTtUHkHv9mgtoKj/tOnw3DUtAypLlC24AHvwC1MIln810S6T9bN/NIFpZdYE5ZGV25Wrz4y9l1OGQQfPvjU/JqLsoFIM8vMNTRpAs7gIJ5lWk+KbFKB2a1x9aGwgetpOJ+bRDoKmU1qSCdkQFbpohqaAbjCX1CkcYrJIpEzDpFBxC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcoLtzZ2eakSIBBJDNgl01sOXWwzl794+qE6U368YL0=;
 b=bbLE0ErO1/tNp6LQ7UpULbUaJVbT8pHLZXjckq6eIXUfIaFFmrVKWrNzNqEiiTvBljS4fJjuAyte+XOfYvBVcygyjw9ZB+A/hbLpgb5w2Qleuue5a3pR7WfhQskcN209+U6Bzis7LnywhL1Ap9+NjOuydCY3iopRd9JXnhPY4OsSpY26os6VzWvOo/WUfy95sNucboNfDgV3j0oQuL6qcgUiSQJS0AxSCCoqp1O3WrsWbE9AeLCU15VAyEXjUQK2IFOHBgyN9l0csl/a39o4U9mUURGvRALfv8ayIFgasqtFLqnFmYxDJCFj8MYL8zn+IJEfQtgMvF4gpDRW552gXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcoLtzZ2eakSIBBJDNgl01sOXWwzl794+qE6U368YL0=;
 b=OX6u/YXLVo+I9STgaHYdf3my1ZeRSM2LUMwlqdy4olCP7w+bq8Mrfew5uiPBQGw0I5v084flJEh+++vCOxkMtRTEWctT/HL2OQdcgBqNwnG3/JE5EEsBWee0voTRGZpHGT8C3I4tJGfMrpx4MKyOIe74HmQZSEf/GNvpvSAtCn8=
Received: from BN0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:408:ec::21)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 14:17:42 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::18) by BN0PR04CA0106.outlook.office365.com
 (2603:10b6:408:ec::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 14:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Thu, 15 Aug 2024 14:17:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 09:17:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Friedrich Vock <friedrich.vock@gmx.de>, Alex Deucher
	<alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Check if NBIO funcs are NULL in amdgpu_device_baco_exit
Date: Thu, 15 Aug 2024 10:17:27 -0400
Message-ID: <20240815141727.2495838-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 2300db97-b1a4-4f70-6f84-08dcbd3506a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTJMSDVQY1gwUXFyMzl1QStxeXVlUkR0WWFrUE5nenV2UC9ncWRuNEFMbXFh?=
 =?utf-8?B?TmJNWDltVHl1MmNwU3Fyb2EyYjBvdWhyVmpUWHhYcmQ5OGJlek9RNnpPTlZZ?=
 =?utf-8?B?b2dteGQrUHZycFdVVW1ZenViNjNSVXh5NnN5M0NMMUJvSWZORERZTVFsc3dP?=
 =?utf-8?B?YnBvNUJkb0hTdnVWcjlqOWEweWlXbGVBeTVmby85K0dLMno2TUE3TGxTMy9H?=
 =?utf-8?B?ck5kR1JuMHNPOXB4amdZYnp2ZWhaUzd4dlhKZnNvb3hSSFJjaFBMUXNRbVo3?=
 =?utf-8?B?OTQ4ZC80UHdXK0hBWnlPTjhjbHA0WGQ4N0xtWEgvU2lhekFmNnEzRVJZWXNk?=
 =?utf-8?B?OXZaUjN3ZWs2eER5T096Z284dGVneFNtdDdCN1c2YjFVVEJyZDQybnpNeGpK?=
 =?utf-8?B?eEFlUUV4cXFnb045N3RRN1pGdEFPRDEycjFDUFp3cktEbEEzc2VtanVDLy9o?=
 =?utf-8?B?R3V1MkdQSUUxaDhtdFhlZEcvU2srdHJTaEZuRDhNSVRnVGF4cDNyYUdTR0dp?=
 =?utf-8?B?ZnRrRGxteDVHQ3pTM3hZRXhuWklkRWxpRUFGVTYrZ2JsUTdKbnhxZkdkeU5T?=
 =?utf-8?B?YzJMNUgvRlVFT2YxVWZVbzdZU0pUSnBWT09vcXVrU3dUUFdXT0JpRXdTaCti?=
 =?utf-8?B?S0hUS1daK3pxUk5TQWRrNUFRU1FKSS94cmVkdC9HbGJOUSt1TVVhbzJnd3Mr?=
 =?utf-8?B?ditrMERCMzA5QTRwUDh2WVhJK2VTVWtMQ204dXEyRU9Pa3NzTmNmVldQaW0w?=
 =?utf-8?B?MXVqdkdIdm9KbSswUFg2YzdKelphVFl1S2gzeDcvL1JCNG45L01sdWRIYlZp?=
 =?utf-8?B?alpXSm9BVFNqK05jRENTbG1YRlVFOE84WVkvNUJjNElpU2ZWVzdtdWdybFUy?=
 =?utf-8?B?NmxvSHVzUEpNVGNPWW1OREZhZm1rbGtiK1VGOWtCSTJFK3BzanFTckFONVRo?=
 =?utf-8?B?QVY3Q2J1SmRGRzdNTWNLNnVGSUtQKzJEaU85WnBuS2NLUzR4OGxPdXR0b2Vy?=
 =?utf-8?B?UjhqSStSYU91RTd1VnZmL2o2bmwzUVJONlo2RU4xcTl1SVhGNHhvRThic3BX?=
 =?utf-8?B?RlIzTVBqOHBmamd3cG9xU3ZtUWpRQ2dJS2h2VFJacnRZRktrVEIySy9xMC92?=
 =?utf-8?B?b3pDZ1JkLzV0MXJybnBCRFoyZVR2Z3NVZmQ0Y053ZXVORFM1Zy91dU5zM2Rn?=
 =?utf-8?B?bHh5b0FUTXlzRWVkbnFDc3RWdHpmMDZVd1ZvRy82WVJNRjBicVoxTkdZUGx5?=
 =?utf-8?B?NzluY2VmbFRJbVpZUm1iSm1LMEE4L0o5V0QzK2J4WXkzTWZpeXVvVmU0MXE1?=
 =?utf-8?B?M1ZQeTZRWlo2S0Y5SmpLcFJCdEk3RDAzenJiejkrODBKSHczcUE5eFlHenJL?=
 =?utf-8?B?OGZUdWROVVNyamhaNElKTk91SWgzNzAySWZCcnA3cUZWNmNxVzJzUlNkRTNG?=
 =?utf-8?B?OUJMbkJVTWNpNXlzZWNFeWY0NmVOblVSWmlJOWV4MmRCOGRLL2RQQUJpN0ZL?=
 =?utf-8?B?QllFdE5KS1V0aTZHNi84b2kyYmc5QytjemU1OEVjbC9lemNJKzZ6R1JudkRY?=
 =?utf-8?B?UnlXNnlYaFFJZnkwWkw4aDlQbGVjY2hwK1VoYUNYRllKckVtblJqWjVicDg3?=
 =?utf-8?B?NUlVbTRkZHlNMlJWUFNWSktjYzJFUHg0cURnR3ZOUk9PZHZacFdOTFprYlR4?=
 =?utf-8?B?azY0TFAzdjlUV0tRZTV1eHZtNXZ1MGxHZ2RTM0lwT0FVSmdUbU8wbnBRS0VV?=
 =?utf-8?B?TnlrQk9Yb2Ewc3duNW14Y0NSUjlpSHFMTGVMc3FOMlVYQTFuN3A4Z1BKZ05i?=
 =?utf-8?B?d0tIbkx5ZjEzelFBMm1Na2duYUZzUFVQV0hsczg0OVZ0bnRSSjRpUzkzQUhF?=
 =?utf-8?Q?TMTu2d7OYrpjC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 14:17:42.1539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2300db97-b1a4-4f70-6f84-08dcbd3506a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979

From: Friedrich Vock <friedrich.vock@gmx.de>

The special case for VM passthrough doesn't check adev->nbio.funcs
before dereferencing it. If GPUs that don't have an NBIO block are
passed through, this leads to a NULL pointer dereference on startup.

Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
Fixes: 1bece222eabe ("drm/amdgpu: Clear doorbell interrupt status for Sienna Cichlid")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3558
Cc: stable@vger.kernel.org # 5.15.x
(cherry picked from commit 0cdb3f9740844b9d95ca413e3fcff11f81223ecf)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5f6c32ec674d..300d3b236bb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5531,7 +5531,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	    adev->nbio.funcs->enable_doorbell_interrupt)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
 
-	if (amdgpu_passthrough(adev) &&
+	if (amdgpu_passthrough(adev) && adev->nbio.funcs &&
 	    adev->nbio.funcs->clear_doorbell_interrupt)
 		adev->nbio.funcs->clear_doorbell_interrupt(adev);
 
-- 
2.46.0


