Return-Path: <stable+bounces-183599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FCDBC4868
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 13:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CAEF3A427E
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CCE2BFC73;
	Wed,  8 Oct 2025 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJJOsAmW"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE51758B;
	Wed,  8 Oct 2025 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922201; cv=fail; b=jRGQp8dh3RgrzAX11TalaTvGIkjofy0LHcpNLaJLIBae4d3DM3fRzMRQLtjTZf38cGpJdwk/kM2DMRowuaO3ypBix/aEEOhVILETghx1IbJB5iEqfISzEsXTHVypllAGstkmVrepRneIMemnXPF8V78nFIDMWHm7zgzTOrMqRPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922201; c=relaxed/simple;
	bh=KBxmM+tmtabpCW6k0Yk57T8YcPDl2dn8EVyEqlYFhHk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=siXMCWTXk/OFXZz4pIffhG+YLlKnVrwQBb95o/8Uu/6/e5qPON95IxTQ4gHjoyE9CHD4ZAwj/fFDlO1WahocsJ3WXPi3Sp0Xpd1HXi9rohI7XurS4xcrfupPco0nrBfbrR/I3t3EukOqC6Cj703G6Gk9C2EgO8JLQBj4wHgHn90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LJJOsAmW; arc=fail smtp.client-ip=40.107.209.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftTBHm3UmST4oYznx4HTLGyR156EKqWIJ1xEkf/YKUe6k8WtAoVfH0+kui3GUnKbIXYxVzEsPca+vbXhdZEU+4JJ4dXG0el9zHmJ0wMv1hx2pqsFeffGVHmY+vd8zSSxQBTS7IAYxu2rwsTcjFpVUELVzRrU/p504lh45VYbEdaxxPAPwHhL2zPWgXnaRdMli72cw5gaPk8Zv9xSkG2pt/VV3O7pgWLMG0wOQijCjp3XamFLfESXszAVfwQt6pnAa2ARGQaUrKPLt/1h1rNIFq/oMmYmcDO1xTl6PwH/zcGsceTvaf+Vl+nd+VOmLZpG7FfaeFjRvhtvJ5Fs8hmAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7Ncc0G9UExmJfFX24DXYFeseuvA0glKrxcm8cio/Qg=;
 b=gkIdupxzoqot1BxvgpZrnWx4rQGxaXlNr8gqfFxFRaaXOyMPGVA6y/wL3PlfKlh7qKZA7F45EIU/TU72kwxByczSLRcEiYLaO2dnzcx1fdjMWBDxM4eH+5O/6qwc61C6sdlVRFraP7EjbikXaeM3RJEOL7GgM9J430cMWq+Lx8Ww5Zr4c6AzDGg/aaYXuROMW9qjDSRYqT+bYxuVcp/AWi7BwGRK/TFCkWRRE2srF25HXCOT3qsZoMaYAJkhlYfqkOhzy4QXVWpS8Q71FnDP4+1WHacYVjllydRZaHazbwCFtqgLxVDBtDRA6AIADRLK41h+wF9qH+ihTefbl3Yovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7Ncc0G9UExmJfFX24DXYFeseuvA0glKrxcm8cio/Qg=;
 b=LJJOsAmWzJEwp0z1NiGGuC2PM+QdOIR2ETjPlOD0tRkrqc9UKtaifCe45GuP6VUUciws4YIJlXYnx0ZpPmD3SU2E9Oi7Tqn4olNJXWNJ5tm+HtzFef9KuuLDoll1q9h05XooM8LFeEFJtuvq7Hb1zmqrHWkudaPcB/2zhVBYg/K1/ghZYnKviNRRMmab2A5rawQzYOmauDnSmIeWSwV/U4mfdLtA0i0RaeLrmS2PJ761TITpMGe+ldhYP0soU90LijJBNhNuxGZRhQDCuf9In2DcW9nItyGr0rTWG7d225k2LXvugY+PyB3yd92wibnyWkUOjd+aumXYmg3+eIjE9g==
Received: from SA9PR13CA0061.namprd13.prod.outlook.com (2603:10b6:806:23::6)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 11:16:33 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::92) by SA9PR13CA0061.outlook.office365.com
 (2603:10b6:806:23::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 11:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 11:16:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 8 Oct
 2025 04:16:23 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Oct 2025 04:16:22 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 04:16:20 -0700
From: Kartik Rajput <kkartik@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<sdonthineni@nvidia.com>, <kkartik@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH] soc/tegra: fuse: Do not register SoC device on ACPI boot
Date: Wed, 8 Oct 2025 16:46:18 +0530
Message-ID: <20251008111618.703516-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: c7cd507a-57d0-443a-556c-08de065c2383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PoNjJnZppJ92jBe4tzC1Wdtapokx9EnOaOoeQQNe3tEl/Dw8qgKCYrim03+i?=
 =?us-ascii?Q?cFcieo1Bxu2gqYgzdnKO1WmRzocpyU7P9WZueDuz2GEimHC7qDJSaMFSJ9lJ?=
 =?us-ascii?Q?gA/FFjARZLSoYZUsP/tYP8I93ETJ+x7SdYVbg5j0Dp6DqUCM+SjSrvgVclWq?=
 =?us-ascii?Q?0zV7Yx9My4JRtMVsjVboU6vTeqXRh6WIBJ8jsD1ofjqm61kNmMOxnRltl4u3?=
 =?us-ascii?Q?ELbPIuR6+VfHKZWQBHdCwgdEj/gea7XyI0p4ckSJ4pFWvg7HbIOLFJSAyMfP?=
 =?us-ascii?Q?08911bwaiGgg3Zdjb3Fl5y6TPniXJkDukmFlZQjqpZclczP9Js9ZBdQfdjOm?=
 =?us-ascii?Q?/u3hSDlV2XB2LhHqVjvUlaI2jPidHswsmmTZSp00Bi9vw0Zr5M8CCX88KeVv?=
 =?us-ascii?Q?jspPYwUh9sGoXzSb9dK8cPFp7V55ENNZPWg17eATdtSRhurVJIfZVxMr528s?=
 =?us-ascii?Q?fHLQEFS1U5fPMz/GLwAk31RReo4SqeVqjINpvO0u6S8u4knsXR8dJ1V6viIS?=
 =?us-ascii?Q?IIwuokBfxz6uDzGtbvZG65t7DSY/E1nDs2Wd9jjFWtTsI6I4n8Sn6Qao94wt?=
 =?us-ascii?Q?2tQ3VtnVnArSty0vefgfZG6Vyr3BkdCP5lgQn55UzKptxRIA8AQv4cSLgzwm?=
 =?us-ascii?Q?fju6UqjLkC6+Gi5FMlRpnAGfOiKgD06sVlnKIy2qT62KBxhO0d0QeRAIT4gA?=
 =?us-ascii?Q?RwEXwmcA1phyc0K1ZsGFfsQpYWFTIsLh0rTH6UY2Yu3ZjAvbyVbNpaKUTaIP?=
 =?us-ascii?Q?ku2pyMHCrQd7RJVEzeLPV+1bZYNiQKJgmfZwPwIHe94Uw8T4cvsIlyGmCCBR?=
 =?us-ascii?Q?mHWa0enw0D2ZqWLIX/52aaI0AZukbCcbIDfhcdntiAjEqRJuC2NBCEexoseD?=
 =?us-ascii?Q?taTrn0p/8kXXx5m+YsV2YZI7FBG6PciD1PET/cbNTzdFFrSBtYgNz+b5M+G9?=
 =?us-ascii?Q?EiNi8jawHv/5+OnbjMDVzsQKY+AxBFVytmLRMtDWjFM/O+g6lPPMAckURasG?=
 =?us-ascii?Q?lfcK5H3qZ35G7Pm0sMvMe46PHUmnG+nDf03l4nBStXEsqmncIPvE+aGE3Swg?=
 =?us-ascii?Q?vEZWnrOBMT9iJ4CR3ld4lweDORVi1vJQ6QiTGfOUr/MXnUuK5iQXOOeimsCv?=
 =?us-ascii?Q?4/H2fD/eMe1ezX25LNUuPOlHFveM70wf1qd3YbSmv5U5E1tp3hr3Skz4W9UZ?=
 =?us-ascii?Q?2VvHU5emFGWaOUW7Z7/LfKSjAh7R/Qb2HdNUI3lxm3TTwzoPgkAqoh2Vuu1P?=
 =?us-ascii?Q?VtmGKI49y+m+Rc50lf+9Cx1s9A03D+6VgUX17Y3aSJ0/3YlbAO1P1TG6aNQ6?=
 =?us-ascii?Q?lIfgAWSRFOamIgVITXc5OyYO56YfZkpm2L7+EY8wQaxSfsN6QREbwF2ZEHNw?=
 =?us-ascii?Q?W6bniemC0Z7QgnYkAIYsMCObIMc6jG5CD75+r03ujDl/ymQ5uAb5mQiQrEik?=
 =?us-ascii?Q?rS8spofn3vzK/JFxtU8hpvVOeJr/IOmAXiIi9hTNG78GTvzhUFGRZpE30WU6?=
 =?us-ascii?Q?gQxQvx70O9wa1OacL9w3HauRN3DDKssfAN0lUmWoQPu10s1LXWszi3APbXAh?=
 =?us-ascii?Q?oNzUtjSSJdnzg/FIDkg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 11:16:33.4652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cd507a-57d0-443a-556c-08de065c2383
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

On Tegra platforms using ACPI, the SMCCC driver already registers the
SoC device. This makes the registration performed by the Tegra fuse
driver redundant.

When booted via ACPI, skip registering the SoC device and suppress
printing SKU information from the Tegra fuse driver, as this information
is already provided by the SMCCC driver.

Fixes: 972167c69080 ("soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234")
Cc: stable@vger.kernel.org
Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index d27667283846..74d2fedea71c 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -182,8 +182,6 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		}
 
 		fuse->soc->init(fuse);
-		tegra_fuse_print_sku_info(&tegra_sku_info);
-		tegra_soc_device_register();
 
 		err = tegra_fuse_add_lookups(fuse);
 		if (err)
-- 
2.43.0


