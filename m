Return-Path: <stable+bounces-161432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AED8AFE7E0
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 13:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9480E7B04B5
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA072D3A89;
	Wed,  9 Jul 2025 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p+jkYJI0"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01328A1CC
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060863; cv=fail; b=IN8ma/hOglHXbGuS+gsEzwCNA7/BF0r+yImzYSdUfkvj4HnNB+aznFah2rzgAJoRgk+vLbLtm9dtJG6x2gHMDb2KFkaPbUn5rramffVMgLf/yREnOLmgymWJT48mCcC/CGW03MCz7hBzwDaycPO/TATffBE8ztX1eZws8T7i8sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060863; c=relaxed/simple;
	bh=5FhgiIao+p3dsOCjwojilmAjJlK51WXub02fRd6QgCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mwk/nXGhEptSlROt6pR9uaTxXAABHvVG1ksq+yqqF9hhQGjEMqpBYs9NvOVO4cio8OimsEx+5nJJov/YaC5FEETo2VCxKhxGP8i8tOP2GwlwHEC+X/bcVrGYgArO6d9eCml05mFAFT3WflJ5YukI7vgfWAspZY+e6rFQ6Y4ljRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p+jkYJI0; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jbj7loO41ZqV4VKgVEv7W11A1KFw8RTtmF5mY8SBoGjjXTL9xQZNSZYNmkTc980Mmx4SxiKGoRSoa4I14fl7CUyGv5gbNdtNO//khPkiUnS7uiuO7plNt6c3ZAEHVK2DlxhRfj6zHfxRY6kyg0/aLR3nmUb6GlagFKbfnPda6iHsqPO3yt3BJvgom9Q2oDKVFToq9kL5Lt5HRLBaFURHeiPhlGYkWllXjjdd+dOtmbS8QOSbh5scQvmHJkq1Yn8OjwjRVi8OC6bba87nm7nUGkn2Knf+yCmpSZM4Sqyy90qD5/h/z6N/VKFrjkEGr+NSU0pFkp0Qk/vMP6DqOtaIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHTTjx8hc2JN7b9+WiNqHf8xv9N9/BdwsNVMaRSWGmk=;
 b=jQZYH2YaNXfvv4mKOw0mmmAPraAkpJ0Mx6T9rbUIRd5KiMmWK/tGtDc254WUKI3ACS1MbFZ1rw4PHbPDrnexqOoJAOHU0BgCVo+sBvWJWe/qmaKLliq+xiqeIOFgDeApyqChrqKBEF/hVP4+kBI9Q6evkErOaWhfh7p/kEMbrwSTqt/Xgmv0PRR1Ih8XC5BZzE9/NC/6YT+6hMczFHG8gakVA5JZdNpQZln4cT22gzT9TXVmw87i8RwBfTlv0mgVNMccwsfaDkAIjVurJrbHM8XMLaO9WsCeoz81aNmmKd5OkG5k6AJWTaaGx0lgWzHx2jqGf1vxYKVnSzKiSMxVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHTTjx8hc2JN7b9+WiNqHf8xv9N9/BdwsNVMaRSWGmk=;
 b=p+jkYJI0HLbZdnpyAzfdqnTBSvj9N/XJICR3DALFFqktYsqATfZsJgs3inn8Nkay8jHyfP0zX2pndjvolLDQ2yOZliusWET6zs6nPSJn0Kdq3sfkVhLxTsvegUU4bsPSgd6okB08X62BLEIuLaM47l8tTdqChVsrxyGV3DeUevw=
Received: from BN0PR04CA0139.namprd04.prod.outlook.com (2603:10b6:408:ed::24)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 11:34:17 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::d4) by BN0PR04CA0139.outlook.office365.com
 (2603:10b6:408:ed::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 11:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 11:34:17 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 06:34:12 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <brahma_sw_dev@amd.com>
CC: <Alexander.Deucher@amd.com>, <David.Belanger@amd.com>,
	<Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 04/12] drm/amdkfd: fix MQD settings for GFX12
Date: Wed, 9 Jul 2025 17:03:41 +0530
Message-ID: <20250709113349.1444050-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250709113349.1444050-1-lijo.lazar@amd.com>
References: <20250709113349.1444050-1-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce24042-0e5c-4511-0405-08ddbedc8a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5hbHKzSIKuMgNMCWQIBk9IA+Q+fPymspQepeBUubIiVmn+zPVpMjYZbQhW7x?=
 =?us-ascii?Q?MsRSIRi/8WCdAzOalRUjnOmEtsaYozTKhkURc3Z1mz/poVOEGx/cyKno/amQ?=
 =?us-ascii?Q?BFLx5At9DpeUrK3hWhf97pCSMBWb8NDnCQ1d49XysNVN5OputVBnQqUyU9OJ?=
 =?us-ascii?Q?PKSnpY348UyersqWdquEmcJ87ZdtYc1OofOvfrCU9x9rZn55Je9AI1qedKB+?=
 =?us-ascii?Q?3upLoz6qdnZXaoBwPkJsd+lTzkIZ3LX+1T32Oo/jbP94HG2LyH2rjOvLsqqo?=
 =?us-ascii?Q?JMh7KocuHviOXpTAdz0Cj+tRiZLhCqvRE2FTFQrBlmKz619GIknEGJ7go1Ki?=
 =?us-ascii?Q?smJUoywQgcThFM79wfODrg+41arEdZ1LKIgk637E6Pwza01J4eCKEXlpLCRP?=
 =?us-ascii?Q?DdaRgrgEk3l1VwmgCCIjZsH6qDu3Ci/qJN8EvsYRkIFqjY9nHykqgDHDC34T?=
 =?us-ascii?Q?3t1UMsLvbG0b9g8iIKrc0WZObx4tc9Bplqgd45vYjssN18YI7J1GwLEkm8kd?=
 =?us-ascii?Q?ldVjQJSfoVsU5A/q/2rJN5bU3luLLQn0maHNCJAxocMs6HByw6eMaQi9uR05?=
 =?us-ascii?Q?PLsAKHqMgt0wVVZ2AZtogY/G5r7pbTvDOBddYBd7qWRdXnKxUHtQam9/s7zZ?=
 =?us-ascii?Q?Q+eN/k3AHUsvxta4dwbSTkPGiluM8WNrKGMaltv2lX13KvUiFeAJ6Zxrd4nu?=
 =?us-ascii?Q?yb/a31SHye6cAAboNW6NdNkYHeMMS7OZgQDnDRhHn3l2W8HLROLR8jn4JebG?=
 =?us-ascii?Q?yzSAHtND0DsnSkQIGbH9UQ0PoMcV1ck/rJAi+na/kvUlUNjL/bfV/PMGbMSF?=
 =?us-ascii?Q?vCaV0/aXqqoczXB2VlPEHeVjSg94BRd0/c8iRtVbAZRFqU/5T+QxUiIwym72?=
 =?us-ascii?Q?l064YbrgxDzQWcvV443QkatAXwH8r7AYet+AJosUlOFF4uDSCR5NOj83P03B?=
 =?us-ascii?Q?U8vfKImlQyWmfw/Y5NiXosu+kodyZgKE/UbnVIDUmInNYknSkNyfjbBa7F7V?=
 =?us-ascii?Q?MlK8FCVWDsnrNhMvimQx9hLJNZviRlLZSKhbxnYStZvvA+eiWtOYRZsSK5pR?=
 =?us-ascii?Q?ACptqsN8IOnGiqgqrPtCid74Wb8p2whKuIpXQI+YrutZV9SSJlXzWT38ujXv?=
 =?us-ascii?Q?NzQTGjUhDDoauYqmI+1u3I65qQo7tfa5nDIPTXEJxkyFSzA/aNhhhhWzt/rd?=
 =?us-ascii?Q?rK+yxhZwxLDgEUUHHNERNHkrEGCRw05KN+08PZYyiU80zUq4B+qQ7CwYmq8x?=
 =?us-ascii?Q?nXoP3wGrp2sXFuptltusQzK7AV/zwRd94facr2PW7w/PVJYzQsB8/xPHcJ+v?=
 =?us-ascii?Q?i3O1MZcqyzKxyTvBsENUKV6LLpTLW9V2hkHU8pvzHGyIsktj5typ/80PeCrg?=
 =?us-ascii?Q?MmT7hr3QGPtLHbwRTEqZJSv6gzALshywkBA1VG0E0AzT4LsuDINC0326hwYf?=
 =?us-ascii?Q?EKd7NEOsZ3H/v/f6se74W08NsqZ/s83Z48VdVIaGs9PLUvbduZKzm3M2PQgr?=
 =?us-ascii?Q?ld4AyPLY5K90DAVYvAq0maXKIF+hJhH5B+wG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 11:34:17.6280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce24042-0e5c-4511-0405-08ddbedc8a2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549

From: Alex Deucher <alexander.deucher@amd.com>

User queues should not set the priv bit.

Fixes: 48f0bdf4e38e ("drm/amdkfd: Added MQD manager files for GFX12.")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 565858b9044d..2db0b78da294 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -123,7 +123,6 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 
 	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
 	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
-	m->cp_mqd_control = 1 << CP_MQD_CONTROL__PRIV_STATE__SHIFT;
 
 	m->cp_mqd_base_addr_lo        = lower_32_bits(addr);
 	m->cp_mqd_base_addr_hi        = upper_32_bits(addr);
-- 
2.49.0


