Return-Path: <stable+bounces-195103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95389C6990B
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 14:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69AC84E3FFF
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 13:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B32F5480;
	Tue, 18 Nov 2025 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k7Inw8X7"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204922A4F8
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763471905; cv=fail; b=NWBJ9N1r6iObykTEy2cIfblc0sA7hwV9hE5XNnOonTfkw68+r1JUTqq7Y6G6XwJmut3tDPbEsTgJ5aNC3776oV2mvJsfIkz0lgJ3FmJAaC5GVUwmx4MR+ArNaHSC8U8Uw9Gn4faLF2wLkfmM8UXPP2hWvR5lIIC0VaMes5/6BfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763471905; c=relaxed/simple;
	bh=25kbhPLmc5pR4GqZRBQ3ccd4j9kE18al8x/YkyJ0rNs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UHYaPKtxh6e6A86zWXe1p6km1Wrpxq+w9/0pje0mBRgYKn4IHn0uXXplW32kLiLcgqlxN44xK3xhfoeplUD0UQxKInlRKyJ5NgGdFM66XbOWbsdCkKJvKwvrqDT3mUYv12xekfsGNOHTKQQosVyTIbKO7ove10Ji/cjw3zw/cW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k7Inw8X7; arc=fail smtp.client-ip=52.101.56.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/Mh0bPZY/NTdmD5JsmaLoZhIyGG1v69YEErBuczR5f+EXKNgMBZQ59KPgN8lg/VF10Ew+2dpwl2Xgd4dXPjIUhtClLxiQD3IeIcy6ItjRVZP8kokXX4gX8Vb1YWus0DeEMUVC6Oo/h7doKDg28/a1MKKMRPDDluNOOtmLXYWKIcEAcUFsMhzx6KEsuGyNTGCXTXq6Jj0Ltlmzv2ToTBExEztVR2MEj/T50SvNwuACrGBcuf6BH//UZhdw1fSuLYEf9NqMS0SpYjLFEJEOYveBFIwA68ZQYNJDLLct9hVWmggenxoNtq/cYIp3D5yiUnkeXtQLGp79gP4nF4QZ7kGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8d+q8xTlyC6mJM3+c3jXf165svqcSfssjTyO/AGCS+c=;
 b=EdNnJiT3JOB9IWIJ17Cl+bR8gz/AjrP5Nsi4rBLsrZuTnOrIVYJVAECOiddlhH9QpdCBdyYtDH2GqqEWwSBln93Zxyqybd8uWuOXTlM3gxW8S2mBDkW0H8CUb4sqUVHKK/2A4qSke2n6lkXySuXFqcAVsKutuPk52wOAP98g9dS7gPJrIR0N2QKTWn5wgarHeJ0nSB8Fx1m0VenI7rSOzH0T6mvkDsPzxB5Nu3lwMERSZM60LQ0nIxYM8w2RsTxto/mHGLXTD7hLuEFzry7OiP2oaCw1Kj46ZpcfzIBGmlxj/k0SeiG5AbV3O7aV3ZRo68Jz8yf/6AklLGODluEYow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8d+q8xTlyC6mJM3+c3jXf165svqcSfssjTyO/AGCS+c=;
 b=k7Inw8X7VQ9X2V37B7WMtw6pJ1z7x6HAZaa4gtgGw+fPvx9LWLd8vCMCZ1yN7JGB+l4t+GbgAhxGdqet/F6vW3WgbovrJ2xVGb3lnj9YBOwcWCP46Zg9Loz8FNfYdmt16FqVQjXiU9Vj50XvJaHmFaAHetIngZgdoI5l8W52y28=
Received: from SA9PR13CA0107.namprd13.prod.outlook.com (2603:10b6:806:24::22)
 by CY1PR12MB9650.namprd12.prod.outlook.com (2603:10b6:930:105::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 13:18:21 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::e5) by SA9PR13CA0107.outlook.office365.com
 (2603:10b6:806:24::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 13:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 13:18:20 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 18 Nov 2025 05:18:20 -0800
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>, <stable@vger.kernel.org>,
	<Peyton.Lee@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Skip power ungate during suspend for VPE
Date: Tue, 18 Nov 2025 07:18:10 -0600
Message-ID: <20251118131810.163680-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CY1PR12MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0655c3-2f85-452e-fd09-08de26a4f208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hyL28Os4gqWVI2p+V6HzRf/aldNQN1uZ1gPGFcr98TLNp2BLzlGIsHUlkFMj?=
 =?us-ascii?Q?9JOEZyecD6gLiS8VXqqerx/DYifixPsO5UQVMw56BJnZYet05+EBDitOaisC?=
 =?us-ascii?Q?54nM8wCi52098GW1dM3fnngrkrLXcDkTJtE23ByTYd8wWtOsVZ08sQSO/G8g?=
 =?us-ascii?Q?vq8DXySSVuzXNB2Hp6HyZkMjnDDC/16rORbbfMu8ivaaXymC4+gohZPVzGHU?=
 =?us-ascii?Q?ou39FosowfBNmNOTJiK3z0J/z1fcgxF1D6jRGib1JYelw3WAmW1gQICmjS3K?=
 =?us-ascii?Q?r3boWl1YYvQAeFbBBPHuQSiIrFac8L74gYDHbI0mPNqodS/t7yAlloeYGKrD?=
 =?us-ascii?Q?RaosZl72XgnTEUHeRMRB8Ne81vYQofZZF+hPTC+C72T6+xITQEawOWQCbJCI?=
 =?us-ascii?Q?LjdmD9be/oksUnNPwx3eQrs8IoGh10poUrd4R8J6V2tI4/8cbrddTohZ9TuB?=
 =?us-ascii?Q?0cPJ2Bx0O7x0m+/ujWLRKwYN1LXyFbMofN5PbXXvryLgOpI5p8G+Oye4/zx2?=
 =?us-ascii?Q?SE/OwVat6x/q1qOmcJFjCTRaR7d//JUOiZFxXpoq89t6Xarzq97JSPKFMO7z?=
 =?us-ascii?Q?8ocG98+8CFI5v0CV/Qp7TYcdnfLng2t5Zgzegu93YIFf0w/vnZah5wo7JbUd?=
 =?us-ascii?Q?LoF1jBbDk6G3iPS0AKLe32eIJ6msIOSSQTLbKogh4492Y+4mjqs8kARMttvG?=
 =?us-ascii?Q?5MOaGYTQkNi6o9REywXZndHylgeOzfGRTY+VjNDArA7tMXMg44MIrU078YsG?=
 =?us-ascii?Q?3w6XVHzLz4r1UjM8DQayCcfT4Pt7/iWGSCyNPGF8rY4lLjBegqZCPanLrkYo?=
 =?us-ascii?Q?VqtS40/nMBCQKT6w2yjYZ/FW9zNTWuPX9mySDIYI3KI3DVYmJqiaPsTkyyYc?=
 =?us-ascii?Q?/pVblxAPBUKQSj0MeUSVBJcT1XCvlauAmvuS+2IpljcsKy6ysKiET/G6klLm?=
 =?us-ascii?Q?rWywK3L9L4d+1kEKQ5QCCdqfm91Uavj1L27P+b8tE2lJp8qDUAEg5Fqgm281?=
 =?us-ascii?Q?jkTGXHMOkaeWoDhkKRa/7Y5unUaYZe+K/zD4zm7p+a25edWLesEq8oLw/DvI?=
 =?us-ascii?Q?aOZVmsuvwPUGvbxaUxLnBQ1NqF59O1yqlbTQkeodU4l/B1s5DCJ/z2zDvbGr?=
 =?us-ascii?Q?BS+sGPgnhtvOJMoF0NCpuAQVxHHfUlwf/M5zU22/2in7IjkEKxaW+4jJOrrt?=
 =?us-ascii?Q?m2uu96JE5GWTkfA1QymWW2igPIgRGUYN81xLMV1dlEgkmcxfTOYEzt1eq26I?=
 =?us-ascii?Q?1v35F1jO4c/JLmvWWm9/Fj3YSHKgaxN/znUbjfkJIEsIbdCBfZYfeShuvrj6?=
 =?us-ascii?Q?6pBlJOH+9J2na+AZ9u9/S+p10fCIULIXcROYr9sJykdWypW51UyOzq03NRkV?=
 =?us-ascii?Q?6Dx8x6uU6nfCRoGL/Zq0nxJgk+9iMRnXXJajx8Lb73yNUU90BtUnfQ9AAcoD?=
 =?us-ascii?Q?gmG+fbzqRDUFqjz/3ZDNHCOgvyfy00k9h84BKSaAwEFAm7mXAJGV563FnkIO?=
 =?us-ascii?Q?fhbsQawRZs1EdzGDG5TbJynJg1aZx/sk/U19UadVPO56d3IDh8nWJdWfqp3W?=
 =?us-ascii?Q?HB5ZTOYjez6B80d+01I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 13:18:20.9707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0655c3-2f85-452e-fd09-08de26a4f208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9650

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

During the suspend sequence VPE is already going to be power gated
as part of vpe_suspend().  It's unnecessary to call during calls to
amdgpu_device_set_pg_state().

It actually can expose a race condition with the firmware if s0i3
sequence starts as well.  Drop these calls.

Cc: stable@vger.kernel.org
Cc: Peyton.Lee@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 81587f8d66c2..22db0e4154e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3419,10 +3419,11 @@ int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
 		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
-		/* skip CG for VCE/UVD, it's handled specially */
+		/* skip CG for VCE/UVD/VPE, it's handled specially */
 		if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_UVD &&
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_VCE &&
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_VCN &&
+		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_VPE &&
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_JPEG &&
 		    adev->ip_blocks[i].version->funcs->set_powergating_state) {
 			/* enable powergating to save power */
-- 
2.51.2


