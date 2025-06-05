Return-Path: <stable+bounces-151534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBAFACEFA7
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 14:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84263AC516
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 12:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA8F221FC9;
	Thu,  5 Jun 2025 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ijLmOAay"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002F221DBD;
	Thu,  5 Jun 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128109; cv=fail; b=F5ddr5YkhQ6SjZA0ahCU2PTrPEqg/acQO4g0+2eM8qewJQnPE8D7ITunIaSQsYjOZZte9VFEAeACAWmvnjNBoQbK2EAfnK43oZYUfigGVe6rKO3wRdgIXAvO4C48FqQcrVbfm4A3+D2LvTVNwj/sFwkdCTJn0gBynMG8kf1yYmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128109; c=relaxed/simple;
	bh=RYMEm7jS0S+6ExL2nqy8uS5inX0KXpbEn7uIGcvdF0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iG8PRF8vk3oC4MRIte85hQGkNeulfGwR+wY/cvTQwQRn+CEr0iC3edigd1g3ZPnfhJliDDUZu7bUlia86VQVTeSoWS9sbMfXZ3ErMoxMCe2bHEEDgrS/eG414S4AMgEBC9PibPR+v+Gc6o+E65lRuM04h84AOyOoRmNQ/IA6hsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ijLmOAay; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cemMwl3bdapRoQ2sSPqCuTyR/5rsGrKQq8pdXcLXKf9xdGqh+tS8Yd2oTUfqB22ZRIxfNH9LvtOwmOyg60tMBpvuJ0AGp05jmww+O5e8oHFgTC3kOwl57Y66SZi1Xb+rVPFdYPNX4gaEZKvuscRx9pF3eZQAqA5TWbhWxUMOHDgTsx75eVTmr+dvbyv2/foF5nhkqxHBjzroEqAyZDvCdj0gimUpDtkhThhbSs2xEfRqRnz9kBHsM62YK5i+WlpudjhCBhYvmiq0NZ9k6J8AwJlCNaapZLXjL9ewe6O5pD7PE6kypifcHfEsqR1RbnrQjsc9Vpj9wAxBgCZZeKPYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsqDyinNRXDUDuH1aiaI/TEsibgnEneYyp3BWUT1iXc=;
 b=TJjtT9DDOyOt7En3WRDXqOgT7Mu42YctJ3WuaVZDw2KzoOrhRIj3feOoCmyzxk/gTgiuO9HuIenRw43dEJHDjK/gUYc0z0RdxKavkBbTkgr+hosQGdvF4iV6iXlY59ETafIQOfVkYAYaeUnqa6IoqFK5R5kquTOG4OhGDgIUuNMo73WV6a4cvm9m6TZAzgTSfiX0znDQACkMIF1/QKDsOlCPDTnKOkumEDuS48Y/WC3pg1FJvJw+hd8CThJASZPAe18x1rV6ALS3t8GzraLJfTFsVXz6MOuSv/6546pxJTc8wklx/s5uN93JkDK9G5zorc9bNPDBI6D9K1SBTWh9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsqDyinNRXDUDuH1aiaI/TEsibgnEneYyp3BWUT1iXc=;
 b=ijLmOAayw22XEsaWiV341ZYC6Xo97RvfTx4u9wfKadQO0UDwMBd+sPvHuYG1pV9fwSYndSPg9YOgjpag3vNHClce6yJWuJohuVoJMyCD7adF3MCc/pPoYJgNV0z5hyFPEgzoBFCpbRA2ewqJg4z/7IJzISEhy58oi29B6BjSeTVipgB7XOkgixyMihQZg/PqNGO4J5F0RDWeQ5yf6I0a44Yot1ZqxrF+FeN5yyphps0ZjrmhC5LHR4ZIysFktHMpQ06eu4g2sadysIoZT1RKyHBz1PU/k1pJGlMyeuUWfFovdDF+ktx/xUCNMZpVlgYbRJnCXdH+KbK+Q91+fs0FiA==
Received: from SA0PR11CA0144.namprd11.prod.outlook.com (2603:10b6:806:131::29)
 by DS5PPFD22966BE3.namprd12.prod.outlook.com (2603:10b6:f:fc00::662) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 5 Jun
 2025 12:55:03 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::f8) by SA0PR11CA0144.outlook.office365.com
 (2603:10b6:806:131::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.32 via Frontend Transport; Thu,
 5 Jun 2025 12:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 12:55:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Jun 2025
 05:54:42 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 5 Jun 2025 05:54:42 -0700
Received: from moonraker.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 5 Jun 2025 05:54:41 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, Aaron Kling <webgeek1234@gmail.com>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 6.12] Revert "cpufreq: tegra186: Share policy per cluster"
Date: Thu, 5 Jun 2025 13:54:32 +0100
Message-ID: <20250605125432.357372-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DS5PPFD22966BE3:EE_
X-MS-Office365-Filtering-Correlation-Id: c1173199-64e6-4bdf-c732-08dda4303091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S4gECyN3R+uoGTpfoBMBwIPwX47/V/HjfJbkbLsMg37zhBgcfZQ/QC/kgznQ?=
 =?us-ascii?Q?kFFPW/AS9Zxz3u86/d1vyJWLHjksGd5t9EripNso9feWsa50WfdJZ084Rt86?=
 =?us-ascii?Q?9PPAJCC6o1N6NCEU+OVfvzVzqp8qnlpzD/DjAd5u7kbVMUhCVfBYy8y3Kaxh?=
 =?us-ascii?Q?eWOxnwbOBAdU3owMZ/AlNxQOey8t60IA6KnZlTjAjIZ6esDqR2aPGYnCARN9?=
 =?us-ascii?Q?OCXNcBskkHj6zB5AgJhjHV3YhvEcPAVSNmNo4N1WDx/suEW4O8/XS/xPrQoU?=
 =?us-ascii?Q?Ad8KZaWbwczYVOo9DTM9dgplEw0FnEEKcMPaBoZErGHoFVySl3isyH6jiiwQ?=
 =?us-ascii?Q?3lN/7Gu3baGH0pG3GDTpq4cE+3ivqfNcIePDvGe5Io+sv/9oUn2QGnpkdy7h?=
 =?us-ascii?Q?Xq7qBjIxgRvrZt+Ha11R+8qT4aCyYryVHkirBp7diIbhcHIe4x8/ZPj7bKsT?=
 =?us-ascii?Q?jqhZmJkXs+zks0/tvGnrKvNor8O51v7L2yCr0QIbmrXoDIZkCFiftMVDkxI2?=
 =?us-ascii?Q?D8ZtKC9KwPw9Z4e38IvBuyagLsXHWk1yuIweoNPKPbEEYQNCas+GIw5k/jEV?=
 =?us-ascii?Q?egxl2iWQBedMj3YN61vNIBNOeY/3b7ihM2tj+BCvYhGI4RRG7T/s42BT9KFa?=
 =?us-ascii?Q?z9URuqhPQs7BOUtHbK1ll/0X5zz/K4vEn0vS5waVDe8eDRmLs9DUXuziVX83?=
 =?us-ascii?Q?sLySH+kdNTmMRsuxa0DbjT1IQTSsWpQ2i08EARb94zphc1+iHoBIAfStr9qN?=
 =?us-ascii?Q?Ubc/6mHpSGnbiZmyq2FJO5R7mgJbcYYmWYFkw+Uv5gq/G9UokiE3sDLX4h8A?=
 =?us-ascii?Q?8U/tBqfcu67HNhnpli1reFBW2QwgtgfmniO2Ld1K/5ajdaGibEACQbPoAsbs?=
 =?us-ascii?Q?jIKxkaQHK3WXDq4caLuHJ/dLOCev3jXFH8KZIOXTvCX2dWaUKdIMyD415R9X?=
 =?us-ascii?Q?PRJW2TpC405iEdahhvhOZX470Ep3OqWUgst0gYb5ui+2dA9rRHE86DybIIhH?=
 =?us-ascii?Q?dzTFt2U6NS4tgUQ8ryrfArwfRn2cTuFvarHhVZK1FEYxCfUCL8Rov4iAVZAp?=
 =?us-ascii?Q?UEOiIiBCtAE5HwcqO1Yt63vzNbmBkCGJqFqnRBKX7XPGbYkQku98jqdbYMHK?=
 =?us-ascii?Q?KZG/PytzeTznIq01+7v1akF/JBRokuOff8LGLw4E9rmxkrUWJW1OkTLkkPFa?=
 =?us-ascii?Q?ohkzYY4VH/BUVOmXJ3zaPqbZMHOjVKeI2SM55oYgQUnPVWNtqvk2iYDAM57N?=
 =?us-ascii?Q?qSJG1C/+H17T7GCSdG0naVnmW6T/yi2nk7xFM/3YAIFzCQeKUbi8vx/jG5fm?=
 =?us-ascii?Q?oWAq2XgDyATg7qxzRxwsOTLgjdpgf8/INYf++GQA3PL0hQOGZy161vq23+dG?=
 =?us-ascii?Q?YUPgNmjQ3rtD/4YFS7EK05F12kH1s06PLYKUKfExlD4yImUirxh2DgWWmVFL?=
 =?us-ascii?Q?9D/Wnrwt4y6Mv0ixp8IHbN82mdQzXIEQDtq4gDOW7iU4aWr5vKfJpxGqjhlA?=
 =?us-ascii?Q?WLGIWpIqoypbWcmpXPy0sgcgV+rBO+0Jp7/A5Pp3jhOlpbsayypVvlablA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 12:55:03.5393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1173199-64e6-4bdf-c732-08dda4303091
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFD22966BE3

This reverts commit d95fdee2253e612216e72f29c65b92ec42d254eb which is
upstream commit be4ae8c19492cd6d5de61ccb34ffb3f5ede5eec8.

This commit is causing a suspend regression on Tegra186 Jetson TX2 with
Linux v6.12.y kernels. This is not seen with Linux v6.15 that includes
this change but indicates that there are there changes missing.
Therefore, revert this change.

Fixes: d95fdee2253e ("cpufreq: tegra186: Share policy per cluster")
Link: https://lore.kernel.org/linux-tegra/bf1dabf7-0337-40e9-8b8e-4e93a0ffd4cc@nvidia.com/
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 4e5b6f9a56d1..7b8fcfa55038 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -73,18 +73,11 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
 	unsigned int cluster = data->cpus[policy->cpu].bpmp_cluster_id;
-	u32 cpu;
 
 	policy->freq_table = data->clusters[cluster].table;
 	policy->cpuinfo.transition_latency = 300 * 1000;
 	policy->driver_data = NULL;
 
-	/* set same policy for all cpus in a cluster */
-	for (cpu = 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
-		if (data->cpus[cpu].bpmp_cluster_id == cluster)
-			cpumask_set_cpu(cpu, policy->cpus);
-	}
-
 	return 0;
 }
 
-- 
2.43.0


