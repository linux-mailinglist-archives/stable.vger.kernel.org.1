Return-Path: <stable+bounces-165539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA10B163FD
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 17:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF6B4E8118
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56483299AA4;
	Wed, 30 Jul 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c8b76bEF"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D313AA3C
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891163; cv=fail; b=HtrWhN9PL8CXK3q/oe6ap2r0jTnHYtmam+LPfwzol5PJjiYtZf6GSoxBDSTEUrtHioKPlsTsFdSNPO+m44xr81nKOcXJC8o7nRn3poLdfQvGfl9Uviz4YYoozXBx2FRnzqQnihv7aJlLzEGWUFO585I2kPe/+XR7TBJEgdkxPy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891163; c=relaxed/simple;
	bh=Hbefsp4/KGs7dhM3iC+yRa2ky+6Dv6qstoa3PdvjTRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kZYf41PZIzfrMpuI4C0rhFE5Hq8D8vaXfKAz9Mzo4dw1LzEEqNLOebNHx8km9ggXNOnjD0UWH4va70OK1JdGl48VHz3WvacapHH7CTrSBtPTSb5pxN4osqdXguSphVwHNgl9dGyOvjXtuNaaLxffc0x4ap67hc26fzj7UYvREnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c8b76bEF; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBpvFFveH45LnNMe1LmdaYQTYfyJ0Fol9VDhpWZJT/6r6w2oZX227jNTOGURU/Neqq+ZTztjONNMBGlFeisX6gp60xuMEhQ6CyAjtzHhKjIDVvKbrcnXVabL+xLSBeNQRJH8rTtFO9DbEPAZpazFPiawk4Lh8y4csH6KZyI3kNu/gVOMD9BzQWsgb4j8c31kM9Lg6o3ZmHEnEEiJf7X82FDpdsj98hzv+tlEadVbiSTnCIf7hYb2EX0kYIYOE8KcGPkLcZkbmbPuIjPXFdi9xeODp0jSiPDc1uubtRFT+OP95Eg+fUqA9PpWppEHDH5Ybq5ePTsimFZ5X6vDGASrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC2ggBRvaG6A+/TCGEtVAa19qKXLIim+APlZiZ2aIqw=;
 b=g/XiLjyKlj31OU4SXth2dZpCQWJg0mOvfxoXTSZBG1ri48lGWs/BDiZ8daSTJ46Wd4lT+Y2TMKZEqx8CJHST9A5CXsdmijv7Jsfh+r//AtWyN5Pi8hasI6jH9e/w5TWXaKLF+wrJU8v7XZfTa0il4Wb7jdLjuLtlbS+xRHc80pcAId3he2HXUim78WrH2UnusYLGqJPewkzQQUdS2O0rY0E37ayck1L/hRcnFdpsVVIr+z7dFcrmDV8xaDAC99TLAIz4ZF61Ma/EQIuSmSJKS197pZ9bF6wA6OFZmimgZpaHXLySOhji4amXbUqFhtSpBsz4PhuczGacSjvfpqZ9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC2ggBRvaG6A+/TCGEtVAa19qKXLIim+APlZiZ2aIqw=;
 b=c8b76bEFWqNOzg/b9Q6nRZMR1LbqSsCGsdfzitSUjgjwlDF1SZNAqRS/FA2UC8LC7Dg4SvUzQ+PmzqAZivxZIr1U9P8+vAuyaHyq/DlWo+6IFzJ93IzWQwhdi6dCmhQULdh0Uo+xea/uB04HdPuJvc+8qsUJf+O8IdJj0fSnFOk=
Received: from DM6PR03CA0031.namprd03.prod.outlook.com (2603:10b6:5:40::44) by
 PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 15:59:17 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::d6) by DM6PR03CA0031.outlook.office365.com
 (2603:10b6:5:40::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 15:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 15:59:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 10:59:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu/discovery: fix fw based ip discovery
Date: Wed, 30 Jul 2025 11:59:00 -0400
Message-ID: <20250730155900.22657-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a4951a-8fda-4fd7-9300-08ddcf820956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ukfrMCdKOxnoDkThLwd97xq7rlCAJKmG/e197WVG/Ul43YsTZCJSo+OLrqV/?=
 =?us-ascii?Q?EFACX6xFcSsUE5pJEam9VuU0YUJ+V3sRkDQUyYz+1XifwMRIdxC5qvPdozKF?=
 =?us-ascii?Q?NcfMUoOcPgi3edqvwjecA4hP9DoAYcyxo4BdqAfNVSo8M4JnIp5h+6sixK4P?=
 =?us-ascii?Q?IKIqKSEFi9EHoDR+FIzzs94lic5rHQBZIz+4tCqWeuAcrGO9e5qO47ErUZfw?=
 =?us-ascii?Q?khPCZb1zdVYoBbLMN55uidHjwvemiEmHiYnkZrJM9V6Tl5aR4HGNgSepYfer?=
 =?us-ascii?Q?FNHzxtCpbl1isEeT7odmq982LmJxt8EIEWWTr9CZ/VRYKEf3IFAZjvlszs4j?=
 =?us-ascii?Q?LuWC4sblWmJh89YSf02G8+LQTAlHlmVe+hJF5IJPFxvBxFduu0ke4o71hZyM?=
 =?us-ascii?Q?q/ePi2W1LH1bKQuh0UWlDcIQXTAxlVFmfQql6vnweVvzRA2JgOHjvZS+xAJn?=
 =?us-ascii?Q?/F+TIf+f93NmTli1L4UmFt7vF5adTHi8xfSbN0TDKY5Fzw2iAiBANhYtdEO+?=
 =?us-ascii?Q?OqC/KmT0o8aNS2WpGZuKpfIouYMiZbF1pqjijsPsdh2qrFfvKb8aSN1KosvU?=
 =?us-ascii?Q?UOUu+UMGw5mXhsZnJjjM0ht6HieNcUcJYkZqFJWEbZFzxh9kOLopBgyVyH6l?=
 =?us-ascii?Q?zpoTFF1xb3uoX3eNJ81vvX2MiTp5q49ShoHMssJ45VYUaISMaGDlDJHc8QcN?=
 =?us-ascii?Q?8XqDWQpJafAIhLEAUdUjtn/EcrkkM2paSyqPGuS9HZviwHF1ZnlRnoWWJ0pU?=
 =?us-ascii?Q?pjXQVh2Et12SFVwwCvaRvBdAltA8rrU7E/l1jXYLAjTsGohzqap0whbOndrY?=
 =?us-ascii?Q?iGIofwGehfcCjBnk3QCw0ib5oVrZ6amJO4PEr3g8bsXriEDxN4xSE2u95Cyu?=
 =?us-ascii?Q?9n3F5LB/YAjXM9tkhXLAUZEG8Y+r1y4xA81FTsv8EVEj5NZZCvFgTpDXrOCr?=
 =?us-ascii?Q?pMjHWZJhBPsbjxDFaBFiPCi+xi+c9rgw9/K98G7wd2EY0mhi1n+yzE7Jlq/r?=
 =?us-ascii?Q?o0j3JjK119ocT1EWR8Gg3y9eeHhHiIc6WWXmBMvESV86ISfdshRShdbX6nVZ?=
 =?us-ascii?Q?IRFIVeORKK/iece344ZG1b1fIjwg4gzR78Qrv/B8CTsEIzrNzFvu7xyNbn2g?=
 =?us-ascii?Q?dFjik3RE8+MzJuzu4t+K+4REupa+BZJ0In4/f72GtERX5pi6OmNg3R+/L0v/?=
 =?us-ascii?Q?8/efZS9PBqQw/ymiH05CYYA77P7MCIC/Whpcn36eimQMFL7TH5P0JOcx3JYf?=
 =?us-ascii?Q?7KlLfGeOrGHr3lXCg9652TmJgj41eQ95ktx+44O5n4pWcGGc8OON7KXl3PZF?=
 =?us-ascii?Q?rGZErwOFqXv/QzYU556hkFLK2quQ/VlFM7dSgKhhuuxh/4AvLLRMrR2aQf/c?=
 =?us-ascii?Q?IVj2ChKY1rqGRyIi7XpMsgSRsnelAVOWArC8aB4eIxsqbNLexnMxoHDEmHey?=
 =?us-ascii?Q?MMI7/EMdJidnAS6oNRvrwsWObz/+7NgGMUIXYe/FZnbpXWVnthe/Yw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:59:16.5062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a4951a-8fda-4fd7-9300-08ddcf820956
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221

We only need the fw based discovery table for sysfs.  No
need to parse it.  Additionally parsing some of the board
specific tables may result in incorrect data on some boards.
just load the binary and don't parse it on those boards.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4441
Fixes: 80a0e8282933 ("drm/amdgpu/discovery: optionally use fw based ip discovery")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 72 ++++++++++---------
 2 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index efe98ffb679a4..b2538cff222ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2570,9 +2570,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 
 	adev->firmware.gpu_info_fw = NULL;
 
-	if (adev->mman.discovery_bin)
-		return 0;
-
 	switch (adev->asic_type) {
 	default:
 		return 0;
@@ -2594,6 +2591,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		chip_name = "arcturus";
 		break;
 	case CHIP_NAVI12:
+		if (adev->mman.discovery_bin)
+			return 0;
 		chip_name = "navi12";
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 81b3443c8d7f4..27bd7659961e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2555,40 +2555,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_RAVEN:
-	case CHIP_VEGA20:
-	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
-		/* this is not fatal.  We have a fallback below
-		 * if the new firmwares are not present. some of
-		 * this will be overridden below to keep things
-		 * consistent with the current behavior.
+		/* This is not fatal.  We only need the discovery
+		 * binary for sysfs.  We don't need it for a
+		 * functional system.
 		 */
-		r = amdgpu_discovery_reg_base_init(adev);
-		if (!r) {
-			amdgpu_discovery_harvest_ip(adev);
-			amdgpu_discovery_get_gfx_info(adev);
-			amdgpu_discovery_get_mall_info(adev);
-			amdgpu_discovery_get_vcn_info(adev);
-		}
-		break;
-	default:
-		r = amdgpu_discovery_reg_base_init(adev);
-		if (r) {
-			drm_err(&adev->ddev, "discovery failed: %d\n", r);
-			return r;
-		}
-
-		amdgpu_discovery_harvest_ip(adev);
-		amdgpu_discovery_get_gfx_info(adev);
-		amdgpu_discovery_get_mall_info(adev);
-		amdgpu_discovery_get_vcn_info(adev);
-		break;
-	}
-
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
+		amdgpu_discovery_init(adev);
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
 		adev->gmc.num_umc = 4;
@@ -2611,6 +2582,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 0);
 		break;
 	case CHIP_VEGA12:
+		/* This is not fatal.  We only need the discovery
+		 * binary for sysfs.  We don't need it for a
+		 * functional system.
+		 */
+		amdgpu_discovery_init(adev);
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
 		adev->gmc.num_umc = 4;
@@ -2633,6 +2609,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 1);
 		break;
 	case CHIP_RAVEN:
+		/* This is not fatal.  We only need the discovery
+		 * binary for sysfs.  We don't need it for a
+		 * functional system.
+		 */
+		amdgpu_discovery_init(adev);
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 1;
 		adev->vcn.num_vcn_inst = 1;
@@ -2674,6 +2655,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		}
 		break;
 	case CHIP_VEGA20:
+		/* This is not fatal.  We only need the discovery
+		 * binary for sysfs.  We don't need it for a
+		 * functional system.
+		 */
+		amdgpu_discovery_init(adev);
 		vega20_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
 		adev->gmc.num_umc = 8;
@@ -2697,6 +2683,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 1, 0);
 		break;
 	case CHIP_ARCTURUS:
+		/* This is not fatal.  We only need the discovery
+		 * binary for sysfs.  We don't need it for a
+		 * functional system.
+		 */
+		amdgpu_discovery_init(adev);
 		arct_reg_base_init(adev);
 		adev->sdma.num_instances = 8;
 		adev->vcn.num_vcn_inst = 2;
@@ -2725,6 +2716,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[UVD_HWIP][1] = IP_VERSION(2, 5, 0);
 		break;
 	case CHIP_ALDEBARAN:
+		/* This is not fatal.  We only need the discovery
+		 * binary for sysfs.  We don't need it for a
+		 * functional system.
+		 */
+		amdgpu_discovery_init(adev);
 		aldebaran_reg_base_init(adev);
 		adev->sdma.num_instances = 5;
 		adev->vcn.num_vcn_inst = 2;
@@ -2751,6 +2747,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
 		break;
 	default:
+		r = amdgpu_discovery_reg_base_init(adev);
+		if (r) {
+			drm_err(&adev->ddev, "discovery failed: %d\n", r);
+			return r;
+		}
+
+		amdgpu_discovery_harvest_ip(adev);
+		amdgpu_discovery_get_gfx_info(adev);
+		amdgpu_discovery_get_mall_info(adev);
+		amdgpu_discovery_get_vcn_info(adev);
 		break;
 	}
 
-- 
2.50.1


