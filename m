Return-Path: <stable+bounces-151533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887D6ACEF9F
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 14:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4455217791D
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 12:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9B021D590;
	Thu,  5 Jun 2025 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YGzZMQg/"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4581202F83;
	Thu,  5 Jun 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128046; cv=fail; b=TWha06RStmjPMAKTYG5IVhrYOjioVe3HhQjODPIBNxQdPgxe2gxuTPdxE4OeBtxfmezxFvYd6m4QrW0HYyrXpg0FYIS18xPy1CsVIfgj2U/fneAtKyzNvAv0pn48g0qVI52ioXuVAGJQqs3tUCpnbJWuS+noC5pFpaJQIp8EuL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128046; c=relaxed/simple;
	bh=IrvnBkIEJJFsKNmlK8caek+71kIoT/C5Y+Ac9NKAGho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZpRejq/fhyrJeR/bzELM+6DztqT8GtdawfCL8irqmKD+jZreYh8Tne3zwaOkjGrCMpUbPU1fQ5cWJRuXNmqWaVoFsO/NX7NLGrWJLKNg7EfI7EzOZjW+nrmKSY6PggEyCCdevxR45kwqQiOT72lqQPO8m3rNoypxlAi6TVzuWuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YGzZMQg/; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMogoVfOsJ2C1vlkwk/VI0QFlLRRpHWlXG4Rfx4cyNktO96DXEmRFo4Fad+hZYjwlSnlY8FT91zgZ3twr/ZG7Sj5i0qVzuGedXa9HH0RjJ58P/x402L+nq6aU8hOE+uFOo0njxB2HVYur8c1JqA1Bm/yiWM3N7Fgc/M6yMrPeMLmd/SPHsk1pY8MJKXbBi7S48wik1A/Y4gZ/5nkilX4zxk6Hmr6/8rcvdHhuJbZdJ+vJ7fBtEN0DopTl8XPVUtJMU8yEVMmKE4WKnn6vRQ7ZAvqnkLNukcgLBnRv6GzzV0gtMyCk2Yzlc9/pafnpHCLFyoYsxMGGwqKLBhVqnyZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZTGbQMJvUBczSvK7Dr87zUL2BVEZ7fuzZxMxIETD28=;
 b=Y7cJBdjIbN93DRCRC/C3CPMSpipFVZOs2t8d/qVUOi7vbFORtwx7v2klJTaOtmfHAcPpN9dngjIPK86ZoT4qAv+S9/433sZ0y1zOdvCtcHubRgsc8jbB4aNeZpKBRb/sdVL5Xzm0b7k/Q+7AnDUCATHwdZCUxda2xLVa9hzDtjddeOMp+my6aeP+8Nx/wUsxw7lOkvyC/BK4u8c61VdC76VuDe7rATTduwjjVtGYJd+zldcmgwQjVAZ8WNyWGejZFSPhStp12uALjWIbuUebjhYxBbKmCnE+BxHcLgdHnpo7ct95GvBQFFbEYUrM4hnW1WxCEElm5FSPnOUIOEG6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZTGbQMJvUBczSvK7Dr87zUL2BVEZ7fuzZxMxIETD28=;
 b=YGzZMQg/fvtGRZ569de6LMbBWdYPXRX0t1H29WrpScTQicvEE0H1Dpv2IGS+w8lm2TVP5rltkUEtf10DstZGbZ8j8B6PishMUcjSzUI9uVl5vYVjdZqBd0LECUpWVt4NKguTGJoLTaSEFgrGdeiGgCtJHi1nErsayzbFYMqS/lsA5YBWZ7HT3gxt4aae8ow7lt7uJuXrPeY3aYPv44rVVyXjVT4RvNcm1SKI3elzpcM3JeV4N+nNjx3CCrTP9TzyAyraMUDKmNVU4uOX9mpDUeUPzyoZM95+2jEXBz69nakH/2C0babOvwMvYywzQLWD6TPhAjZk/wms1f2YLRsh+A==
Received: from PH7P220CA0170.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::22)
 by DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Thu, 5 Jun
 2025 12:54:00 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::39) by PH7P220CA0170.outlook.office365.com
 (2603:10b6:510:33b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.33 via Frontend Transport; Thu,
 5 Jun 2025 12:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 12:54:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Jun 2025
 05:53:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 5 Jun 2025 05:53:46 -0700
Received: from moonraker.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 5 Jun 2025 05:53:45 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, Aaron Kling <webgeek1234@gmail.com>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 6.6] Revert "cpufreq: tegra186: Share policy per cluster"
Date: Thu, 5 Jun 2025 13:53:41 +0100
Message-ID: <20250605125341.357211-1-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DS4PR12MB9612:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd378e2-674d-4e9e-e2f1-08dda4300adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dH+gS+zDUk0/r73kDgg7f2uKKbyxhxrExq0AKhBVHLid3ir+M2qJMFlfufQN?=
 =?us-ascii?Q?KGOQuBwo1kkKY1jI3t1KcypOIvOZbiSwWhyms7l/j5ouTlWTIUWPfJ7TuI4l?=
 =?us-ascii?Q?oIAlzgeQqypaytgRu0ZqIRhHnL6ippT69Pm+0d/4EB440ssSMoUygU8ajZaQ?=
 =?us-ascii?Q?bP+2U0e8mO07c03eTLGbvSgxP/DpUd/ax4I+CjpTZnppJoT7aUfHw2hWxpGe?=
 =?us-ascii?Q?T2qTqgnImA3wSfGPhQakHJgfrZ7mEj579yOH7EI/z5/oPOHWnCv3d2I14jSN?=
 =?us-ascii?Q?Gnd+njdCR7aLoFn/AkERITudPrDu1yZeHnx43/P0qq9EoSB86RdmCmeGKJcJ?=
 =?us-ascii?Q?WyoislAkvwapqnyda/6HYMHVPbDOh42xofH4GhEfa1E/4bTggiiA9xAxfZZR?=
 =?us-ascii?Q?n5XG2ByGY9JbesZvtSKJN8Cctm4LLVzrkADwv+LaBFvY1EgZHoTcfwh5hfzi?=
 =?us-ascii?Q?I+3vgilZ519T/c07LZsDmnCsVgk+7fMw+y6zB+oXDZv/S8Hi7YvYayE3MXjX?=
 =?us-ascii?Q?Meob/sMal39Dc0XHqGBkVuyTp/fPHG3oNywHXsY/YjoQZUnHliiFWRmI2Xpz?=
 =?us-ascii?Q?tZRttd+aYceqGCoqKrZ3je9MZVOKmfaREGmJSNfNogjmbgbAysx2XDDMVWKC?=
 =?us-ascii?Q?KnUNE8+blTaz1cQuztX362iz6bJmMCmR86qA2vgBuoB82jALKZv3QOJlQN+0?=
 =?us-ascii?Q?JwzfUbqQCiaSxNfbEBInsUqsOWXAZP1JzmUDicrKjyvdAvzfInMcD4qgdHpn?=
 =?us-ascii?Q?Vf6S0QXmYhd2ou+5NnvZd3wY1UJOqASrQBilHrEgp5JUFe4cWFHXXHi9G6eK?=
 =?us-ascii?Q?NFsi+Xcu6NZtuWW1O+DP7TI/Vdu91Y9lBIdh5vOJrKrJNPD91K25Dji2Tjya?=
 =?us-ascii?Q?JJq807m022HEiDhXsHaleKaoWeFKTfNG0GQbyQZMGqrHJzB/uv5b5CFz6Hry?=
 =?us-ascii?Q?WNotyNtG4cpbKiaD7ruOD7rsyQJj/88iNX0ZfYggmAuwIckdyIDk40i5Ahe1?=
 =?us-ascii?Q?8J20vR0iyKOtBnipjfbGpTLi//5Gr1n3tcHbghgVWRlfpsGAsBPzjO0df3LH?=
 =?us-ascii?Q?J93QTsafjZtGdcu9n7Ver7cbjKqS0+l8/vyiXHgl6QsHYKXJoUSTr61XHPnC?=
 =?us-ascii?Q?rZGhLfWnboGNmNRrui7ygI9926wavb8hN3f8DpXnf9+LoEj1yWWiA9dKpOId?=
 =?us-ascii?Q?UuSbWjzDW+VdQbLsrsyYO1ViQ4BMqYa3wr2vTKVKiX0tZjfwE73+CnSiD7Ln?=
 =?us-ascii?Q?Y3UxPFq5fN4ww0tTJ8ytTBwEpozsVUC7TPVVoGr+5nbNatep69Lc2OinTLG6?=
 =?us-ascii?Q?8Cg3B6VX9OuZnkMGv9DoEEzI8oacKnFsv61Xt136dGYfePJgnVjsH7a6mbX+?=
 =?us-ascii?Q?4ST2lf76xr5a8KNgJbATbs5yBCw7DUYrw8JN3hxFN8rZrGpJD/+Z4BPB/5Tg?=
 =?us-ascii?Q?P7gbuqkXl8VWO1IT6gCIzklcWRv0Txa9LJzwtqPqsyqXRap3JRP9In89Zi7w?=
 =?us-ascii?Q?KwckasmErfGhy72HldnBxZlD4xdPM2c5m+zWzGWTQRrBmq2HUnr5s029fQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 12:54:00.2786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd378e2-674d-4e9e-e2f1-08dda4300adc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9612

This reverts commit ac64f0e893ff370c4d3426c83c1bd0acae75bcf4 which is
upstream commit be4ae8c19492cd6d5de61ccb34ffb3f5ede5eec8.

This commit is causing a suspend regression on Tegra186 Jetson TX2 with
Linux v6.12.y kernels. This is not seen with Linux v6.15 that includes
this change but indicates that there are there changes missing.
Therefore, revert this change.

Fixes: ac64f0e893ff ("cpufreq: tegra186: Share policy per cluster")
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


