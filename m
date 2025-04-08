Return-Path: <stable+bounces-128807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5E5A7F310
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 05:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28C53AC2EE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 03:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA98B24EAA6;
	Tue,  8 Apr 2025 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fywo3f8I"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF4F1DE2A1;
	Tue,  8 Apr 2025 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081769; cv=fail; b=cDP4iasR0Y+/XwiCTmPJQETiHI1w95p4cqUUY+gCxGXer/Sz6n88aI8JsBbW2cNtMTXTJQKt5Jui+il951iKpCj7kYVGc8tAydK/XuxIbCCgm8iMa4s/VWMncWzZY6MIWRZu8LT3sxPFOmJCkkkRMP26+6Qz4VtXj03Njf5o/mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081769; c=relaxed/simple;
	bh=PwZFeKZGiYILs4oGLJhkYc0idlsdYM7LI62MQ/O6j4c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7rh+gS1LInvXZQyV8sZCcIums4IABbtaFwOdMPZAzXiRnFGdcTWEMTokJYO2yIB0ElMYr5aYj90i2qhKcQgfOyAMyHKCecL7rAYbeyKcZYdlRBzd8PFROuWX6g5TjC6gMheZ7HNAdNrYYzRgAu6CroT9Xa9ZZiBWtpdUEFtyic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fywo3f8I; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTpnIpcy0OBD8Q71vt+grCKstbv/E3mVhrJ03sKuYQxL2yhXL/sShOxFJ+OEWafNPz88nwfKOA2CFw/GTZO1N5Z/F9uTs4SDLtLJdmFxdQ7hpRtmk/L9ZkDdZoeS1UXNT+2x0fOpmOY6nmI2GcslAxZ2vuVLUI2X3zpAeIcQOGN6hiSGAQoHCh9dMP01K1hrLQuQWtQyA78NEqkgz/G9Wc4IEc9Fzou0NmuqhoegSJKjzuCiIZq5jwgyPoQPCUYw4JQhB2Cm6htHk3Z060sUteGdFbefemAxcj43IbUrQqR6iUp5tIQ6HMVIdVyAcCrxUi4FMffHcRFxD6V8ONo7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6X0IH5qSMC3NspQcC8Jpdc5d7pOaui/yy5XH8Uo7nY=;
 b=y36skmCcsqbLjUbyobgSRmLS6bE10AJtRYmJe9/x/+Flp8b6Fq0RLYU5o8a8w8SBPrZJlvU/X5JvggvtYkBB6QbOJtS8I+/+VptDEcgTHx/CXgrBD1+BI+4/yHOYt4MgziFZIV/miBptrvqWZMEeMcNrRfy/lxoIwJtytDeorra1GcgF2jo0KJBIwt9sPc7y1D8EkWCRicrikqT5sMoe1JxaHIq5U6olKBsiCnKSyz/aF3kLaiCRGcHYvEmA/fSStJ24/hyaU8S/4MN/sn+NBg2wfotr6jbzJLpEUiTQdtkEwzbTMtFM3ep4voiGzUYaOXdEEXh7Tz1RdWBhUfo7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6X0IH5qSMC3NspQcC8Jpdc5d7pOaui/yy5XH8Uo7nY=;
 b=fywo3f8IcvIP4AX2yWo88InWReGisfk8Up83VgShoUG4xAOWPePC5vopKTCrn33n/kSrVvO6FeEOd1lGTKZbLOzUobh7088u8Q2Qip6g5iiTWNhCDoVCcEDtE1MO3xsk7s0gp0s1F7QoXQzU2lSlA+6DMV8sEFmkKhaq0z4vf7kQyu8VYeej77+KlEqlc8l8IRbGuIzDEl7yVvf773/2+ksjCsn2zFLsec/DrBcmojALHnT206lCjwe+mIwZmTq14JGAeznY5IYIlm4q7fSomoHbarkWJzM2YrsEU6+8fl9qCuwxdyMQaAsstI7snu+t8AXZmMvFAELFxf3eSkWpCw==
Received: from CH0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:610:e6::13)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 03:09:23 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:e6:cafe::79) by CH0PR03CA0278.outlook.office365.com
 (2603:10b6:610:e6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Tue,
 8 Apr 2025 03:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.0 via Frontend Transport; Tue, 8 Apr 2025 03:09:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 20:09:10 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 7 Apr
 2025 20:09:09 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Mon, 7 Apr 2025 20:09:08 -0700
From: Wayne Chang <waynec@nvidia.com>
To: <waynec@nvidia.com>, <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
	<jckuo@nvidia.com>, <vkoul@kernel.org>, <kishon@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH V3 1/1] phy: tegra: xusb: Use a bitmask for UTMI pad power state tracking
Date: Tue, 8 Apr 2025 11:09:05 +0800
Message-ID: <20250408030905.990474-1-waynec@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 0644fda7-80a9-426c-6861-08dd764ac31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TUCrWvAiRDNoHxJEdqRyloHWvMdg+1qSxD+t4hPOrC/Ieb905vu6t0OYYoJ+?=
 =?us-ascii?Q?fo2FO9QDcaiRzB08i4kDFmkAj6HlmX5b+dwApE+SmhCTp80fllXnJ7oLEiFT?=
 =?us-ascii?Q?s6sZy1MpV0EUeuIAAWx5fwEYqmQdRLA//EfCmpvhJrQ0b9T9cXSSYlcQPh11?=
 =?us-ascii?Q?q4FPDpKU/QtxFXjYd3Mi7kkmyVlpJrD4Hav7kfLRYUgzAoMLiPDyM4psF0el?=
 =?us-ascii?Q?M15VXT0MWCUW3X6qsBOmJjMRn0kq6LfAWO0OpzIs4hBoYYThSAEiN+NRl/4N?=
 =?us-ascii?Q?wC0R2HNGEYjR4pWYR9anmFay/3pIvjGWs29SWIyggwd3JRx7HtENYl/4fcbN?=
 =?us-ascii?Q?uOlVrNPR9vimw/EimtCI0rN3puuko/Z3PdQGekyBnEm5BQ1zHRFp63WBjwqI?=
 =?us-ascii?Q?aKVRqrLHL0ntXgi9p0Z0QGQTCUyGAxXiE3xdMCi/EuwhFFQPbXkitgjnW7T5?=
 =?us-ascii?Q?eOh1YfE51kec5rmqTG02kHH3TvzngyTXoNu5iyaH3fw6PWdbCFTvUqQHpM2z?=
 =?us-ascii?Q?CEkkdpXme218BArfuzfQECRam/QRkc58W7a9R9EjQJZmZRtop7b7COZWe+v1?=
 =?us-ascii?Q?0jM3OJitK4ROe8tlOJQHiBNrz0a1KJwFloZpisrMgZpkZ/TswrJCSMIJaDI5?=
 =?us-ascii?Q?4a0sWQnIb570DtEQlqkxIHB5LHPb4nIDi0xmb27Jr+1As/5LB3tqKTXeYFoS?=
 =?us-ascii?Q?7a/P8XXAE/vesCbadZeixHtzz0ihlsx5f9a0gWQbEb9tSNkSXFjcdbAcq7iA?=
 =?us-ascii?Q?6MKk0QfXxQtGOyYdz3CdSqgXPJ3E7ulfPI2ITDjYZfjU4dAY7PAo/kQASKGe?=
 =?us-ascii?Q?DLNcY9mQSxIJIVz0UgiENsk5m0tzSunWulZ/CQUkjH3OsITZZr8fEeUyQ0da?=
 =?us-ascii?Q?7WTYVotGlpePiO5bDb5i5k4q7WenA39OCCtlp22coD3gLOIIROzw0LgyfeQG?=
 =?us-ascii?Q?KRm3WzwTTcIYCBrhsHL0U4qdbUvY0todCXfefrB58fJbajqY4msF6DiL2EKU?=
 =?us-ascii?Q?3ErmCla7OVUVbT7DVGLShoRtOsV1Y5Aath7g8fkmJ/ZopeVY5k3WgvV/MW4M?=
 =?us-ascii?Q?BPzdafbhQUtIQszRLvsQv/9nE3J8Fzp5UTrO1qu9Vst2MamL2wXHuh7Os5B4?=
 =?us-ascii?Q?K9B8y1STrf9ODngMdHNSjy7o3irimtfRM+X1BQYCnybbPe0nMHwD7sTKPVeL?=
 =?us-ascii?Q?pAEaDOz74UjNyC51QyNd9E1roHUNDeM9zI9/+xxKs82r0fHtfWK43HA5b6OQ?=
 =?us-ascii?Q?0mfh9Of/WLDRmeSd0yYEMb4VqTneehglGnOQNniFE3KwfR2KEAX9x4KxQJUV?=
 =?us-ascii?Q?OHDdeAlIa5zmY0kack9cst8pbvNJfS1u9GCMirVHPPOXn1c7GfV5Bn6vmUMy?=
 =?us-ascii?Q?HVIKTOV5W8aJh61czTneFo27pdlz1ajXCKNmGOSYXU23d6pVQ6YhPQNHO07B?=
 =?us-ascii?Q?ds4sF1uXLutuOcANPkWGwOrkQP8gUD8psUjkP/CQUANHFCBnJ4sZLt2UWygQ?=
 =?us-ascii?Q?gKSYPDGl/3uw7m8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 03:09:22.7973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0644fda7-80a9-426c-6861-08dd764ac31c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112

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

The mutex used to prevent race conditions during UTMI pad enable/disable
operations has been moved from the tegra186_utmi_bias_pad_power_on/off
functions to the parent functions tegra186_utmi_pad_power_on/down. This
change ensures that there are no race conditions when updating the bitmask.

Cc: stable@vger.kernel.org
Fixes: a30951d31b25 ("xhci: tegra: USB2 pad power controls")
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
V1 -> V2: holding the padctl->lock to protect shared bitmask
V2 -> V3: updating the commit message with the mutex changes
 drivers/phy/tegra/xusb-tegra186.c | 44 +++++++++++++++++++------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index fae6242aa730..cc7b8a6a999f 100644
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
@@ -603,12 +605,8 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
 	u32 value;
 	int err;
 
-	mutex_lock(&padctl->lock);
-
-	if (priv->bias_pad_enable++ > 0) {
-		mutex_unlock(&padctl->lock);
+	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX))
 		return;
-	}
 
 	err = clk_prepare_enable(priv->usb2_trk_clk);
 	if (err < 0)
@@ -667,17 +665,8 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
 	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
 	u32 value;
 
-	mutex_lock(&padctl->lock);
-
-	if (WARN_ON(priv->bias_pad_enable == 0)) {
-		mutex_unlock(&padctl->lock);
-		return;
-	}
-
-	if (--priv->bias_pad_enable > 0) {
-		mutex_unlock(&padctl->lock);
+	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX))
 		return;
-	}
 
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
 	value |= USB2_PD_TRK;
@@ -690,13 +679,13 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
 		clk_disable_unprepare(priv->usb2_trk_clk);
 	}
 
-	mutex_unlock(&padctl->lock);
 }
 
 static void tegra186_utmi_pad_power_on(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
+	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
 	struct tegra_xusb_usb2_port *port;
 	struct device *dev = padctl->dev;
 	unsigned int index = lane->index;
@@ -705,9 +694,16 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
 	if (!phy)
 		return;
 
+	mutex_lock(&padctl->lock);
+	if (test_bit(index, priv->utmi_pad_enabled)) {
+		mutex_unlock(&padctl->lock);
+		return;
+	}
+
 	port = tegra_xusb_find_usb2_port(padctl, index);
 	if (!port) {
 		dev_err(dev, "no port found for USB2 lane %u\n", index);
+		mutex_unlock(&padctl->lock);
 		return;
 	}
 
@@ -724,18 +720,28 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
 	value &= ~USB2_OTG_PD_DR;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
+
+	set_bit(index, priv->utmi_pad_enabled);
+	mutex_unlock(&padctl->lock);
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
 
+	mutex_lock(&padctl->lock);
+	if (!test_bit(index, priv->utmi_pad_enabled)) {
+		mutex_unlock(&padctl->lock);
+		return;
+	}
+
 	dev_dbg(padctl->dev, "power down UTMI pad %u\n", index);
 
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
@@ -748,7 +754,11 @@ static void tegra186_utmi_pad_power_down(struct phy *phy)
 
 	udelay(2);
 
+	clear_bit(index, priv->utmi_pad_enabled);
+
 	tegra186_utmi_bias_pad_power_off(padctl);
+
+	mutex_unlock(&padctl->lock);
 }
 
 static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
-- 
2.25.1


