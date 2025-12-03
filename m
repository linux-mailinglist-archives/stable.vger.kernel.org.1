Return-Path: <stable+bounces-198161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0068CC9D977
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 03:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4EA3A819F
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 02:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DFF213254;
	Wed,  3 Dec 2025 02:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AN4Ej6wr"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B1DDAB;
	Wed,  3 Dec 2025 02:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764730097; cv=fail; b=feY4BYr3oNreZ7YbVfQGHCCgVEfR4nAd3KUnyevQ1y63W8gic6My851l8w0WDDe3q+p3SFRkivlxrJ5MPLeNwhmB2jIp4BqV8xW7pTL5he/DYn4/N+fAbQCsdVXsOjxN6hVah8wDCnZxCyOwwqtifPmFAjEzovuADmHLstYqUZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764730097; c=relaxed/simple;
	bh=MMKEm0c2aK2eDebhBCMeahlVofxkzUCmCLqEiOfFJCg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J/n7KtxArINmtrRVg4bNRwDiBlv7UB4H+IR87zOvnNk2aBKJiIwLiINQcjbsSwdQvn1gzhwULmTLom5waq3Uv43+xEzj9eaxPwWibf+klX0kNigg45LAHxYlQOhQ1cv4JExdvAiQj6MTJtGid4lHZhgZkC32pGo2KQYuThpzoX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AN4Ej6wr; arc=fail smtp.client-ip=40.93.196.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTzFeOAgL63WkKeWJR4Y9jQEuOeu9uFZ2YalrRnnb6UcC67mazf3Phy796qGsM8KKMmyXuVqdXSQllo0dXQQQKZBCHvTCgt9ObnJowzWJ1++PHlrRDI6OV1/+zbOb/Woo3GwIsRZaie/wmmP6rRgZDaUP8VA3DJKNf+cMwCNcHW/vGz7n70KnIoAtNfsYCl0hfzJYi1WlP7PCqvAertiN2XSbCzmznwuaXsx3wQOINw4QkBsoXxOsLV6QzA3HTsa7xrY5tudaiyJ1ePPYhDJa30nHVT4pZuA3ucbkO13qE3q70iu7Yo6WaMwRMaa6xKB45TxAorVqRGwyfmKBKAgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjABCVYLrfkiHKCeVChSpLKX9pX9Lj2R9q9O0S5jkdQ=;
 b=XRF5a203tpxZGr/CUlZ+D1UvQCHiCEBA2Kd5UZqLR4X7fXR4gPQsWPQ1sKyiI/H5MhfLGZbCnySu+FKeZ4x9JRsllji1KWwN34W6wPp4dEqCG7g+o+r5DVIiXuI5iJxb3dVBC1swtpwJ5nhRFfbgF/xQ8v+I2Nyh4m6pl5km7Apxvf1l7oINCw6+awe/5V1yar8CA5prK92fVSOKcwkjuc9/dRTWSA2RB4HF3T7/CvqsCRtHQgyFjHeNDoFs7la3wQRn0QLWIKK39wtxJYaD6IR0J+z6iehgrWhor9u7rjRf8VHAoUOupQHJ36wXF9z5Nizr7Xhak704dp8jriH9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjABCVYLrfkiHKCeVChSpLKX9pX9Lj2R9q9O0S5jkdQ=;
 b=AN4Ej6wr+s7ac3ReZhrGK8WbzCzcGqvNiiq2YsTOl5BAEiy80zkE0m9Z95z/ip5bZm3MIIgTyiHDCnzjxwamzgz+kVNgeCyJxbu5RBmP6D4Ix8nhQA0VEjHBZV35Bl/82V+90EZ+Lt/cgihR3mjBttOEV08nyrN+Qaik8usZGiaURHfmE1vgKavtIcHAMz5fkE2uSGrSVwPYEPXYMnDnM7VHRejGcOUt/ClarAWBRqlht5Bw62lEe8eL8dJDDMST7nge99RRAVOCL8Km7iIwkbwRbfzAamxz81m6g8WQb6eOoO2jLwMYXVHP1hoOCA2tKseGNOxWG3+xOzpQF9hbrA==
Received: from BYAPR02CA0046.namprd02.prod.outlook.com (2603:10b6:a03:54::23)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 02:48:09 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::e5) by BYAPR02CA0046.outlook.office365.com
 (2603:10b6:a03:54::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 02:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 02:48:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 18:47:57 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 2 Dec 2025 18:47:57 -0800
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Tue, 2 Dec 2025 18:47:54 -0800
From: Wayne Chang <waynec@nvidia.com>
To: <jckuo@nvidia.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <waynec@nvidia.com>, <haotienh@nvidia.com>,
	<linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/1] phy: tegra: xusb: Fix UTMI AO sleepwalk trigger programming sequence
Date: Wed, 3 Dec 2025 10:47:52 +0800
Message-ID: <20251203024752.2335916-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cca15f5-6132-4be9-a57e-08de3216646b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FxFWOQbJ9+r3v5msnbP+/suqmVjiHWruC0/OnOxl9X/ojSjunq2y0WfKBKM9?=
 =?us-ascii?Q?lWW4SyUCib/4polPNt8dw4FItPgcl4afQ1fW0j0Nj1TXrsInPgcJ4kxxxS0h?=
 =?us-ascii?Q?FHCqD/Q+TQnmHe7YIdC7o+g83FWkiY+9Kh1g5aGQY8O8OIYZgSKz5UZRAK3h?=
 =?us-ascii?Q?qufrVnqRq83OuGzIqBvjhY8RvOoggwfiJOIckSTrhCRdGaKmSeYkaFv8sUyH?=
 =?us-ascii?Q?0s5K2EWRNMkktU+1p47QIS3vvHjYo92H8a++4A7UKBjqRtjYEEGtyuIt6n8g?=
 =?us-ascii?Q?vorq9osJp4OpgSv/+jjR0WVJ1JN6WVUue58IYFg9pGeD+aZhPY9O6BsMtpP8?=
 =?us-ascii?Q?pKMVTlrev1WLaSJRZ2CXklMAlNvyapaZ+nGsYuO38+rGjLKyyQOguLirS8Ip?=
 =?us-ascii?Q?K/7rERx4RG3aY+qY0yk2MkFrNzAQG5y4tZEZ0kHwgWeEWMWJZPoAwIbaqP7P?=
 =?us-ascii?Q?3vVQFZoNDwX6ZyBSLA+6WHp+ydU3STPfA90U4pQtWopW4Frb/bmsC8BKkWin?=
 =?us-ascii?Q?UaHsuMAMF/iPxAW3NlEylrNKc+JN0y3XWmWH/s4SQfn5ywnz7fKF0v9gZ9C7?=
 =?us-ascii?Q?EKQh1XyEBliaarzYCJ3KSehZ77Do4eBMto19piN68qanGvuxQkrkp7C4RSms?=
 =?us-ascii?Q?5zGzPvzcn2Nq6u3TFHYVsHqsruFY11V3XXBPpGXJEclHKYSlklpTUpzrKGFd?=
 =?us-ascii?Q?feF2Cw/fVt78LQIZczQhSjJYLq/u0VAWX4eNalP8HccDWL04jstMfMVhjJph?=
 =?us-ascii?Q?j9udaOv5YwWUoS1C5uWF80rSNXl5F7V0XAP8sC5Roe++lkuK9eTjsuLXJoPH?=
 =?us-ascii?Q?OKeliLDVxv1W2z9S4Ooa7UIOGlBf1ODwFGjZdAPbjq+UqfDizKj/k+960qRL?=
 =?us-ascii?Q?3FcW4HeRXu+usSAh/YvoC5HyhgCdx0ogBbtrMOZFIEj3imdQCpJJsPQY12Fc?=
 =?us-ascii?Q?UXLz2GmOPHplCxO5UQnfkQIP3kU/X3CGVrjeURuhFrymyfT1l/E5tZhBZ4Bv?=
 =?us-ascii?Q?jLIfGy67UzHSUuRWnVtStFFYpTHIdSelBcWoytF2djSvB5TgcEoecVjBIIiJ?=
 =?us-ascii?Q?8xaDgw427WRHkFMG+zZelcSGDPJHh3aX11g0y/Fem4U4BzV6UvFx1jDONYPj?=
 =?us-ascii?Q?BNBh/Z4c0BsKIiFM4hwqz/TJ2tkLdr4nYvAqn2X04gfwHcZxAJ8hxt7qtT/c?=
 =?us-ascii?Q?rcEdAdUQ2cXKlMHJCvWCtlBePOAAwoU2Y+hqqT8zDf5Oass2baHVmL2O0u35?=
 =?us-ascii?Q?fClHnZe8IQTy/WLfkDw4a2Wc8eFNUfpUo/C4rixWe8R9WGjT+ebPwxmzzwkC?=
 =?us-ascii?Q?riLlRTQxa5KIq1qKM5Gp4H/1yYMuECvcHcnJjVSv57EE6GISf8dCgmjM+ipL?=
 =?us-ascii?Q?sdX0aRlndwUWpZkhh1WBIgnWztc/QwAM6ZpmTFfxewkJxBrnpd86P5gOfgMj?=
 =?us-ascii?Q?ciFSqXkDd9rwAZCnxiGS7ajl96Qg6ieX+Ue1M0RE75yIr8WeamKCxEWYQJ56?=
 =?us-ascii?Q?260CfV6YCB5pnPl+nWleoWvWjFcbZHtYPIp5pb20DjWMXUSz/l3ie5mJcxeh?=
 =?us-ascii?Q?0cbL83BBSSiS4kHwyIg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 02:48:08.8284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cca15f5-6132-4be9-a57e-08de3216646b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968

From: Haotien Hsu <haotienh@nvidia.com>

The UTMIP sleepwalk programming sequence requires asserting both
LINEVAL_WALK_EN and WAKE_WALK_EN when enabling the sleepwalk logic.
However, the current code mistakenly cleared WAKE_WALK_EN, which
prevents the sleepwalk trigger from operating correctly.

Fix this by asserting WAKE_WALK_EN together with LINEVAL_WALK_EN.

Fixes: 1f9cab6cc20c ("phy: tegra: xusb: Add wake/sleepwalk for Tegra186")
Cc: stable@vger.kernel.org
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra186.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index e818f6c3980e..b2a76710c0c4 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -401,8 +401,7 @@ static int tegra186_utmi_enable_phy_sleepwalk(struct tegra_xusb_lane *lane,
 
 	/* enable the trigger of the sleepwalk logic */
 	value = ao_readl(priv, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
-	value |= LINEVAL_WALK_EN;
-	value &= ~WAKE_WALK_EN;
+	value |= LINEVAL_WALK_EN | WAKE_WALK_EN;
 	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
 
 	/* reset the walk pointer and clear the alarm of the sleepwalk logic,
-- 
2.25.1


