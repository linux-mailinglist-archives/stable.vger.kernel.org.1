Return-Path: <stable+bounces-151531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA3DACEF96
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 14:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989B33A9A85
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 12:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68F8218E97;
	Thu,  5 Jun 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uZSM6uwm"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940CE207DEF;
	Thu,  5 Jun 2025 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127944; cv=fail; b=GYZsyw936LDMir7MT9725ENsyveWKkzUL8PdejGf+k7NH7dEzhPIDdbu1KPtBUyMcqK5YNPHzJnb1gQ6YuyYHA0UI9hyCqVcTrNmDrSeKpLtap5mk+hzOqlfig55W9t7F3jkrp1nlDdUjyGSk4eZJrLwFUmifNdIRhI0ClfwCoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127944; c=relaxed/simple;
	bh=8e7ZZV8jUFzqq8Ggqf8YZrDaB2na/KHYSp6rUUG+wS4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EEhofYbn1oKOaRolhr6h2yJ+nj9TUCRHErtiFqB8tQGja468f4X+t+yaiG3SLul3Ab0Ye0nUrmugzw2HczKGstyavxL9wowP2dKWm/XFLCF8eLoqUZgrka/ISovQkWKdRFk/PtN/Ccs0v4uUYM2CYeRDfeFCdQ7cGXwuiXISdBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uZSM6uwm; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzm+sQPp9J/ISAqjDb6ZI/Ufc7UDJ0M2YaA012G2fwznMCZvCOM8mGXcW7Vbd4ejSrmYInTSxOLE/hVAUAUKydOsB7KaH6i2wJl3JytppJ6qQbS0LYw/tfcJ4dWURHyLabW75Sw1IkZ5ECMdHUr8L04p+dOouwDGBFGfVfrhCe3atoxGgka51r1m2MDm8bAJwDiOQLgTxIiz7DmVmbywAhnVESKNP7XFJ/pvPEdcsr5ST5zKnihxpWhQdtYP/VxkYUelfej7qwL0fNMM4bmLod2cGWzx/3QMLFgyaXrPABNTnRS+QJiozo/KUlRnYpDDCJlhgUdfxFSeUdc3XnbkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7CqXinq146c2gf3UUP1p36CAQOfcQ4NH813s8IS+n4=;
 b=cLAXUubw6GAYUGJ5ZF0yGTYCPwJL4KjgSLtPQCRzE7niVPui8cuR7tjGK/fo6bshB/cgWaxgFQ+GbqS+h1kcf7v/cYUOExaqaMgOqJfYSHm0SUanSBCnp+wyw+VHSTWl9L2K7A/NYxxxL9iTtPZZJ0vTHu0AnjKNtkFRKPFQxA3Bivn++lMhgFMNlHIRpNudieUMWJoQXWenZe+gDLnOkF6Rm8vHas99Q4uPtyKKrJsFE3qjNI08XcYBADehB+hZ0HJi0aq6PbmYWsKJ5nGoSzPgDCxZ+IQ6DD0pEVPixv1D7pGbLlCgO9/G82FxcMwdQW6dHNiCKGhlkarc0dogww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7CqXinq146c2gf3UUP1p36CAQOfcQ4NH813s8IS+n4=;
 b=uZSM6uwmgC2uFK2PHU1aUNkhTg0CwmkHJPTh4vPEaNQGp/f9reUqMinbh7V4Qk5zQN2gw81QKEKNv2CnlQrHO+84E0QC04B0zABKN+/9gpXFljoEJB0mIhwmuYySKTGi+aqCyFQhibPidAO2ykzIF4NqMubdQIi0icEDwuBhDF2ywE4MYWjAV9/bFWe0ihb+29u99MtxXaTuBGkbRUP4PJe66GElK//syYAVdgykUrXtupRBrKkGRunI8OLoY7PmecGRPIChcjr9h3g9v07h8JUQUHLXLPDLOpvF9UYWECkgO4C+iJrJ9seWhtYZyz8RhmsEDCIFeBjBlA0boGJG3A==
Received: from SN4PR0501CA0128.namprd05.prod.outlook.com
 (2603:10b6:803:42::45) by MW6PR12MB8735.namprd12.prod.outlook.com
 (2603:10b6:303:245::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Thu, 5 Jun
 2025 12:52:19 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::98) by SN4PR0501CA0128.outlook.office365.com
 (2603:10b6:803:42::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend Transport; Thu,
 5 Jun 2025 12:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 12:52:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Jun 2025
 05:51:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 5 Jun 2025 05:51:59 -0700
Received: from moonraker.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 5 Jun 2025 05:51:58 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, Aaron Kling <webgeek1234@gmail.com>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 5.15] Revert "cpufreq: tegra186: Share policy per cluster"
Date: Thu, 5 Jun 2025 13:51:54 +0100
Message-ID: <20250605125155.356836-1-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f88946-e6b2-4834-441b-08dda42fce6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0S5FqAW+Cij4lG+fqXsSI5FDaD0v3BVajpLV/Y0TFdntsXnY93p19yA1ld2M?=
 =?us-ascii?Q?DTitHYyhNgQ+3YXziGWkHRVOJKoRzP4vQBAfQeQb9QtmkUGZRu8YAMjpPSzg?=
 =?us-ascii?Q?WQk2ATRHuwoCZ8+yUpp20t45x5h/B7rxAqe/NwipIS9gfa7QQ7DEygCDy+Ii?=
 =?us-ascii?Q?t/kRya+czy1w/EJ5OvfEt7F0E7MOKh2Yopy56zxlbgcj1w36dlmACw72HRNP?=
 =?us-ascii?Q?+8KBdnj3hHW2Y14Mxe1r6iwDady/NmgkOZxZk72MLOYvMP7HLwGI/WudLuWr?=
 =?us-ascii?Q?cwE47Rdv4zrCbeHu14h9yNJrj9rhl4PyXVQ7/0YBTEp221RZdfI2PiZGzHJ/?=
 =?us-ascii?Q?lwMp0/vGs3VcEhHmbJbYYvl6V6bFDEfY82ejNi+iCQJmWHG2Jdql4LmOdzzp?=
 =?us-ascii?Q?BQYpxOn6WSvK6uaNyIwwDNHn04IvzcEpNKpgWrZw6Yhpifp3OkmJFC+gX9DF?=
 =?us-ascii?Q?We09UX+wf5T2NuaOpS9CvGFzv66ADK2LB6uyGlgRUyCrCm2R94SnfYdlGn1X?=
 =?us-ascii?Q?sfG63Mb8/4NDjprtV9PrQ3hQQKx6yDLXQZC8ADTgeMpqZlEhQKXqonW8ZfKR?=
 =?us-ascii?Q?IuF6/kWT/4Jss3Z+4PxUOKSpMPMZxHpA7qd8PNFjytTzoPCwfQgJ1hYFsMqf?=
 =?us-ascii?Q?Sx7E4luo1naL15UySj/7KynR0joZ7KOnJY2kkLr6indtaFRxi5wawymjaKgw?=
 =?us-ascii?Q?F7hL768/V/VQ28NPwOcX90jtUBD8TXp97jTn+zqqvJDoStTpCEZjdzPNSE8T?=
 =?us-ascii?Q?qS8DAqdRwkrkgWbrw+2Heq8ASp571tkkbuyW/CKo4z68OsmqIoZzDBvtLEro?=
 =?us-ascii?Q?WOU2cHPi3Q5gvmSVm9VDhKn7A5IXv3B0+KbdgOnQHiSCA7ww8KhTYo1fHlJT?=
 =?us-ascii?Q?cibRlSGrFBal/OaKK7kRwrv8zMB5Pu9ZmWX7L9wXBwUXuNePo1LIff+5rLgH?=
 =?us-ascii?Q?GnHtssmDCCuZqY6PHBxFjxEs+ARhqoHUgxRSAXf97lOp6wdBuMjLasg9wDH7?=
 =?us-ascii?Q?Y04xvZzCB1V/6GvctrlB1Bho1EiDDjiR/gRd0jGUOEm+m6Dz0ZlO+NGB0CLH?=
 =?us-ascii?Q?eBu7HnQYiM1Zu+0yUDcturZTskvQHxjrDbPXtsa9o+Ddydyh8feAZayMWwYV?=
 =?us-ascii?Q?wvFP+25FoATbLj6k6/vEtwFYd6XXj26EZ1KrjxKVNzEhRLln3dX1xxd1MNZP?=
 =?us-ascii?Q?f47/uodwtZofxFIRRRxCCv4lXzgcPcM8er6ONdNi/YdRUHmqK/IKZrqbeaRP?=
 =?us-ascii?Q?7WG/mFyBUZeEP5cl6vQsL5UBDewa+ywkuyu9jA3E/nY9BYFUyTn0Sr1uDVbP?=
 =?us-ascii?Q?Bi5cRGnqY/mfxIXxfbRcBvxqSVB0YxMKcRJ8R4WDw9UZYjbn7CLAnA/cILr2?=
 =?us-ascii?Q?Q8TRPcoAQsvz3KVEfhwQ5/U/W8xv5ErSLbAsaj2dZqZbtj3CH9ZfiKhX1wkA?=
 =?us-ascii?Q?mStROWC5Pqy2gVbruMy0R+pfVlZ8GKYYLhbDw0eM0USGq4kv6Nmdl3ELSMb3?=
 =?us-ascii?Q?TdHIYJOgLS+uUu3xu3pGe1FjvP6SJuRdvgD6FIyqLzJJf7yZ8d5nthRstA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 12:52:18.8981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f88946-e6b2-4834-441b-08dda42fce6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735

This reverts commit 2592aeda794c9ea73193effdab69f1cf90d0851a which is
upstream commit be4ae8c19492cd6d5de61ccb34ffb3f5ede5eec8.

This commit is causing a suspend regression on Tegra186 Jetson TX2 with
Linux v6.12.y kernels. This is not seen with Linux v6.15 that includes
this change but indicates that there are there changes missing.
Therefore, revert this change.

Fixes: 2592aeda794c ("cpufreq: tegra186: Share policy per cluster")
Link: https://lore.kernel.org/linux-tegra/bf1dabf7-0337-40e9-8b8e-4e93a0ffd4cc@nvidia.com/
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 19597246f9cc..5d1943e787b0 100644
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


