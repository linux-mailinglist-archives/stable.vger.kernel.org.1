Return-Path: <stable+bounces-151532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E2FACEF9B
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 14:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0463C3AAABA
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 12:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E921ABAC;
	Thu,  5 Jun 2025 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t7+d/DAk"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD3202F83;
	Thu,  5 Jun 2025 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128011; cv=fail; b=keME/HCMspq5rs5BE5+dXP6c3r6pJYuN74jZ1iv8f1gOPuEpmZOLVQSQC5+SL/Km7JQGDm3xsbvLxqame9gBZSJ/lxUL7Zsq3JTG6Ia3JMsY0aqCT0OuuXEO/cm0rOakzUuStzhPr3ZjqH9SRv+y4jaR576oLp5fSGUoHfVsLb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128011; c=relaxed/simple;
	bh=VnFTcBFyG/oofmNXW/AZzzeKNCHf9Q0Z8pzrya0EMus=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KqRKj+qT++9j5q7t0J6ixjKpjfVi8f1dI9MBMaoI49OBkZA9crq8iq5VLFtIdyzlfV47dowTdbl/MJ6Ktbv7RrUUdASVd6TNnlIQLFrePuVcZ7OzR+f7wAM1ky2rtdi2C53GF222HPql0ydbyYDkwrftASjBG3nqENmpdqiOpnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t7+d/DAk; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBKKt3++9ee+tAWI0Az/Vjwu8OPuf+RW2NyCnY95X62U6CliCpzVZUJss+mXKUQ0GtK9rVRRXZUqadSbFvN7W4+P012vDl3oO6iTxpti+dyyhye/qMo3nKFXhRpHiHiSEdGSfdXcMQQghWGTdzp7cTThyAaMFiZOyLW/QnnnZGOjj2Tacy5gAYOrpYZVwApPSvYFkR87PDnCa3kLhmTwhXPqafX9Bx1sr88HQavj1nNXUataK8Ncfq31w27ZkalVYgcLZPH8ilGylMmM0h4aW3ZUDRu89z+J3mA9S33Hh1KM7DNjZCVPDzMukFH9usMUuxK4nIvMweR1HUFenabDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MttWqK93FspEsEZHt+XN8bLwL+n0IWOzcDs7rUcucwk=;
 b=IqaZ56yya3tEUivlGPF9SSdjEb3tVqDf0rPmygoiHCDxm8TVOvas+GUIDp2ZS9CZGEyS16F8KiX0a91kcUj4FZzl+/vp/6ndWKz0W20RVRjgc82rgq9t4nzC8HTVIIe0GYpAu3MdyYPFdqGvEN7XTCre8qyWjjiCVx3XQeDlxtspgSuxtr6gi9MVoYO4y3MizFzIrtwooIHARw9CFZjbW0eO/+w/LA56LoYe7hu5OkboaIIAiXXcCLoBbuYExw3M1IYzjTSDo+d7o35gv44oNsIqCeznTXv21SkihvE1kVW4f0mIFOI/7nn+3zHuGi9r+AUNhMPrmzNJHNYXThR8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MttWqK93FspEsEZHt+XN8bLwL+n0IWOzcDs7rUcucwk=;
 b=t7+d/DAkdRL8RTZSno0jUs+2D5rGiIK/a4m+7HxcegWoNpDSk6T3pl2ovg1JQy+XGCxp+14VoSSuZiC1An/xJ8B5JPIgvMQpvbvHv6Iu/D+LkBe8cCNEIcraG31rF6m0PRsCQuIBsGCFcAOHVUq4RTGsBnIx4Cgkjs1poGS9s/SimBmBcMbI3sdu9l86S+V3M4s3gktttN3USIVpo61dcgPEUJTzEitdTtYF7fe0ot9kwFytOVL9x02zKl5puCtTsqzhOD8e5jOxktuOtXNzlqnYKDEPoviZYbCcLCKQG9FSGSIC0tUMraS0uALzyS+IUxvOG65RxLjsz4Uk9zEZPw==
Received: from BY5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:1d0::37)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Thu, 5 Jun
 2025 12:53:23 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::1e) by BY5PR04CA0027.outlook.office365.com
 (2603:10b6:a03:1d0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.22 via Frontend Transport; Thu,
 5 Jun 2025 12:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 12:53:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Jun 2025
 05:53:06 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 5 Jun
 2025 05:53:06 -0700
Received: from moonraker.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 5 Jun 2025 05:53:04 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, Aaron Kling <webgeek1234@gmail.com>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 6.1] Revert "cpufreq: tegra186: Share policy per cluster"
Date: Thu, 5 Jun 2025 13:52:59 +0100
Message-ID: <20250605125259.357091-1-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3a83dd-3fdb-4804-3074-08dda42ff4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TRDWBKCYWeaewY+CiywYsQrL9brMs70HE9ULefU/0sl39P8Hjbip9vJ/uht0?=
 =?us-ascii?Q?aY/MXDRW2Pr0fWBuVp1ICkrx1FoBNuLR4Wx8B/fjYCgTbZiToql3HYEMPzuN?=
 =?us-ascii?Q?i7FKGhX8BqXyLMDc09gH9jFfQc1R/B0D138ZxNv83NtMbxr167sQbXW9pzmn?=
 =?us-ascii?Q?+1UBmZSsGnT3+EBc+8dLAYQXH+Ui9+enVnj9OWeLfEjr3fQwiHLwlpapCA7v?=
 =?us-ascii?Q?iJDB25O13cbAcBwoqyakivrMky4z86x2foDjuL+don7MYR/ijPnGkxvdIQn5?=
 =?us-ascii?Q?7tfa/D/HPWIb+kos9i6T3NzFu1RBpkWhsSB+nuAv0ucgc97pIBJ/yOtssuwM?=
 =?us-ascii?Q?8kLyXhjQyU0wShuCjIJc8or0/lJDNW0GxQcB1gFzXweJbOk/ubgV2Emt0cQk?=
 =?us-ascii?Q?jW9by4wnck5/lAu915NWXGdNAMxNem+/d8YtXH5azQn6DYHI4r7e3/24geXj?=
 =?us-ascii?Q?ewrGwwT9ZdOVHoBeauRdL1rrro5tYuuBNbRvyTbQ4FNMQpcSH8/v6JPLM2iS?=
 =?us-ascii?Q?41DhiIPZh7TVKkVoKXH0aFVBhQLUBTy/dN0hD0VJpUwoWzXrj8aW1s3WG0Dm?=
 =?us-ascii?Q?V7ctNVgU0uTDIXntDrUhTe5ajpsUc5F1WMF/FIQJJ8SMEolr9Z6Pf/WE/ySh?=
 =?us-ascii?Q?MffLfIM5fdMU8crW+bZeU9tutzpjBajlI2o5f8ibfxe63FzXsP1QKp+Rzbfn?=
 =?us-ascii?Q?qIIADE0hkJveH6tD/gj8UqBtsFBrOHuetb7Q08hF7bupk6Sgsp0mzJ4jvDOz?=
 =?us-ascii?Q?wgVyFp1O4e2qSK1rMnnnSlDB19FVTNPDB1SqCQaRfYSdWDNuNORVhDZ9SoyN?=
 =?us-ascii?Q?/XA80LZcsjOzKBBFEEXBcGHtlR8L1MzijWKdZPbp05iE1nh5goS0MEAgatbz?=
 =?us-ascii?Q?3/YiM8X5QOyR+juHqtflPqm7m+pyDivH1/mkZ4WD8et3c5VU0CA1a1u/aCAX?=
 =?us-ascii?Q?fOG/g+C35vDD8hX8JE4/GANQTGuINM/PWgMAvupyhXx8iFNAcqnwZOFh2Iou?=
 =?us-ascii?Q?B09M1qY5lWzxIP1f9lImVoOQXGBIsI4zc/ZwT0YppiHL+emhIYla3AGRO1Pd?=
 =?us-ascii?Q?iEhYELXJVylYabLHXavka4317jo1JZZEaXwH+mJqhA3dn3tlIbC+ohTP4jH5?=
 =?us-ascii?Q?ddZFeXy00L8QrieM9O1aI2H7/sJXfCJarT1HLCkMHvdTWugq+8VGxwaEfyHz?=
 =?us-ascii?Q?dcVnymxSTDeUm6I6KW6Jzi/9ARYcnXKfPqfoqLpOZXlLPzQ3XHAEYpukk5nO?=
 =?us-ascii?Q?tshrkfQoi0EfXckml0WjTI2kSE6IITNl2mLvYlhw40lKjl0LMmZclK6VBUuH?=
 =?us-ascii?Q?dTz+vIHVAcJmA2T30xGcxmYWfGVvJg91Ba2qgZ/aftFnCKUVkqlyRGa2M38Q?=
 =?us-ascii?Q?GehB+Dq0WNQ+bMIK9ueg0+GkuGETx5qqqhZ4jMJ+4RdavIZeIMz4IuenbAdJ?=
 =?us-ascii?Q?utmvCfODOcFF06ihITnUjBKfPXXbXmrmLPvaelO3B5P6H7u2PQRC5RTFawv1?=
 =?us-ascii?Q?IEOSH39CNKQyKBGcmmv6IAPHvA3C8RlBgB7/xmKfTb60Fo4l/J6zZcsaMg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 12:53:23.4242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3a83dd-3fdb-4804-3074-08dda42ff4d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813

This reverts commit 89172666228de1cefcacf5bc6f61c6281751d2ed which is
upstream commit be4ae8c19492cd6d5de61ccb34ffb3f5ede5eec8.

This commit is causing a suspend regression on Tegra186 Jetson TX2 with
Linux v6.12.y kernels. This is not seen with Linux v6.15 that includes
this change but indicates that there are there changes missing.
Therefore, revert this change.

Link: https://lore.kernel.org/linux-tegra/bf1dabf7-0337-40e9-8b8e-4e93a0ffd4cc@nvidia.com/
Fixes: 89172666228d ("cpufreq: tegra186: Share policy per cluster")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 1d6b54303723..6c88827f4e62 100644
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


