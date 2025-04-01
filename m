Return-Path: <stable+bounces-127303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC58A77755
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9712E3ABA7F
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C99D1EC016;
	Tue,  1 Apr 2025 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PMYMhuXG"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D861EC012;
	Tue,  1 Apr 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498735; cv=fail; b=Hlyqdj9jSrDAp/kLgvvOlNJI1uKHR3A9UZAkuos+GWMws08I2/aKIwB8Sy/yaSfcVVuAUzjnvB4iw+HRQUB7/Oqkc0rYkv5IXTj14fCXuE6CEg95SHfkeTfhskiCyYrTi5jzrBMLrDyP5beUP98aZWb7IprwUT2GttQexb/e1Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498735; c=relaxed/simple;
	bh=5rruFo3WTI0i1JcTUZuHIx14DJvHpQtLSGz8wK7ujSM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pMytyJJbt+E0EGhHe3Q+iAoTPhrqxDMpmTvi2iebFxESDzt2ysG3fe1Hy4J+YfFp1b1pRRlfInXcuxqisBn8X6UrkguO0ykQkEAT/6HFeqi1Cf3cBOMIbmxnnfHvxdkG0rIg4wfVpmlUzpU1wAaoO7/lHLnzWwrKcBnHUulSaxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PMYMhuXG; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbXtFR9MZ2JxMMKFmQJCp9VG0fgtQip4o8EbAaLmgLV2uD+QqacpkWk1HSSjYz6SkTh6ou57HOOQuVxK1oZBzmFcuFxQmxw4QDvya3f96bCu8JCupt6bOlKzF8HhvdCh6aNWOqStv8LUa6PqXm4ImrveGU59mikEJsCv17iiCyom9JUFsxmu5J1V06UbJ6PfPeQ4rSgbfCq82mZ/ifzT19v0KBul42DG4xWtwOr8uByi3jxvn3lHYze3Vb3qRyu4b5BjrXzUnQrHWTUpM5akqzw+4l6ofhnk5/qw70u+HO5J3B/kMdMRCe1kRgR3wcrej45QFDPQKF5XnhXsC3abZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEjbupUDuqN/uvvJHffeJIzKnCjLIrZ1HWmormjsTq8=;
 b=NZxiCNmn9HutcOL5HfHrqgOXXZirg7iVCx70bxoT+XREZFeD0oNIx9GCI45JHc4XlQLNOLh/oXdewuu6fMzMYvTSrOkVnxn1AEYJnZaieTSA+TmgpKvNJWAJ4oHCaJ3k7gyWEuKg+9A246aH5Ro3vErktu9purBqpFhflqd4xLPXwwOfUUHk1+bCc8VjpA2YDRPJAguW96LMSmVCXnSf7uhgM6gM/3XzZ7dxBuq5sjJSlBlz96sMM83g91/kBL4jlyTgFjTEk02u+I7ajW6CL6b6tFOTMD1TiJ7WzDcRPJLRmO1BSVND1NDlJIcGmA7lfiRjS9Bh8hgWj1zEky3ZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEjbupUDuqN/uvvJHffeJIzKnCjLIrZ1HWmormjsTq8=;
 b=PMYMhuXG2AdGqOYCEhkbWM5NXxv601vVXfbqjN7Xe3gCX27UjmV3BHxA1iAA0ugw6RV6I5sTT2Y4SJKzKDvn+3qgB0n92XR3HVBiTMYvjdcgGsy18ltmSOdTxp6PyE39bG5CjQLVZ17bkZezebT1jBniUJ/Pf4LCdP11t6pya26HY31HAoO5BWDGTBBnFeCCZ8WQQoY5VUHhrQy1u/YHEbHdEFVxs5OG1Ueew9wVbsUpZQEi1Jxm7/Hux9GkRYSd6F5UukSRQYEPrxmBzNLy6YLz82EbsKEqoTaDIANcpu7qDsB56pyiFS4qg7h+qRuB55Pq1rUe1wO4Bh7GWYju9Q==
Received: from DS7PR06CA0030.namprd06.prod.outlook.com (2603:10b6:8:54::22) by
 SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Tue, 1 Apr 2025 09:12:09 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::12) by DS7PR06CA0030.outlook.office365.com
 (2603:10b6:8:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Tue,
 1 Apr 2025 09:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 09:12:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Apr 2025
 02:11:51 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 1 Apr
 2025 02:11:51 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Tue, 1 Apr 2025 02:11:49 -0700
From: Wayne Chang <waynec@nvidia.com>
To: <waynec@nvidia.com>, <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
	<jckuo@nvidia.com>, <vkoul@kernel.org>, <kishon@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/1] phy: tegra: xusb: Use a bitmask for UTMI pad power state tracking
Date: Tue, 1 Apr 2025 17:11:43 +0800
Message-ID: <20250401091143.2621353-1-waynec@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 23326716-2b88-473f-5268-08dd70fd478b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XeNzAh/Of6yUUgJq78bgUOGC8Tzf3ssMZD8WULWz6yhjjlMsGXxWhwM5KJwk?=
 =?us-ascii?Q?3ZMf1f6UxXabFp3MTqLauNncFKsGwg1rgEbVa3eHwJiTPbADhLz7qbbrkGL2?=
 =?us-ascii?Q?F58kzgPkmEmi8nd2NuvqXsZH57xbl7iMYfpq0CyJVgyTacU9is8v1gGreFaG?=
 =?us-ascii?Q?yPo5G/+Hne1S+PEj2k7D1XSL+es+NNAoVostB1efEGCHI5wxRIFoc/kRGBIu?=
 =?us-ascii?Q?mGh/NdQ1S+WG6tbmZkdzMWNko6OyCa91LLbhJ6cPPqbV9fTcslKoMiHVB2So?=
 =?us-ascii?Q?QlZcFNfEcZ8sLZRysxtXSQ+5Q2AUO7iOjJqY4BfE5RoflcTrDnjS1slDNaVB?=
 =?us-ascii?Q?I1iNszDFoVwMufgp6EqHy3LkIdXLQv+Q+kxMbVdqj105GfornKrxU6AGM141?=
 =?us-ascii?Q?PRrXMKxgOFLDhrN6gByNt3zoZPUTAwJ6X4mtaUAIrNixuN8tC8JbPEZHqdwz?=
 =?us-ascii?Q?8Jo+4/2ebMKnJkuvjysPOhb7y6kwYPM8kJEPTEphccUXQc37egzIHgnbkVjn?=
 =?us-ascii?Q?/odspvFURMLQdhPJ/FuW9j2w03YiYRDE2Xc00JcTV4ZluCFk1NferAk5msT0?=
 =?us-ascii?Q?x94Pi4x/CZ07nAsQVgBMvH0M03AhF4Fk7zuBjEsoB2lkQw6ahlUThZYYHiCu?=
 =?us-ascii?Q?cqp1i8mDkyNsg53eV8CzY94N+BA+FvQzec2yX7iVvizvNMSjueAN+jC0M/Ti?=
 =?us-ascii?Q?/r/RmIcRm+Q001zZ5UiOCaqsJO4qq4mT0Uzh6K3LbxeEG64m+n1mK5h8Un2e?=
 =?us-ascii?Q?jrzVAyJ/Y9UhTdnm8LEYWc7G6mDcLGaLy5oz1BFXc5Sw+EKN41vyYLwUY3KL?=
 =?us-ascii?Q?1ZBqrQXfxlh4+MAO8thUXqgAJb8C2wHWy0oWMRO4PthUVuJQ8h+Tttw3BdKY?=
 =?us-ascii?Q?6oV87eQYUgzq3V1tOVJlu1w7ehnoK4IIIfYmj72+niqjAFAjuI2yj6KcSr3e?=
 =?us-ascii?Q?IeFhCGo/SZIeEErI6QgcfaDvcl/1/HOwJeG+naJ9YTBAFJ1+MTRO6F3ChNs3?=
 =?us-ascii?Q?YWnY3tlWtFUdZwRNFJysnsT2DZt+9kcGLpcK4WRaE71LxgVkAOpX51HM99qQ?=
 =?us-ascii?Q?SlUEpg4VN9GAvD5rqKuiY9P6xtCbyGtBdAoPARoa5QC6Zu21gSjZAdR/F2oc?=
 =?us-ascii?Q?secPAZGqml0NLVVYvxRthnTvAwi4OhgwT69d4khWpDNEx/xM6+Sa3e5cxwzu?=
 =?us-ascii?Q?qW+7zg75rD7Q+4ewuLdJFU89NlmP59Kt+LEaDGtWxH9qQDhSc0V6piApQNoV?=
 =?us-ascii?Q?8bDqXcVhiuRRUpjcQLLnzO3Cqbpoe1HpHBxfjoPjLciZjOVzI5T0WyAJJirr?=
 =?us-ascii?Q?6CmEuMa9QUfomhIqdrbKXcpI5mkm1/pOkuskznPKGsxHxMdKHpHR9y5ywgB5?=
 =?us-ascii?Q?uaImIzb1SqURejwQ22LZwST6nYb13SSQdhn5BUsql2jhKECYFwAI5nfrLEEl?=
 =?us-ascii?Q?rLUUdC/oerWnGo+LpXrjYLpu8vjw6XREaTIKb3P/bm1AHb0HJKeR818/PMq+?=
 =?us-ascii?Q?T2dZ5yk46Yp7gFU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 09:12:08.4265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23326716-2b88-473f-5268-08dd70fd478b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447

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
V1 -> V2: holding the padctl->lock to protect shared bitmask
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


