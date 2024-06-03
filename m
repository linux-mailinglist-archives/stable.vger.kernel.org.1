Return-Path: <stable+bounces-47874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9838D8535
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 16:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778361F21363
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F612FB15;
	Mon,  3 Jun 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jH/Udoig"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F53E12F386
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425356; cv=fail; b=j5/LNNJl4mLK43QavnyeS/PNWNEaJVgSW+KaqAvFCft7a9uEBfZ6kLMbreD69PIppqiB98RdM7OViXRbSNduWpm5dNyM9taj0e+sUaQEwgnAFT7I65A6S0PG0skzd/d1+h7Z2qpmBj3W29puTnoNUbOmkWYmEHeLF216nv4W83M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425356; c=relaxed/simple;
	bh=PEUDEZfGXqomnWwjTbCJ+ZQu9EkIcDmPJC9cks50WHo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dimwha8N05TM5Dd831kdWO8xk6qH/a43qffDeGuI3UYv4amGN4CwlwpKNI9HiFx7JAmrjrQml/h0V1nItx68uBde0rYgB5stxRElIIXgnlWMmkVI6TqluS61qJ51t8g/8JNbf3C2HpBbI1vYVNRQpgn0T65AyngrH+/klzAUCvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jH/Udoig; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMenoJNNFsWfdJGAbyG1PzTjoivrZHByNVpH0Nk3oZGGYRh3EefauhnL0Djz23jCwue54/WVcFz0xMeIrAPeOE8zE9mn16eUOT0BLRIZWr4y0Q7FhSdrgw1B5iMWQSdrxNzXqxiHyqNMiMCsjboLDLC9NXemly1hWYNLjnrg5482FrQ4dQjZnezFmSCeJ43VvhAg2CRkW1IrLrAeasxRgQCmebXCvV5Xis1IIv2+YOJnefySwti9ULqhd1+qXaRxR47Y076vVpYX7hUV5cIgT4TF1z1xtb/ikathTNhwOZ6YBT3xVIn9/jJYhltFvxClAr/1LlFS5cnS0gvmzUVt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWkvFWLcBxzErtzpOWyoevecgqYsrvYpnTw+n0+RahA=;
 b=DLOSMB076/hW30UFwae99NYRoQy2UayYj8ObaBvy79wCk4qBbSJ8OnygsG7HxPxScD7b6VjfV2+YhXPDTYcHqv/f046KGKPt6z2IWky6bpJezXcqSjhIMbpTCN+DNNpnmg64RjO3aZ0btcXT6MH2qbf3i1Cfz29mP/4fECwhAa5OamncuyM3ZjhhcOzvUJV333MqAjGsaBPiHUUg/DeQtCRjwRw55ygliJXss0+yPb4TJvNYRqv4vCfvgxvhDjEVPgqcHmnhyFcVU5yjXNMaS2zbrvSmlUKHCukExb3mIyIOrYEVvfUfR8P0v1ChB+CQZayuQVpZTd3698YrnsOlRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWkvFWLcBxzErtzpOWyoevecgqYsrvYpnTw+n0+RahA=;
 b=jH/UdoigBuZ7U61zzyOpzmouboRsuPJUMqzAR/XIPRSgMEZcRXB/83voYankwLPSyomlqTkZ+Zsxy9Z+C6LAt82/IUhsk82Gqz4eqYY0YkADf6GC1isW/hIxGieSPCoASDhzMxQYtHZL6zbtZkR7X/1qdGp+c/mlIGT8XyVBpSU=
Received: from DM6PR06CA0065.namprd06.prod.outlook.com (2603:10b6:5:54::42) by
 DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Mon, 3 Jun 2024 14:35:52 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::5a) by DM6PR06CA0065.outlook.office365.com
 (2603:10b6:5:54::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 14:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 14:35:51 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 09:35:50 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, Roman Li
	<roman.li@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] drm/amd/display: prevent register access while in IPS
Date: Mon, 3 Jun 2024 10:35:05 -0400
Message-ID: <20240603143505.75910-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dd3dc6-4bbb-4b3a-3dc6-08dc83da7805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l4Cbx4vUL3C7TyR2MnDtqKGxBEGYkYBS/Y3im4gUKF+oHpDCo72G+zCq9e47?=
 =?us-ascii?Q?03vk6c9staoTMn6RKgrC/6Jn9HY0o2tMixDM3UHEEqKnZILWJ57SHlNU/59o?=
 =?us-ascii?Q?y1smBLlxZEO55YoqzEpNWMfcFIEmfl6JelW3LsBiBuAWZMJxdmerb0a6A68G?=
 =?us-ascii?Q?Mob4lXiQBiNVuC5LN7DiFhG8oAcqA+8213GUwVTmgI5mGFQqTGgNiEECCDGP?=
 =?us-ascii?Q?W7b7sTVR7tpOE85hwCollLY2zdH+pT0/tq+Mgxu1xb001hC8RgBO+1y3Fhoh?=
 =?us-ascii?Q?rdL9ZrkL0SmFHi26CcUH+UWoIcj7CC+qaFEt8Xt4isXET0wBkhvVHw5r+Cl2?=
 =?us-ascii?Q?1XFbkfWogvW/2w+c7SMwh3qFLesS8cXDgIhlJf4xXnd6TV0q3xXuSy3+7Pu6?=
 =?us-ascii?Q?dzc6UVtLZoBIc5Up4/52mQrL8mcS2gxkICJouDF43d6YtFOpG16uX64CnBAz?=
 =?us-ascii?Q?L2fz7xlTzlI7ZfTceQ6qNbFpYIShUnWtgTusjyZ9ihe8xD8L/q3vY3OGbjxV?=
 =?us-ascii?Q?cRBifTePXignu8xqBwu7+4wobDHhDWoQbl1CpmKJm1n4Ox58IS7+qPOXgH5N?=
 =?us-ascii?Q?ya6/77g/upG2fV3EpTry3eFLMLfbU59b0M6xdmsSLaEbSNqo4AH9jCMO1fgr?=
 =?us-ascii?Q?dxjLmy+PiNxRUJObqdOCGi8+SHiA9q9O2nA7pmWQ+fHDtqgKfstcsxPHQbtg?=
 =?us-ascii?Q?O4zoK1alTMUoxVg2erJXdJQRsPdu5y7+VTUm3dYVfj5Di8amejmDyPYeVQHy?=
 =?us-ascii?Q?BH1M2f6oW7Y5wKVQ2Vk4BS3plaiBN6+Q/3tcEaXXI2Qr52Bigm1cPfJPM3Ge?=
 =?us-ascii?Q?3Tmx+GLjeqf/v65ZwcocLubdx8yK8ujimdHQ56oZ8ubQgIgtCLtNX8vgpOZh?=
 =?us-ascii?Q?EbRYHb/+6YS9kYMMXrs79tnVSiiPbnhLxrfD/yWJNs9vWDz8XEmyS+006cPP?=
 =?us-ascii?Q?XSIgEby94YzSP+w5tmhEv/7zstQ5md+VN4O2cbK63J7O2uX4PVXuDDObOciZ?=
 =?us-ascii?Q?VkqHh2EmcgjQGQ0dRgHn+NUkmg/G3cCEkqi1hF8QWBFwNSvbxlLF1lBrT05n?=
 =?us-ascii?Q?j8IbQopqgSKLZ25TKRRU2XkFN/u/n9ndo5cLgxIVWCZiP7NgACyyy6Z6ke/q?=
 =?us-ascii?Q?E1nNXkww6DD/HrdjhDlRFEypv7657g7QM4dTyl/8ENgq7LWUHuq7wYoPGtgw?=
 =?us-ascii?Q?KjgLHAiZ/9Vj0JHYR+4Ab6FENh9+J+6OGyl5aTHGRWWLzKvbX+SvCOBVOm0C?=
 =?us-ascii?Q?O3EyCVon0b8ByYo3xLrv8HI5d/5y4Ph7GTktBclMoAknSga3EdzmO8POoAhe?=
 =?us-ascii?Q?PVgY3F7PRw7p0GcKOiDGHcVZo9A6UY3u00mbzJLMKcjcGbOxKQ5myYFffi+S?=
 =?us-ascii?Q?sT0rOQw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 14:35:51.8705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dd3dc6-4bbb-4b3a-3dc6-08dc83da7805
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639

We can't read/write to DCN registers while in IPS. Since, that can cause
the system to hang. So, before proceeding with the access in that
scenario, force the system out of IPS.

Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 059f78c8cd04..c8bc4098ed18 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11796,6 +11796,12 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
 	mutex_unlock(&adev->dm.dc_lock);
 }
 
+static inline void amdgpu_dm_exit_ips_for_hw_access(struct dc *dc)
+{
+	if (dc->ctx->dmub_srv && !dc->ctx->dmub_srv->idle_exit_counter)
+		dc_exit_ips_for_hw_access(dc);
+}
+
 void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
 		       u32 value, const char *func_name)
 {
@@ -11806,6 +11812,8 @@ void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
 		return;
 	}
 #endif
+
+	amdgpu_dm_exit_ips_for_hw_access(ctx->dc);
 	cgs_write_register(ctx->cgs_device, address, value);
 	trace_amdgpu_dc_wreg(&ctx->perf_trace->write_count, address, value);
 }
@@ -11829,6 +11837,8 @@ uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
 		return 0;
 	}
 
+	amdgpu_dm_exit_ips_for_hw_access(ctx->dc);
+
 	value = cgs_read_register(ctx->cgs_device, address);
 
 	trace_amdgpu_dc_rreg(&ctx->perf_trace->read_count, address, value);
-- 
2.45.0


