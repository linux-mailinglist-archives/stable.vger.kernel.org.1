Return-Path: <stable+bounces-141961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E8FAAD392
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 04:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A75C7AA3BD
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 02:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A799A1B0F1E;
	Wed,  7 May 2025 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CJM4jK04"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EE619D084;
	Wed,  7 May 2025 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746586130; cv=fail; b=opBzym38aFQqTfm9sbRJRQCvRCK39xUX+W0uZbZUlqrbd8gqTdCQTLUKmAbUjDKtGwp9OM1Iev+b6mQgray+382awz5FX88eFSSSBmLqD4Sa8oYg/j2MSBo+sg2Zy6jLkXaxP3IKggSMsSBqxMACC7d3G+oQq4OQqV+NDq7dWHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746586130; c=relaxed/simple;
	bh=x9leHQD08H2mgjw2MH8lgl/ZKA3hH8jcR9IgMnSxmy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hI/XJIiyQvNOWFXJP7eYODcUf9cTgrxLPSefuKQFxErWnLgAE8K3vtTaKzjFCV3wpkVfF+aYZ/JSaALg+MT+UOj5WvIN2gzwdr3TfNvSeYu++qtrvrnyyyoR07aIVCLROpHP5GwmnX+5N4t1Q4BLvA15hl+ej2ImCU/zBpp+IuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CJM4jK04; arc=fail smtp.client-ip=40.107.96.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNoTTNiVvD1PO4NBZO2bZ81GbCdoEDng3cb43WgJCyr2kTfZY5/g/JYIouRm5n0m5Gv+bNvQljq1STZS9pr3Axyb+L6kFtZLqsVbpHrXWNVgEERUJm/dtF5UK0YRfsG6xcVynf58j8ZfUgjExCe/GujaQbv6TYMM6tS9nzX8AQz7R3FMDSJRk9ELTALGT3oK3jIpgso11ntnyhVEBat3I3Z2Pf8tinXPvxIwqabU7TV5JTZ9X8NbMAIJa9zX48FdrutfvGlKqdwW5yXtOr5I5mzNaIWqKrZy0fvDN4pfonPk79R2L0YdMmvMDwtaIgQRT+i+z1acgHGFSwXyLUw0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EAUlxwWmUxeR+nYVbls0fqQA6SIrF27o1bSHbx7c4c=;
 b=SfIqbXR66az1LbNuD6Pwzf6Vmdcc1Y8kU1SNOITLBwNslTWHy9F+KmG6WMvKzOg3gKMvBdkAyPLUevf4X6TAGuLgfVQfS/4jTEZS6CDN7eGRzBV9drh073fPjEBCNmrQHIBKstSoAhYy/i5qjI6RY0S+i8V0jELMVrWqtpHXljm7c2PDGHb1GR0r57bj4AL00xZAUdtIc/pu/rBsBwIFxwdYRQ6v6HoPOX7QRp/VDtVMQwyEce0uJsTpdOQTGbPfZReRoghCSDptsFixeL54f87pCgKAy9yHvvNSKGdbLfYrElIDgMLBb9MgOQatinqXztXRMDhSA3klGaQyVd7XdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EAUlxwWmUxeR+nYVbls0fqQA6SIrF27o1bSHbx7c4c=;
 b=CJM4jK04eauAtls7adwpSwCl6nOWxLlHzYfzOKu79zsrILq2Q11h/aWd61gCKdUZ2SE7YND/VBFf8PHGccHkj6Fk2AstkrlQnGNofBFE6C6LVWdGwe0e3T9QmOF4b7eaq8U66OIJw1Phv3U44nrsaM2p4K2Hn83odJt5dMKQrDJ18OvcavJtj05ie0YtJztOh04yY53Nu69ZObenWbiRUD2vHRgR5DHvey/KkNlqnH599jqW4R3CfAkwc4oHCYzkauEED2fF7WSow2gFlfTHC38oD2bRd8pI/EiIXYq7ursLTaKacw7PRxs/EqC+uU5A3Ivec0lPOgO5A+XhVw5N+Q==
Received: from MW4PR04CA0180.namprd04.prod.outlook.com (2603:10b6:303:85::35)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 02:48:38 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::e2) by MW4PR04CA0180.outlook.office365.com
 (2603:10b6:303:85::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 7 May 2025 02:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:48:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 19:48:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 19:48:31 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14
 via Frontend Transport; Tue, 6 May 2025 19:48:29 -0700
From: Wayne Chang <waynec@nvidia.com>
To: <waynec@nvidia.com>, <jckuo@nvidia.com>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Haotien Hsu <haotienh@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/2] phy: tegra: xusb: Disable periodic tracking on Tegra234
Date: Wed, 7 May 2025 10:48:20 +0800
Message-ID: <20250507024820.1648733-3-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250507024820.1648733-1-waynec@nvidia.com>
References: <20250507024820.1648733-1-waynec@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DS0PR12MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9518ad-8c64-4c9e-f8ed-08dd8d11aaf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTk2alNKeE00WWhmZmQ3R3lCc0lldGpSL3JCWXQrUFRnYkU4cVE3TWRyMHpS?=
 =?utf-8?B?ZXorZVB6Q3NwMng4Y2FveStWU1A3LzVCaHF3L1AzTDNjVjkvWm1pL0ozdXNp?=
 =?utf-8?B?Qy9KOEtpZkYwUWU3alluWVAzNWdGS3U2YzV5NktuSWhOVGQ3Wk5SSzJEMkJl?=
 =?utf-8?B?SjMyNkNLeTdXdTlneE5XNVN2WFJzVW04dHBSRzJEdHE5TW5DT3hVcUQzM0RW?=
 =?utf-8?B?cWMwVExhUktWMFJ6U1NzTkNPZGNpSnlna3ZGTlFTSk9OczBMV3hpQXpyTUZh?=
 =?utf-8?B?d2pJRkFnM29JOGsvUXNOejFPaXlzb0RERVMyM01TOElSZ0JXM0JOK1Z3VDdP?=
 =?utf-8?B?UDIzY3U1Qkdmc3hYdHJMVGhZNG93aVFvSjJZRmgrVzNDRDFNWmdod0UzaEoz?=
 =?utf-8?B?b3JDSWxLakF6NFVTS0Yrek5ocmVhcnVqZVR6aWg2QWJJYU9CeUNGM2N1WkpE?=
 =?utf-8?B?UjJsVlpkNWg4TUNSWjhJSE9IVjlZQXNNZmlUTE96aTF6S0VBRUxtZmk3SzU0?=
 =?utf-8?B?K1RnZkJEdjgyMTlBbFdISGRvTjlHaDJmQVNZS1o3M3ZZNm0vaWNvU0Q1bXJR?=
 =?utf-8?B?YTV3ZVJROVk3MUtjTVVVOCtaQ1lWeXc5SndIZXptMU5taVBWZXltRGVjRkFP?=
 =?utf-8?B?a3B3b21aVUxudHB2N2pCd0RmMkFvZGZaU2Z2cnpGcWZRZkxXTXBicHFyV1Z6?=
 =?utf-8?B?TCtzc01kOEdkN2FtWHJjVlZ5bUVwOWlaa1AvdldTYXFicGxwUGc1M1ZNM05h?=
 =?utf-8?B?eFFUb0hibURwK3V3M2FjdG9rLy9VZVhibk4rWHZRVFYrbDFCeko3ZjV5WmxC?=
 =?utf-8?B?WThGSGxHdGxqSmt3bFhBU0h6S1F0U1hIbXZHOG9qckFEd2ZCTXJVY0s4dytB?=
 =?utf-8?B?ZERUVkdnd2VoVmRzWU1QY1N5bjFYVGNBYUg2cFJGQ0JBd0hZNDNyQUNMbjdZ?=
 =?utf-8?B?REtlbVhOajUwNVpGNUJGRjA4Y2pNdDNIZWJvY3UvN1hucjcyMUVTempmcDZy?=
 =?utf-8?B?NThZOGNkZGx0NjNJZVp6NE5rSGswa0xvWC90ZGJvYitjenZxMWNTTExyS3o1?=
 =?utf-8?B?RkpBdkU0WGhLOWRDUWZPckRnMVpwdmNaT1dWTXA4UDVrWFhYLzMwUmFyZ2Rs?=
 =?utf-8?B?b0tDSHBxbDJGRVp0amZqV1VPZVZLN3N2aVJrdFNQT2lHaUt0MllNYTF2Ym5t?=
 =?utf-8?B?L2NNZ0I2cEJYT29kWXhqZkJRWDJEbTBzcEkxOHpyeFM5T2ZQZ0ZqRjJvWGY1?=
 =?utf-8?B?RlJHdW5Hc2k5YTJaNGVuaGxjeDBVQXJLTkxPVlVETFJibXF5aG9HMkthME5X?=
 =?utf-8?B?UkVPZEthMlE5WjZRaEs1clJJakVkZ3FTL3hSaHFPSXEwRVFXZEp5eHFiTE1H?=
 =?utf-8?B?WUkxdThpaDNLSG5ZczJtTUJTYWJ5bFFPeW9kWFRqY2FpemMrajErU0lxbElO?=
 =?utf-8?B?WXZCQmJYZ25JcUplSmFqR0ZpWnVqa2dRbmFNL2JlTU1lMDdKMncrNTcwVm5s?=
 =?utf-8?B?YVBNdjhxUXdKbDZTT1IrbDBHdXIvRmVMUFBmaGkvVDRSK3BKUE1Oa2NaZG1v?=
 =?utf-8?B?RVNVWFpKalBEdUU3VS9nNExhQUZlbWd6ZjVIUW5PYlNzblZkRWRhVzZEaXJx?=
 =?utf-8?B?QlFoRElKY1pDeGduTEUwb0hwL2xLYWQ3SEdBNkp3WFJYdC8rZkFUaGJzNWNS?=
 =?utf-8?B?MHNOd0NWU3cvc0ZzMHRUbkM0d1NaWFQyNG1WOXMwNmRtMlZrYmtRbnhrQWI5?=
 =?utf-8?B?TU9sWE84TURnRGZUamVOTUpURnNYRHl6UVhZc3BoN1FIMytjSGFqQlVSR1pG?=
 =?utf-8?B?aTVLSVJlYkwxaWdEMk5OWkZyS2VuR0k4Tm1McFNpYVh6T1BDQ01xb0piSFhV?=
 =?utf-8?B?bDB3YmFUVFNCendxaFdNU1NLNmtBQlVmbTRWY2h0V1YzY0c3Q0QxRW5pZlVO?=
 =?utf-8?B?R0ZxOGdFOGgzUFV5S2tNeXg1aVUwcGljT2JaOFVORVJ6djZPWXJ3UEZkanRY?=
 =?utf-8?B?ZytQb09uU1I4eTZyaUt6cFZzN3ZIeitHRktmVE5aY2xpWU5IT1ZqWTBHN0tj?=
 =?utf-8?Q?2AXgXs?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:48:37.7782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9518ad-8c64-4c9e-f8ed-08dd8d11aaf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535

From: Haotien Hsu <haotienh@nvidia.com>

Periodic calibration updates (~10µs) may overlap with transfers when
PCIe NVMe SSD, LPDDR, and USB2 devices operate simultaneously, causing
crosstalk on Tegra234 devices. Hence disable periodic calibration updates
and make this a one-time calibration.

Fixes: d8163a32ca95 ("phy: tegra: xusb: Add Tegra234 support")
Cc: stable@vger.kernel.org
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra186.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index dd0aaf305e90..414f4eabfe9d 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -1703,7 +1703,7 @@ const struct tegra_xusb_padctl_soc tegra234_xusb_padctl_soc = {
 	.num_supplies = ARRAY_SIZE(tegra194_xusb_padctl_supply_names),
 	.supports_gen2 = true,
 	.poll_trk_completed = true,
-	.trk_hw_mode = true,
+	.trk_hw_mode = false,
 	.trk_update_on_idle = true,
 	.supports_lp_cfg_en = true,
 };
-- 
2.25.1


