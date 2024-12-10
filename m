Return-Path: <stable+bounces-100463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C289EB72A
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 17:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F65A283514
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988EE230D30;
	Tue, 10 Dec 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NzFnSgUa"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D122FE1E
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849565; cv=fail; b=nkyUtJ7LcHXo8g3nNLTlaGwFWU209qUpdOIpMgyJRf+5yhjTExhEcvz2Sy0dB8kLa2xHOHa+kekU+mVYNBxmEQvjVJAgHop9ulwFnxWJIivDAykDj0vkothSvFkDI81ag5Nr5YQwD3wWkUgV0x0yoZIPs/oz5Ji4WTT1FSU+2rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849565; c=relaxed/simple;
	bh=U6MDnYysJC4dWR1jz05RiUzUUvI17yxA05Z5MMrCVK0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y0MPmAI6fQo2d87mjom2Dq9bwTBR82OWZInzhQqGsAs5M0KAnD9jIJohQdjYnWOOs0lq2Cs/BnQKaiPvpbu35wDfdu/ORfRssjIEJ+z0mr8eoyOVPz2I5D5burR3iHEZ+1kkWqbcti6SfDSNWkA6teV1L3d0ih2fRG06CFeKu2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NzFnSgUa; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTmqAWze6z3ET3kSeM0o6/WJ+2PyJZcw1pyXwzse9KwADngqSfjyqCaCpy/bkSywRWSrc/JDm4GS1I+ONbRiaXTt9J/j2qE1Bv5q+h9ryvvj2PjNbrCK+vFpW9RvBnCsnOCwZVl9Pmq5h5/gMv4RKMP2Kx8DXtoDymZ3QXPpZ+glCBHZWX2bKrY9dGZsWnCUjIiPGm/OGhzdQH/hZu+LbD39/pmnvMbYO2M9KbQrQQaF3Reob5BpNE/dxFLJF5YwEC6XfUrzDkled28siOZanSeN1j2/2iKcWY8tvRJ/b6w+rcxPMGxsF2GnuHKc5tc0vzXgHPtJOrtcBJpK/3VgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQWWdxCmIre5AblerCTx5dcnZcyl3apgtObyHFZjD3M=;
 b=o/4sEs3bM2ZWpsBcbP303ss76VQ59WghqcNtdG3tYWoDHtVY+vmMR2cNIbTSbpKsbZ/VaGscL5GYHIkMm1zx6j6Xp1I08P5GNBLPSv+ZbZAbsRmGa7pmuMqvSwP57BYxLijxQMiO610dbih+KleyPy8bgsa/bFiVPDVjhVDrUVQRRCmLw3tmkY7HuZv5NrymdLbCewi9NVvgFkkO8VS+CEdp4XyHKu58V+9NY0xGH7VFxUHnn4u/6K7uNzTOfpTUxNe1O/f2Rh0SAb+NcOZi0rWj7n+OO9fhtbECjoHOCZUHIimPzBQOT2k2XYEI9IwiFteBKkj0NgmtaePQTm9KyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQWWdxCmIre5AblerCTx5dcnZcyl3apgtObyHFZjD3M=;
 b=NzFnSgUa8l3WiW2zfmv+rvBjRaPqU67seVSWx6gOETkX16eJITTckFPqyM/J+f4rt9uqZOy6a61bkthnsA2A4Ezaz3TwNsN6mllQxZTOyljZ+dWb9oeamzQjp1rRKe00KcJ4pK3hYqthNxQJdWuTqjCo1CyvLKZ1r1DTZDpU0fk=
Received: from PH7PR13CA0002.namprd13.prod.outlook.com (2603:10b6:510:174::6)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 16:52:38 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:510:174:cafe::64) by PH7PR13CA0002.outlook.office365.com
 (2603:10b6:510:174::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.11 via Frontend Transport; Tue,
 10 Dec 2024 16:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 16:52:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 10:52:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: rework resume handling for display (v2)
Date: Tue, 10 Dec 2024 11:52:19 -0500
Message-ID: <20241210165219.2865887-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: acbeb29c-a07d-48e1-a4aa-08dd193b0dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUtBVUc1bjZpSkVDdFVEbVByeDVVQklDN3A1aUVzTnBCSHRvU3dZZzJ1TFRl?=
 =?utf-8?B?RWJKTkNja3hoODE5b0lycThFZkI0VC9hNUhzLzJiUWVzWmkzQU90M0FyazNh?=
 =?utf-8?B?Yi9mOVJibTRvUDArVktQcllvTlBuQ0VsRkwwMzNDOVhMaCtlNFVSeEQ5bito?=
 =?utf-8?B?bmdRWGFzaGVsMnk3NmdTS2Z4QjNCZmFqTlZOZDFpalBIYlI5cS9ZaVp6UStT?=
 =?utf-8?B?aGNGRVdmR0J0eE5aaExRWXgwR2l6a1V5Z0N5UTh1UmxvUjY2cVBHRjYwallp?=
 =?utf-8?B?UERJeFhCTVJoT1F2N1JiR1ovTDFMMWthSm8wcTFKT09sOFNmVHBDUGN6TnpC?=
 =?utf-8?B?SmY2Vko0R0VxdHJTTitlbk5qNUpIOXN3Qk1LZFMxT3B4NXBjbFc4TDBFam5X?=
 =?utf-8?B?TE52UWpyWWladlBqYWRjSTFnZDVabnMzNlRabFhVVlhxZVRoa0VIVHdCUnNs?=
 =?utf-8?B?LzhyWWVLd2l1YXZXajQxYnlaUGh6Nkd4OXFJQytQNTdJVHdhR2pFaTRBUzEy?=
 =?utf-8?B?L2dyTksybytnSnJOVk8rRmM5VDREQk0xbG4zcFova0NUYUM2eFk1QXQ0Vkx0?=
 =?utf-8?B?TDhETW9sZGhteHVQWHoxcnZta0pGRjBJNTZWWjRvV3dxdTFlelcxY3NTTEVl?=
 =?utf-8?B?MjVQWTNoUWV3Q3hVOHJSclAxZHAySlNxSHNwZktDdVllL0V1K0xON0Ftd1dH?=
 =?utf-8?B?dmJ4WHdtclBlSVdpMFgwK2dwL3Erc3duUmFYU1JOMDhoN2ovUlBDMTdaZ3pH?=
 =?utf-8?B?cnRqaGkvdkVWRG5PaGtoLzdwQi81azAyZnd4dWJNK2J1R0Vra1RpS1oyNVNC?=
 =?utf-8?B?SHlVaFFGMHRLSG00UjRFWi96c2M3c09BZTZ1dmZ4Z1JRWU1QRzdWdzA4a1lm?=
 =?utf-8?B?QnBEM3VKZGR2Q2hhcGM1ME0xWmd0UEoyUlVudFdkOVBpdmgySzE1Z3Vnay9L?=
 =?utf-8?B?Z0pZZGg3eG5MOTV0Wm9HSlB5azRDYlNCU2ptYnQ0NkEvYlRrU1JVZ1ZWUXY5?=
 =?utf-8?B?R005R1FHZ3dEUllnWUZFaVFvVFlQZWhTSHlRQVFNVkNxNWhZUFJ5VGJ5WWhX?=
 =?utf-8?B?bjJ3TmoxRU8rREpwd29YSlA3VUU4OXFhemdocVZsL0tpMHl0eUVwVEpHUFQ3?=
 =?utf-8?B?RVY2M2ZINURTRGxZbGlxK2FwQ3dzNmNacGNYckE5RlRHNktlbkpnVE9uYnNK?=
 =?utf-8?B?QXA3OFpVZnNLcVVXa0loU3pra2hrbjI5YktGTTEyZ09EcXNxV044T2s2Vk1w?=
 =?utf-8?B?T2lnZWZJeEEzS0RZSGV5eDdhdnpseXNVdjJuRnJ1RzA2Y0YrQW0vRS9zaFFi?=
 =?utf-8?B?VDBDcjZRbCt1NVpUMUI2aHpLVElTRFNvQjM1NklnZk0yejdpaXYwSkVOVzNY?=
 =?utf-8?B?VUJiaFdaVjNVQUhMQUtiQ3ZDSldWbmo4S2o0MFU4NzBPbkVQMFlrUkhaRTBu?=
 =?utf-8?B?eDBud0xhd2dKc0QzMSthOG5iM3krc3hjaEozM2JDTXMyOE5DQnh3VG9NU21a?=
 =?utf-8?B?MGEzbmZ6alpoMWcvSThKcFZEU2FZckFMS3Zmc0lFZnFLN2N0VTFld0NsSklv?=
 =?utf-8?B?T0ZpRmg4bXNlejdaK1Q4R1dJWi9hM2dQYWNRMnBHUWZqZG1FRXk0Zkh2UGw4?=
 =?utf-8?B?bUtkc0JFL21wZjFhVXp3M3kxTnUvWGpoR1J0NExHMVZFY01pNlNWZm5Jcy94?=
 =?utf-8?B?dFBzaU95QVFNQklKck85SU1rSERRNER4U2d3Q3RJS1J1N1ZZS05GbFBqT3lC?=
 =?utf-8?B?MHdMTjlzTjY0MUtCVm13K29tS0JhMFZsNDFKWHl6MTVtOUlGZFB1bGlGWGhU?=
 =?utf-8?B?YnFCQ1VKK3FsZkJBQ1E5SXY2cFJaai9TRWlKU1V3aHB5TXRWeDlNcWJTRUNZ?=
 =?utf-8?B?OXhrcFFBQ3cwRWdOZlpEZlVnWHg3U2NtUWllZE9ETnI0cUFxbml5R09wbTNW?=
 =?utf-8?Q?4wf/c7XoihHxByDrrhi79W2+PitRvOgb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 16:52:37.9999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acbeb29c-a07d-48e1-a4aa-08dd193b0dc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

Split resume into a 3rd step to handle displays when DCC is
enabled on DCN 4.0.1.  Move display after the buffer funcs
have been re-enabled so that the GPU will do the move and
properly set the DCC metadata for DCN.

v2: fix fence irq resume ordering

Backport to 6.12 and older kernels

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.11.x
(cherry picked from commit 73dae652dcac776296890da215ee7dec357a1032)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 +++++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1f08cb88d51b..66890f8a7670 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3666,7 +3666,7 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  *
- * First resume function for hardware IPs.  The list of all the hardware
+ * Second resume function for hardware IPs.  The list of all the hardware
  * IPs that make up the asic is walked and the resume callbacks are run for
  * all blocks except COMMON, GMC, and IH.  resume puts the hardware into a
  * functional state after a suspend and updates the software state as
@@ -3684,6 +3684,7 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
+		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->resume(adev);
@@ -3698,6 +3699,36 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * amdgpu_device_ip_resume_phase3 - run resume for hardware IPs
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Third resume function for hardware IPs.  The list of all the hardware
+ * IPs that make up the asic is walked and the resume callbacks are run for
+ * all DCE.  resume puts the hardware into a functional state after a suspend
+ * and updates the software state as necessary.  This function is also used
+ * for restoring the GPU after a GPU reset.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
+			continue;
+		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
+			r = adev->ip_blocks[i].version->funcs->resume(adev);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_device_ip_resume - run resume for hardware IPs
  *
@@ -3727,6 +3758,13 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 	if (adev->mman.buffer_funcs_ring->sched.ready)
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 
+	if (r)
+		return r;
+
+	amdgpu_fence_driver_hw_init(adev);
+
+	r = amdgpu_device_ip_resume_phase3(adev);
+
 	return r;
 }
 
@@ -4809,7 +4847,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 		dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
 		goto exit;
 	}
-	amdgpu_fence_driver_hw_init(adev);
 
 	if (!adev->in_s0ix) {
 		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
@@ -5431,6 +5468,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				if (tmp_adev->mman.buffer_funcs_ring->sched.ready)
 					amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
 
+				r = amdgpu_device_ip_resume_phase3(tmp_adev);
+				if (r)
+					goto out;
+
 				if (vram_lost)
 					amdgpu_device_fill_reset_magic(tmp_adev);
 
-- 
2.47.1


