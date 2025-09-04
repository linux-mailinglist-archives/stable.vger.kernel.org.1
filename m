Return-Path: <stable+bounces-177774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF72B44944
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 00:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB071750A6
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1572DF707;
	Thu,  4 Sep 2025 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m0NLE3mD"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D0275B0A
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023524; cv=fail; b=FPBjzQrn+7+Q9qCy/oANX0Gl3Y0Bi52FcYbFInefWOLXmckOF35AYoRE/eYqsV6iQ8JrVUCkxMMfgNlv2dFLRturHIxjwVDf11FsdndZ3+x6XS89NHwUOdaIQeE0QlsC4lrwQzF1y9b6jt8G/5+fQb7QZsenrLdOEfOHy9Mib08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023524; c=relaxed/simple;
	bh=W5cQGoSZmHdk+3AFGNpZFtLt/QkxBv7rE054sTkF7qI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EI7bI2MSYcSUAcrrMebweC1MMCrPrsCUrLQSwTsYIInZW3wYYeL8AOi9MF2McA6k6G+QfdjJvGq3AJqcDIbfsuxZ/5rxR9fKWhwO1bUA1YPY/hqZhoDbarVEW25T85DZXMUuzetly4eyTZKr2St9lSpGJIby4ztQawCpVbz1KyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m0NLE3mD; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEhqsNcIiVbA34efvMLpLJy15Sgs+qf1qstcEnX6ViOn71t02YmUBCz1dc7kIOYToVTaMihv9C/nQdaofma//PeUOmZapqhtVIy/Pp6bSwJ/4qylZcG5JuGFNzkhY0Ch5ffU1qd7sFlOzZbiDILufYha2jdbVNrVEMHNue4SIxuVf2VpuL/QEYWrQXETawuqpimUTRofsPXvaFT9JTuCt3/jKbuQw9qFtuD3SbIQ4kOQn4fM/4zKisuJr5eDNXSl0zAksGhR10y8BvNffGD2zm78aF1gmx4XExMTH5v8KEynFudaBSQOraRTnuUsVsAJy+DJu4SEugr9SvEQDDFYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXuqTEcjj3vq5UGJZKXNivtBwXvrSioNq4aueMfHxfo=;
 b=WlZ36ijUAmYgLvjhBMup9Qto1JENPQ36idGfdDglSoSvH//TfaC3MeuID6RxJw3hRfD5VR4Ke9IvGgrgTfdjHFHZ90rQ448hguwBFXFK/kCohq5/r70N/TxChdhgBTNxzFltRZIXQH+rJOSNdF1X/tQqUHIL7ydC9734+1UDCoQtO3/LhAhHy7tabFLFQftpjCyblw7LogJWjF+UctIQQuuo5KRFTDF4n79pox9Y04sjOwI0nrBven/wv/uu2/1nS0YdfQuPCa+Lh0obVDMV0yE0Kt7P5xIXv4KpwBfkubHt7JhULVyMCd+WMh1EdLlzSOSBiOCPucRvApmFvTqxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXuqTEcjj3vq5UGJZKXNivtBwXvrSioNq4aueMfHxfo=;
 b=m0NLE3mD5K/3V7UqvJQ7mVkWsnQzblK/Ily+5zPnuLlPhllwlEpWgr+70k65w9cZy8t4dl78kGqbMnkEHBrZSlP4nqsBnfR+N46hHw/AdIBTzN4QdnQGUfygHFCNia+ruMfGk3+/Fzpi+KB5H32cwdIqiD0zUFm8h/FO7BzN+HE=
Received: from MW4PR02CA0013.namprd02.prod.outlook.com (2603:10b6:303:16d::13)
 by BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 22:05:14 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:303:16d:cafe::cb) by MW4PR02CA0013.outlook.office365.com
 (2603:10b6:303:16d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.28 via Frontend Transport; Thu,
 4 Sep 2025 22:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.0 via Frontend Transport; Thu, 4 Sep 2025 22:05:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 17:05:12 -0500
Received: from tr4.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 4 Sep
 2025 15:05:11 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Add more checks to PSP mailbox"
Date: Thu, 4 Sep 2025 18:04:57 -0400
Message-ID: <20250904220457.473940-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|BL3PR12MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: b58ad1b5-c78f-404e-5112-08ddebff1fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BGjVJY5MPm767VzQ2twMV5vZe3Fjrpz4mrAHw0s3zrs6L80XE2mIX6GPFo8T?=
 =?us-ascii?Q?mVxR6C2fYRxhAPsmAQycHxw0KGfH1YxS7OzTtfSyeb1ljLA2VpkIX0mJgrX1?=
 =?us-ascii?Q?2T4aiGc8fQIteG59fC/tv7KdkJejvCrkT10AHAQNNz/9EcCxzDCUpTiTnuKd?=
 =?us-ascii?Q?+vSvT2OSvYoXyL6hFYNtYgdXlLMcm0t000r8ku4XhQ+2Ksp5VctEf9KhH1ey?=
 =?us-ascii?Q?YB6pgvky8483hNPJURRxlVOPl7OFk/uHennDYDTQzKQJAvuVB9WB5yqASdhY?=
 =?us-ascii?Q?zE0gVrGdYlYKDaVJgcPe1gdxOCSfXN1olEZMeUA5D9VTL+xD23f8OE+F7bbb?=
 =?us-ascii?Q?o7S5FVD1riE7misc+gIwJdhybsGiIE524EUW0vVGe30lNXUwZFJAo7c0d/sa?=
 =?us-ascii?Q?Q0X4gMPHHV+cGSW8p+td57v0NxZWXMV0w1AqFklqb57E2DSc2PwFG7EX3B82?=
 =?us-ascii?Q?1Zxu2aoqa9LM9ngCaP0wPKsoFy4Dl5Q0stiBvLSUOVyOibs7o6qGtTTDJh9M?=
 =?us-ascii?Q?qJIXd770tOCZReKKMBjY4AeuYAWC4eQb3aFNfuzRp9ZWZO/O24SQ71EgShp6?=
 =?us-ascii?Q?ESklxG1E5MsFGZE31GhAg6xvx+o6JhbRnXb9MJO6kHUp/+Z5C5ZtcrqAgh77?=
 =?us-ascii?Q?UJ8iW15fwlDEblp1y78CFnfpHAp1rhC8WMXmw5tEHXux93zXF81sveden5tz?=
 =?us-ascii?Q?GC/Uf0aEWQWdSUut5JkDc6WwieduMfXE7FfQT/nS9x9MZ6XErg61/QYjTh1h?=
 =?us-ascii?Q?LUc7XxuhcTMJl8P/48Hr75gDYzMn4b2WsJhgBcKh91zvRvBwX6Kt1KglOB79?=
 =?us-ascii?Q?iS1Irn5JvvyyhHQV8amDmZV1u2vIogooFZ2AEHtxpeiiSa+fqZAyKvLLT2+O?=
 =?us-ascii?Q?JsjcbugOc58Y9Zl/aBpdGMw2xeeLEJhHxqwreEQT4Qs4MvqH1WJWmwZjwV6Z?=
 =?us-ascii?Q?23oChEgAiQ4582LnkngHK+hKBX1OulDUOCW1Fe293fQ91Bkp6eOlu1omSdgb?=
 =?us-ascii?Q?4dURawNMridAn+E9LWUGIQALL9uK3b4w+3k4xhtobC9pimH6JfcUZU3sIMi/?=
 =?us-ascii?Q?Ka6CVUF+VDHExbs9irTNXyhiWUkCUshmUZ9KhYsEgJ4ElmfyIGylDZRM3RRt?=
 =?us-ascii?Q?wWaZ0inRhufS8Csz6Bf4vpsNl5R9ceJg3MqbwyBQqNaaZGJS2c2ys4FCdHNw?=
 =?us-ascii?Q?TCVMeLeAGKmvUIClD2zS2V1riUFJzsRbZp1718rvHRza+kOqbhaaR8ALyJsD?=
 =?us-ascii?Q?YR6FamihXP3GAVPxDSxrzStvgQHGgO1Ic4p+f+w0LVR1omzWtl4oDOcBujxV?=
 =?us-ascii?Q?T6yWGiy9OcyPwPNSG3B/srO1dWLbvYGfgzANx7uIqtiPLXvMd7IF2b0UUIz+?=
 =?us-ascii?Q?d6Buh5jGYeSlHBp0zjKL01V2YidvWiHCHEIDRzLf8XdxT/ibx3MqNEwRQ7CW?=
 =?us-ascii?Q?NDINjp8VuQjRkeOUas1JLsVA0zjTi+/r314E0EteCwLND3ZenIhMIajLWlCh?=
 =?us-ascii?Q?yde5L+Ejt/9WZ7ICzjLHvcj2ZCxx/zLMf3Vf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 22:05:13.5256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b58ad1b5-c78f-404e-5112-08ddebff1fa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449

This reverts commit 165a69a87d6bde85cac2c051fa6da611ca4524f6.

This commit is not applicable for stable kernels and
results in the driver failing to load on some chips on
kernel 6.16.x.  Revert from 6.16.x.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.16.x
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |  4 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  | 11 ---------
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c   | 31 +++++++++---------------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c | 25 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c   | 18 ++++++--------
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c   | 25 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c | 25 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c   | 25 ++++++++-----------
 9 files changed, 61 insertions(+), 107 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7d8b98aa5271..c14f63cefe67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -596,10 +596,6 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 		udelay(1);
 	}
 
-	dev_err(adev->dev,
-		"psp reg (0x%x) wait timed out, mask: %x, read: %x exp: %x",
-		reg_index, mask, val, reg_val);
-
 	return -ETIME;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index a4a00855d0b2..428adc7f741d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -51,17 +51,6 @@
 #define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10
 #define C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
 
-/* Command register bit 31 set to indicate readiness */
-#define MBOX_TOS_READY_FLAG (GFX_FLAG_RESPONSE)
-#define MBOX_TOS_READY_MASK (GFX_CMD_RESPONSE_MASK | GFX_CMD_STATUS_MASK)
-
-/* Values to check for a successful GFX_CMD response wait. Check against
- * both status bits and response state - helps to detect a command failure
- * or other unexpected cases like a device drop reading all 0xFFs
- */
-#define MBOX_TOS_RESP_FLAG (GFX_FLAG_RESPONSE)
-#define MBOX_TOS_RESP_MASK (GFX_CMD_RESPONSE_MASK | GFX_CMD_STATUS_MASK)
-
 extern const struct attribute_group amdgpu_flash_attr_group;
 
 enum psp_shared_mem_size {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index 2c4ebd98927f..145186a1e48f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -94,7 +94,7 @@ static int psp_v10_0_ring_create(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) in C2PMSG_64 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			   0x80000000, 0x8000FFFF, false);
 
 	return ret;
 }
@@ -115,7 +115,7 @@ static int psp_v10_0_ring_stop(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) in C2PMSG_64 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			   0x80000000, 0x80000000, false);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 1a4a26e6ffd2..215543575f47 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -277,13 +277,11 @@ static int psp_v11_0_ring_stop(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) */
 	if (amdgpu_sriov_vf(adev))
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
 	else
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
 
 	return ret;
 }
@@ -319,15 +317,13 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x8000FFFF, false);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
 		if (ret) {
 			DRM_ERROR("Failed to wait for sOS ready for ring creation\n");
 			return ret;
@@ -351,9 +347,8 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x8000FFFF, false);
 	}
 
 	return ret;
@@ -386,8 +381,7 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);
 
-	ret = psp_wait_for(psp, offset, MBOX_TOS_READY_FLAG,
-			   MBOX_TOS_READY_MASK, false);
+	ret = psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
 
 	if (ret) {
 		DRM_INFO("psp is not working correctly before mode1 reset!\n");
@@ -401,8 +395,7 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
 
-	ret = psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
-			   false);
+	ret = psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
 
 	if (ret) {
 		DRM_INFO("psp mode 1 reset failed!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
index 338d015c0f2e..5697760a819b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
@@ -41,9 +41,8 @@ static int psp_v11_0_8_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
 	} else {
 		/* Write the ring destroy command*/
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64,
@@ -51,9 +50,8 @@ static int psp_v11_0_8_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
 	}
 
 	return ret;
@@ -89,15 +87,13 @@ static int psp_v11_0_8_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x8000FFFF, false);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
 			return ret;
@@ -121,9 +117,8 @@ static int psp_v11_0_8_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x8000FFFF, false);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index d54b3e0fabaf..80153f837470 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -163,7 +163,7 @@ static int psp_v12_0_ring_create(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) in C2PMSG_64 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			   0x80000000, 0x8000FFFF, false);
 
 	return ret;
 }
@@ -184,13 +184,11 @@ static int psp_v12_0_ring_stop(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) */
 	if (amdgpu_sriov_vf(adev))
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
 	else
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
 
 	return ret;
 }
@@ -221,8 +219,7 @@ static int psp_v12_0_mode1_reset(struct psp_context *psp)
 
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);
 
-	ret = psp_wait_for(psp, offset, MBOX_TOS_READY_FLAG,
-			   MBOX_TOS_READY_MASK, false);
+	ret = psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
 
 	if (ret) {
 		DRM_INFO("psp is not working correctly before mode1 reset!\n");
@@ -236,8 +233,7 @@ static int psp_v12_0_mode1_reset(struct psp_context *psp)
 
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
 
-	ret = psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
-			   false);
+	ret = psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
 
 	if (ret) {
 		DRM_INFO("psp mode 1 reset failed!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 58b6b64dcd68..ead616c11705 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -384,9 +384,8 @@ static int psp_v13_0_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
 	} else {
 		/* Write the ring destroy command*/
 		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64,
@@ -394,9 +393,8 @@ static int psp_v13_0_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
 	}
 
 	return ret;
@@ -432,15 +430,13 @@ static int psp_v13_0_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x8000FFFF, false);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
 			return ret;
@@ -464,9 +460,8 @@ static int psp_v13_0_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x8000FFFF, false);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
index f65af52c1c19..eaa5512a21da 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
@@ -204,9 +204,8 @@ static int psp_v13_0_4_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
 	} else {
 		/* Write the ring destroy command*/
 		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64,
@@ -214,9 +213,8 @@ static int psp_v13_0_4_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
 	}
 
 	return ret;
@@ -252,15 +250,13 @@ static int psp_v13_0_4_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x8000FFFF, false);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
 			return ret;
@@ -284,9 +280,8 @@ static int psp_v13_0_4_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x8000FFFF, false);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index b029f301aacc..30d8eecc5674 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -250,9 +250,8 @@ static int psp_v14_0_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
 	} else {
 		/* Write the ring destroy command*/
 		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64,
@@ -260,9 +259,8 @@ static int psp_v14_0_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
 	}
 
 	return ret;
@@ -298,15 +296,13 @@ static int psp_v14_0_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
+				   0x80000000, 0x8000FFFF, false);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
-			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
 			return ret;
@@ -330,9 +326,8 @@ static int psp_v14_0_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(
-			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+				   0x80000000, 0x8000FFFF, false);
 	}
 
 	return ret;
-- 
2.51.0


