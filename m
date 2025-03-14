Return-Path: <stable+bounces-124410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECFAA60A1D
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 08:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1343AB541
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 07:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E2F17084F;
	Fri, 14 Mar 2025 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yw7Zd5pz"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB113B592;
	Fri, 14 Mar 2025 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741937660; cv=fail; b=GFF9xQThxXgjU79M+SskUZZVk9bpNTYYFP8dcjT1IjjZevi3k6/o1BS/FHGzzacKP2wbBUMRZ2lPRmreFwiJq1IACnvHWFFZn9z90RafeQombCHkJiBsL/6AgnXxemMfbpkg1emSD91u1APQY8z+gIL+r6G4rd9dFybwc4aUPoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741937660; c=relaxed/simple;
	bh=QodNFbUGjAanTxQ9UbqB1TMhQ3TPoTPWmmellfG0NQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qeLqGucXuuvxuPwGAIpro7v3oeFPQ1esgdzPfcHwqvJamr2NoU9ZW5PKe1XCgt0CR+Nylb92a6YU+jlR4wQKZ0bX+BLuhK5t3J3S9sTTpzSezvKyeIWUcvVQnw1ewnlUHM+GWp+C7NBISReIqNNDPaWzD6ApqoBYV2J+NLFCsx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yw7Zd5pz; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk3yItr7oBn0+T9HQbk818kuxBDmHK64LRBTda2O+4qMMu9za9HGXgsPKmWSn5dmT9H2O+9M3Bq860HonFxr/vpDDA5oF82O2NTbWqtOuCz0/JAb96YOhiFbFXRzctFia1z54qNQNy5eSPli5gRBrpNII1YqMwL3IMMqKHsF1A/+WGzVnvqJSlsZWvdSfXomL67m+tH7l4ZVr7+L1huqhJgvhdEILTvVZlU+1UBmmfi2o+ILGQrfronXvlOeTNZoBTg4PySXI1/W88nF/ajcUvei5jkmPDUrqVhUQmXzk4AchiTAkHwkOtVJsswA8o+59JWYbbCeLQcjdhht1GvVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXRoB3hPyggA0rjQcjKCD70R57MXwgdnYFt+C2Wfqp0=;
 b=P+0t+iEQCPpzWK4raHW23RLOVI990XOXHqlcnrjgKbz8p5lxgY2seIzAFdmnjCYIEBKWg0/YFKlFCZRKOPsWqE0tI2W5kqSJ3FAlvsQHZHC1XYL9IPrZNiOI4xhkov9E/SNP7K+kpNPngE5AgbjKnofiYCmdu6C3VhNwqvr7gFZD6cWvwg5kIAE+EFWW9Xwoo2Y7UXMQBmYLTpZVu6ogHxawSFtibjzT0clhJzNjN0eccj9VCV1iocE6mxmMtjVDhNdNoxsZvMhIbKcixNEuleufQurIN2Ijh/pfTAo/ZQP+03zKlPEaF6fAdjhtFUUJcHZCZjl9TRyKKA5ehuk3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXRoB3hPyggA0rjQcjKCD70R57MXwgdnYFt+C2Wfqp0=;
 b=Yw7Zd5pzjYEm5D89xU9AgiiXsWDvnwb8RSBbQFu7Xt75ydL2JVwn4wg1dPn3sv8Lh69l46m7443ZqmAT3wvDmzLlWfTQoiAtkUi+V6Vy3thiQqM/wWkUjovgVdKfywMF9z4L2iuXFbid3hnFXsn+SQtIfIHYUHHFIGzmEEQY3cRm5/b/nwf9FqzXB8toMP0mXIuMegZtQ2/a2gOnVma+CmCydvKd2kBGfmTwKL8AGSsaUSFHarI7BICe/6xg3OIDAMKwhD1jA3zpOd7p5cT+APaZKPBFObGTVB+umAMmJy+I0egK12sX9KzNgh8/9k839QZaLOSSryjiZgsfbdLifg==
Received: from MN2PR17CA0001.namprd17.prod.outlook.com (2603:10b6:208:15e::14)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 07:34:14 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::16) by MN2PR17CA0001.outlook.office365.com
 (2603:10b6:208:15e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Fri,
 14 Mar 2025 07:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 07:34:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Mar
 2025 00:34:01 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 14 Mar
 2025 00:34:01 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Fri, 14 Mar 2025 00:33:59 -0700
From: Wayne Chang <waynec@nvidia.com>
To: <waynec@nvidia.com>, <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
	<jckuo@nvidia.com>, <vkoul@kernel.org>, <kishon@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/1] phy: tegra: xusb: Use a bitmask for UTMI pad power state tracking
Date: Fri, 14 Mar 2025 15:33:48 +0800
Message-ID: <20250314073348.3705373-1-waynec@nvidia.com>
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
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c5338b-e569-49a5-4201-08dd62ca9e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uFoDSYUIBznsfF+c1AFDla4nQuX/w0l+Bho0G/0SSonMOLkwb7WFMul1guqu?=
 =?us-ascii?Q?U0hpN+8rUpr2cKIXrsmTXF/39U9b1uBxGPENLK0ymFzUDa4Qz4bMJIgIPSss?=
 =?us-ascii?Q?SIbqWVy6ySgnhRwLC6GfqLZuexIisrr6D+8dVQ3qaZup8FhHa55wULcS+JdU?=
 =?us-ascii?Q?OcbKXadFc3pN/LKZNGjdgC9TAaevznGCG5sKT+Ztq7d8tlnTzRKeLz9wy9EY?=
 =?us-ascii?Q?3X0jxYrEiqllwJ6CouTCq8Cxx5jd6uB6owOQzHcpviRx6P4TZ7fXXTCoBOpY?=
 =?us-ascii?Q?1rWgupQIAkMc3leJVf6CvddSUpNcL/s1Bv6JhBCxODckbW6jAG10UZgf5TFK?=
 =?us-ascii?Q?i+DNJ3P7dBg1aI+p4/3+pNeBV07zTCJxv2TavMeL/+U+vkxKb5Ts+iI/13Dk?=
 =?us-ascii?Q?G2KYfX5df9GXPnSdcV7XOxjoSGBJpIp7Dr5EYNAXMLWs0mV6zSvq/xy/CKb8?=
 =?us-ascii?Q?+b2BoZuh5Vg2gx8qjxC8zIc4nbEBsR68vSQ991sFyPnbno5RpRpVAMVuOWKO?=
 =?us-ascii?Q?vomMCm9xl+qjNohuB6R/eGW1+gfbn1PTr4rizUzX1+fjIrTJ3/sy42sBON0L?=
 =?us-ascii?Q?5c+ZNlOIAjrvSuhc07RkbCHp2eADaauM11aub8zX6vao17AVGFzLxjQAEgP/?=
 =?us-ascii?Q?PNJir55dCawqjUuSUllk4ZmUUaCxSyJKES//B4Zwx3NPUd7kDwCn59UGsmBj?=
 =?us-ascii?Q?w9+O3HkHfZBDc2UL+pglx06T2URDoBGdk3TrE/TBnPuSmZW40elfqHc+77jF?=
 =?us-ascii?Q?stER43qFQ+uDVLqAQ/PGvpphP/NzKTEMpPywvaBUBpTKFDi3df6SJgM66lal?=
 =?us-ascii?Q?kx68CwXaB4uqWhXp2YvpDlDBUTYCASPlSjHTCoIBuQb6008yZZQcfC2v2cva?=
 =?us-ascii?Q?oIwvX343XSrLGOkswd4GxEJHpwnykShFa49rmbnV8fEisP7Gvs8IuouAr4Lt?=
 =?us-ascii?Q?TYBI1yT2uB2h1b6H89+9VxOxczyJPA4YPK6CfqCjz49Cg+wpH5+e4VEWJc6q?=
 =?us-ascii?Q?i0R9cuSKepzLF6vHlh35FeYT67l3snKo4Qxteo476xy3Zo0eNppvziOMQ5C+?=
 =?us-ascii?Q?QHrm/8aOmMpMJvZEGlmiuz1CqLK5dTgm/r2vipxL3+7O3MIJRhoQUv/JUQlN?=
 =?us-ascii?Q?0WieYpjZt7iiaeOBrdRiM4vKOHNP/BOX4RnBVjWtiWWP7YRtARRZ4Trce7XP?=
 =?us-ascii?Q?SCCyEjKpEFxrsMWOmZbLfb7wiAQX0KM9a2HXsYMAm9Asnp4X0x04JuosV8CD?=
 =?us-ascii?Q?mM4Bh+waejGIit8HVRJ9/zPUxfzhBl+qt752aP/uYJ4NnCzlTiB1QUVI0Xhk?=
 =?us-ascii?Q?UYuedwxvpIobCn+wyTcrxeDMM1DPAiwUFdzat5inv/QXDngQVqECiGI1DZ6T?=
 =?us-ascii?Q?8efMs9HJDz0NotmQbYDAh26MyLtiDsIfLNmH5MYJ4EUGxkrCp4zcbgV0YWcY?=
 =?us-ascii?Q?q9PUhxq86o1H2aTztkGuAfL2ogeNR8EqxuTIcaGRQSfjtfgZ/cai6x5r5HLS?=
 =?us-ascii?Q?Q7Fv+YCk+ZcXiUY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 07:34:13.7183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c5338b-e569-49a5-4201-08dd62ca9e87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276

The current implementation uses bias_pad_enable as a reference count to
manage the shared bias pad for all UTMI PHYs. However, during system
suspension with connected USB devices, multiple power-down requests for
the UTMI pad result in a mismatch in the reference count, which in turn
produces warnings such as:

[  237.762967] WARNING: CPU: 10 PID: 1618 at tegra186_utmi_pad_power_down+0x160/0x170
[  237.763103] Call trace:
[  237.763104]  tegra186_utmi_pad_power_down+0x160/0x170
[  237.763107]  tegra186_utmi_phy_power_off+0x10/0x30
[  237.763110]  phy_power_off+0x48/0x100
[  237.763113]  tegra_xusb_enter_elpg+0x204/0x500
[  237.763119]  tegra_xusb_suspend+0x48/0x140
[  237.763122]  platform_pm_suspend+0x2c/0xb0
[  237.763125]  dpm_run_callback.isra.0+0x20/0xa0
[  237.763127]  __device_suspend+0x118/0x330
[  237.763129]  dpm_suspend+0x10c/0x1f0
[  237.763130]  dpm_suspend_start+0x88/0xb0
[  237.763132]  suspend_devices_and_enter+0x120/0x500
[  237.763135]  pm_suspend+0x1ec/0x270

The root cause was traced back to the dynamic power-down changes
introduced in commit a30951d31b25 ("xhci: tegra: USB2 pad power controls"),
where the UTMI pad was being powered down without verifying its current
state. This unbalanced behavior led to discrepancies in the reference
count.

To rectify this issue, this patch replaces the single reference counter
with a bitmask, renamed to utmi_pad_enabled. Each bit in the mask
corresponds to one of the four USB2 PHYs, allowing us to track each pad's
enablement status individually.

With this change:
  - The bias pad is powered on only when the mask is clear.
  - Each UTMI pad is powered on or down based on its corresponding bit
    in the mask, preventing redundant operations.
  - The overall power state of the shared bias pad is maintained
    correctly during suspend/resume cycles.

Cc: stable@vger.kernel.org
Fixes: a30951d31b25 ("xhci: tegra: USB2 pad power controls")
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra186.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index fae6242aa730..77bb27a34738 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -237,6 +237,8 @@
 #define   DATA0_VAL_PD				BIT(1)
 #define   USE_XUSB_AO				BIT(4)
 
+#define TEGRA_UTMI_PAD_MAX 4
+
 #define TEGRA186_LANE(_name, _offset, _shift, _mask, _type)		\
 	{								\
 		.name = _name,						\
@@ -269,7 +271,7 @@ struct tegra186_xusb_padctl {
 
 	/* UTMI bias and tracking */
 	struct clk *usb2_trk_clk;
-	unsigned int bias_pad_enable;
+	DECLARE_BITMAP(utmi_pad_enabled, TEGRA_UTMI_PAD_MAX);
 
 	/* padctl context */
 	struct tegra186_xusb_padctl_context context;
@@ -605,7 +607,7 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
 
 	mutex_lock(&padctl->lock);
 
-	if (priv->bias_pad_enable++ > 0) {
+	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX)) {
 		mutex_unlock(&padctl->lock);
 		return;
 	}
@@ -669,12 +671,7 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
 
 	mutex_lock(&padctl->lock);
 
-	if (WARN_ON(priv->bias_pad_enable == 0)) {
-		mutex_unlock(&padctl->lock);
-		return;
-	}
-
-	if (--priv->bias_pad_enable > 0) {
+	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX)) {
 		mutex_unlock(&padctl->lock);
 		return;
 	}
@@ -697,6 +694,7 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
+	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
 	struct tegra_xusb_usb2_port *port;
 	struct device *dev = padctl->dev;
 	unsigned int index = lane->index;
@@ -705,6 +703,9 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
 	if (!phy)
 		return;
 
+	if (test_bit(index, priv->utmi_pad_enabled))
+		return;
+
 	port = tegra_xusb_find_usb2_port(padctl, index);
 	if (!port) {
 		dev_err(dev, "no port found for USB2 lane %u\n", index);
@@ -724,18 +725,24 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
 	value &= ~USB2_OTG_PD_DR;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
+
+	set_bit(index, priv->utmi_pad_enabled);
 }
 
 static void tegra186_utmi_pad_power_down(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
+	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
 	unsigned int index = lane->index;
 	u32 value;
 
 	if (!phy)
 		return;
 
+	if (!test_bit(index, priv->utmi_pad_enabled))
+		return;
+
 	dev_dbg(padctl->dev, "power down UTMI pad %u\n", index);
 
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
@@ -748,6 +755,8 @@ static void tegra186_utmi_pad_power_down(struct phy *phy)
 
 	udelay(2);
 
+	clear_bit(index, priv->utmi_pad_enabled);
+
 	tegra186_utmi_bias_pad_power_off(padctl);
 }
 
-- 
2.25.1


