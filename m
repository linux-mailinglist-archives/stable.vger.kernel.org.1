Return-Path: <stable+bounces-141960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F77AAD38C
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 04:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB177A5E6E
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 02:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCBD172BD5;
	Wed,  7 May 2025 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MwC4FtDu"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65187360;
	Wed,  7 May 2025 02:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746586128; cv=fail; b=mlGN1z774S1FgTXQSHUIeREwLK8pimP9doc6eCmgmnHRrFJBdBiLHbpxpwKUDBX44L3UKgdFtQc3gpYhrGXEgBnqdFui2IIK5m9w4DDYw+hV9241H9TrA9Xv0G2ZcVSPdbUh63TEPstcxvsjYtZSsjimVMuVF1Ni/7CvjorVv60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746586128; c=relaxed/simple;
	bh=VipO+mmQMIpUKITrw8YNUW8h3MM3foKtX0ff96FPKP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoLd5oXg2puBpIbd/ZLgyP3YuRPtYTJrQ7XoJIW3BdVUgEf70eGo4wq4xn82z8M7oUdOvq69wx2+YVxlYHp8UIqvCKwAbCL4Pnjim0gM0WGL6+HHGzbIiLux9MT4NdPEbz9a1NpUSBlragy3iALZlTgaXO3Hn070Ft9aVT6R8YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MwC4FtDu; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7Dr4aRuNbuLqgC63Bhj/Ne93fIg2ih2cEOMW1sybzGgkllPSiWOUUbvA51ndzIEfnUsFsj/39cfJ70OWZsBXqcsvlt3U/TpEurkL1jtYxTIi9RqCJJMsUANiHV/gJUHHJQMAbOoeiZZwRws9u67uKQQoi3q7i/zDBRe6ywuaAaLUH3cNfdzYF5dyvzLpEW5iuB2ugxG14sWDsCT05VxjzYNMEwvV4Wxem0JME46Fem3aAF6O3DyWN9H0nYXDPaiDD3AusVbPbfWmignd/oE46XHFKpsGIfnCviwy4NKUN7M6jZAHGl96fsD8o61Ub8xrNMnQjj/t7veX7Rs0Z2ugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sy8gNXFAZcR3YBq07i1jmeIn7KhYOFFCjK0asDbRk7Y=;
 b=SKCkTJNa/vCAEl1D7Mtg6oHjSCxGC7LldWaH9yQl7Ws9E6G3CwDgmSO8Z+v6puiP4l8nnHRVtmuJdUSOMFw8PSFMAqTIRtvxt7D98ikBzJ+1osBTXLg8etDEdXt5OIRbZojOGCeCkbSvNy0rSFuSOwI8tCCBmMYUf69bfXMVSiSW+JeBC/1XIuPRabSygF26oZMsRKRf5Wr8X0ZTm8BmDY1nH1eS6Zg3//CyIDeYR7jU357NyomEoUwHll6XfAYhCUFBEphmRAeMnbZ8Iu2SeWtuxYynQy+04Qz9imTtg7AG0QsGMXG34EQ+d2ACsdM5polyx1ILuGp2aCwMeDz4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sy8gNXFAZcR3YBq07i1jmeIn7KhYOFFCjK0asDbRk7Y=;
 b=MwC4FtDupkxinSl2DrN9X4X8UxJf6GAErMJW859QBsEsaEO4XUkywTyUhLaKAE37nirc4Zw5I9oy4U3gAZ3sKtQVvG0aBsjWH4rOZ64oymLwCy2blLS1qjlSL6ANHKuKWad/YDGJ59Ar7oIfXE+fgiUI4lv74lf2p7Zi7ytAAtpwzOoFYigf0q5DiABZMCwE/jU/yhrX1MlJEdkffcqIlb7nLAd7BFjw8Z8Oz/7lxHjfhNElWnt9Ez6Zx9Q4kYjzXwdRdhoE5PuH3io1oLCejiGlkMrkK4Dan3ZJ+bP3oWh4FCYCXCthQfgrTM6syz7xOdh8RUgGklxzLUoli00uQg==
Received: from MN2PR12CA0021.namprd12.prod.outlook.com (2603:10b6:208:a8::34)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 7 May
 2025 02:48:42 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::32) by MN2PR12CA0021.outlook.office365.com
 (2603:10b6:208:a8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Wed,
 7 May 2025 02:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:48:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 19:48:26 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 19:48:28 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14
 via Frontend Transport; Tue, 6 May 2025 19:48:26 -0700
From: Wayne Chang <waynec@nvidia.com>
To: <waynec@nvidia.com>, <jckuo@nvidia.com>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] phy: tegra: xusb: Decouple CYA_TRK_CODE_UPDATE_ON_IDLE from trk_hw_mode
Date: Wed, 7 May 2025 10:48:19 +0800
Message-ID: <20250507024820.1648733-2-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250507024820.1648733-1-waynec@nvidia.com>
References: <20250507024820.1648733-1-waynec@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c215162-fbde-4e3a-3e37-08dd8d11add1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RTZg/5tWWwKAb3BAQ4ULZ5O37H5HKtHwrCpODcmRpa2C9SRaU0R1eclVyj2E?=
 =?us-ascii?Q?TQq7uprX+BH1WHLIaL0S8leLUKszyu05/PgaWECU9vTCxJj1ewdXF3l6By1p?=
 =?us-ascii?Q?ESz06JBFdd/u0CdXSSQHOuDfsxVyEN0ApsHee/SMekcgsg1+RIVdhQg5l93x?=
 =?us-ascii?Q?sXmU4rrI9UX70yFqGK8JNxd+4szPZSsPKJM9H9+0k6djFKHUslqmSfT6Na8j?=
 =?us-ascii?Q?yZgRJETHOPnuZCL9WJbXFrPLiWCrp7ROyodRpiU69fzWXA5PVPFvN2kHKg6x?=
 =?us-ascii?Q?D8ViYsw8yOVmfKEXCPyRRFJvQFZ8VK0Rqb8F/IC4yT453l2uJhfAF2c6cVy/?=
 =?us-ascii?Q?ZPMZLYqhORdD2wwibQ2tA01LRHZPNllTPvFnU3mLaDyVyb6YJ1SDruUN7XDj?=
 =?us-ascii?Q?Xj2wFwSDX2e6ukrOhXeDeaxetAhg2TUCiCSqFwJs+oOu9aX7Pg4H5RjWHnD+?=
 =?us-ascii?Q?7r8JBbuHl0fIdQOWgGj2RdV7olAMFpJo8uq4vKwZ9wRDP/jrJoDPgdwDbUOm?=
 =?us-ascii?Q?SdRPg+DRY/qh1H95tdYAz6u1Qfd5hKvIdK7rrnCw/6eqm/vvmc0RibP9yCxz?=
 =?us-ascii?Q?kgj66Gdp58KYGUCAZy4Oa8lh015BTU0NYm6b4i2PE+fCrpuXSqDtUvAfWsGP?=
 =?us-ascii?Q?RuDNrYloZNdkeiRQqMbPMAnon6tYOkMsPyGvZbbOUMKoSRFF52xGkGXn4KKC?=
 =?us-ascii?Q?7yT7z28Xe2JTwNJ9hHOJP/B0dh2a5WnsS3KnOcdOHqH8PKcGIjh7gSPeoraj?=
 =?us-ascii?Q?VRLutlX4MR8CyQWMRV/zk9EkP3Epqky3l/z2diqvnUHxLyYqEiU9zNCIde1b?=
 =?us-ascii?Q?wb0KDBOO9nPqNCLkbszdbNxt8itXp7TFuw7y6h9Y3QIwlZ1WcH00WS/ydipq?=
 =?us-ascii?Q?TAoDlwxSGJ6p9n0qdQtukP4wNlLaAy9f6wf54FnzwBDCOO12NuVxDtMqP2/A?=
 =?us-ascii?Q?oLPkHgKVBsEUR3y6SuTh0sGX1FX3mCW3hktgGpGavbQ4WrR6sq9ImIKpCnHP?=
 =?us-ascii?Q?6inw5IOxM6L26rLjuvq71/NUlv4Kd+sxs/DBDq0F/8yVPXo7RfmZVDtnLqEj?=
 =?us-ascii?Q?HYhbbaXACrv9iOeSCaHXGRqXK+pFiqeMmgu1lLh55LGabLk9BOENLzy7RgUp?=
 =?us-ascii?Q?0RArokQ7EWe8H+sjsHMQsI1c5jzZpDB/XSCU6l0Y8/+hDxb1Yznt0ZXrXDj0?=
 =?us-ascii?Q?Rf883LjsYqldjMIWU+MDDOkHkvo+nXKAcElbZOrOdpOzJ/+Htg44aDfBS7ZF?=
 =?us-ascii?Q?2wRHiXKODOFCm1IsnKGp9immQfe5Df6beql3PDOnuttW6Ml9YS8nlx0ozYGt?=
 =?us-ascii?Q?CeDpuep8IFZ1YoN7ssr9Lb63Jlc9cyxDr7B804gEhjq02xAIGwrFQ+kqCruM?=
 =?us-ascii?Q?AMTaVaWFWIPyUrKliheahjIkpI/hX7HscLTFngeMM+O6ZNiUfBSPXRnYcgZT?=
 =?us-ascii?Q?xPEdA2oOIRLBI74XJNLr6KPDPlBIXuFu+UT3LXBbts6PK1OSmbkB/jf82etV?=
 =?us-ascii?Q?tvf4n3yU3pl+o6828vRgpAb2oYlh7EDsscPm?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:48:42.5148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c215162-fbde-4e3a-3e37-08dd8d11add1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918

The logic that drives the pad calibration values resides in the
controller reset domain and so the calibration values are only being
captured when the controller is out of reset. However, by clearing the
CYA_TRK_CODE_UPDATE_ON_IDLE bit, the calibration values can be set
while the controller is in reset.

The CYA_TRK_CODE_UPDATE_ON_IDLE bit was previously cleared based on the
trk_hw_mode flag, but this dependency is not necessary. Instead,
introduce a new flag, trk_update_on_idle, to independently control this
bit.

Fixes: d8163a32ca95 ("phy: tegra: xusb: Add Tegra234 support")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra186.c | 14 ++++++++------
 drivers/phy/tegra/xusb.h          |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index fae6242aa730..dd0aaf305e90 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -650,14 +650,15 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
 		udelay(100);
 	}
 
-	if (padctl->soc->trk_hw_mode) {
-		value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
-		value |= USB2_TRK_HW_MODE;
+	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
+	if (padctl->soc->trk_update_on_idle)
 		value &= ~CYA_TRK_CODE_UPDATE_ON_IDLE;
-		padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
-	} else {
+	if (padctl->soc->trk_hw_mode)
+		value |= USB2_TRK_HW_MODE;
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
+
+	if (!padctl->soc->trk_hw_mode)
 		clk_disable_unprepare(priv->usb2_trk_clk);
-	}
 
 	mutex_unlock(&padctl->lock);
 }
@@ -1703,6 +1704,7 @@ const struct tegra_xusb_padctl_soc tegra234_xusb_padctl_soc = {
 	.supports_gen2 = true,
 	.poll_trk_completed = true,
 	.trk_hw_mode = true,
+	.trk_update_on_idle = true,
 	.supports_lp_cfg_en = true,
 };
 EXPORT_SYMBOL_GPL(tegra234_xusb_padctl_soc);
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index 6e45d194c689..d2b5f9565132 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -434,6 +434,7 @@ struct tegra_xusb_padctl_soc {
 	bool need_fake_usb3_port;
 	bool poll_trk_completed;
 	bool trk_hw_mode;
+	bool trk_update_on_idle;
 	bool supports_lp_cfg_en;
 };
 
-- 
2.25.1


