Return-Path: <stable+bounces-110145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 210BDA19036
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD197A1133
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA62211287;
	Wed, 22 Jan 2025 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J5aMQVGF"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396F18AE2;
	Wed, 22 Jan 2025 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737543661; cv=fail; b=CpLgDc/U8w/kobyeBAXPKXmDq8IkJT5Yrzl7wNRNhJrSRYxHvceVyz4QLsAFVvEU5fZI0syL+HIaM/yaEAGiK8HWfmK4Hl5ZzLjDeWjEVdNW4tIY9VZD8bwMSP5Kjj7cQmIyMjvVBN8dbMaZV9mALgdKo5iM/sg1Wx51qhBYcBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737543661; c=relaxed/simple;
	bh=UpMm5IymW1Wf+E5H4LlBueJOL7MokSWhu98sN4IEpDc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qncRApxaXOz2qJgAiqMugirQypIB79MCcNrWz8QL9pK4Isp+fVX3zBL5hq1Q/aOf/Ynz3kXtIqRpSNAyrWH6r0yd7zQZda0VSUNCH64Gds/+AjNLeN1HMUz5b/ClTjvTmWFpYDXtAzpyPs/qjlzyMSGDpVnikQfJfIVvpKdmNO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J5aMQVGF; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTPJXHcWQvHXjqXk8UzhkSYyhb8QybGOc30fcip+LFgdBoMP0xr88FMQ0Qg3LzD1+zyk0CVVcPtXc0UHjSyDjmbpDS6+4/zaL6J7/i4+xS9NRn5R3AWyA3G+HJwvlDa9B4GWLusIsYHYYcY8aSVP0gxOe29dUZbjhBKDSJ37/lET2D2Vm85K9phthdDOa7OGBnrlEvgd+NbpSq5PQArrvfineT5QUT1T3DAnFEV+5ITnu3+4jvSTZRCC/f+zp6J6cCuWh/xduTuCKQenY8tVIkcwmN9Wip8d+WfJTsduTieNJSkBkD3FTRbQiLW6mQgLy9pIFy9gDrpDOca/EnyW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYRCGQqe7z1BA4/Y0gzr8WvAv+UpOf/IxI5XfI6TszA=;
 b=P5Elt3InnIuxqfZjKC+zHwx3XlgvLWnWyI9o+zTtjmVj4SNfLsEAqsrZ0FEG660EglkShzdwqvre0EpHzUj2O1KcevrNzcr8KJrA+IT++VAFR1eKxKm4ywwtKCwzZhBqMM8NXy+KP2ReRASCX3NJhU7jRP3mTvZfd1cMKu5b09lmv3W6tqdDTRGKqikQD9JfePiilInmIFMZdxYwmv1IRBzJHS2mQlNy75L2wCj8RVOMwEwuwdG0bTkX8ozZp0Qe/dEt15QeaEQRDx+h5DohPRtTi4y6IPbnvsF0rmIF6HCjNBrxlnsyHXhff4MiRTucb2K0UBxFXB81qyQI8VtK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYRCGQqe7z1BA4/Y0gzr8WvAv+UpOf/IxI5XfI6TszA=;
 b=J5aMQVGFqbozdl8QP/bu423juSXGdiLwSNaFYQR2bpNTXy6deWfN9QyYLslJiJgx41eWnk5O15EjMdpG7J8DqXZJCb27mGe9Mfp3+PwBtujrth5ifT8it+/c9DFSzwUdunRMSLNkH7jL3SRY7WrpkOst48SRyhIVtKy2n3iN2SRUs/4bognOPQwgzP9VhRLl5Zf2zbyxNx/2OZakRG1fBg2X3JZm5BRhw+3y7VRTt4iZguswgUfteMRhPWave5UYd2XsVrkeH50TKoUKPQ9/plbAW8bYGL47klEFzVGiSo6JS5GkazfFEMv/q9uV6hyTPnyyGxBodpRA9+pLkysuVQ==
Received: from BN9PR03CA0654.namprd03.prod.outlook.com (2603:10b6:408:13b::29)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 11:00:54 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::1c) by BN9PR03CA0654.outlook.office365.com
 (2603:10b6:408:13b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Wed,
 22 Jan 2025 11:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 11:00:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 Jan
 2025 03:00:30 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 Jan
 2025 03:00:29 -0800
Received: from henryl-vm.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 22 Jan 2025 03:00:27 -0800
From: Henry Lin <henryl@nvidia.com>
To: JC Kuo <jckuo@nvidia.com>, Vinod Koul <vkoul@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Henry Lin <henryl@nvidia.com>
CC: <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, BH Hsieh <bhsieh@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] phy: tegra: xusb: reset VBUS & ID OVERRIDE
Date: Wed, 22 Jan 2025 18:59:43 +0800
Message-ID: <20250122105943.8057-1-henryl@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 2017e464-3346-43fa-3911-08dd3ad40a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nRkw5nc2IUp/SIu9VuExsFCdwmoYTaShJxBY+8duafJT51w9X75DmCoAxvKs?=
 =?us-ascii?Q?yRPHpSGtRphPsOdkZt+Yl4pxQZlTftXzPyqMVeDY8xEyOMEA9ikZr2b1U0Rj?=
 =?us-ascii?Q?nDkiah/DLxdMfNYmC7yDTw1OiokTFBksf1S4HxUm4xtn+Leu3G5F5j1Y0GAF?=
 =?us-ascii?Q?JA7g+fqtnbWmiVVeStq5DoYnAUZTA+eXvhapJ2co3C8C3BZw7yWfGe/TQJZz?=
 =?us-ascii?Q?gEEHThEbFHwzGonI/MPJhkW6pI9XJC+lHwV2CtX3LmjwK5rb41/E+CA2IfoO?=
 =?us-ascii?Q?E9a3L9QPJ3V2h8mi9Pu5KeG5ZyrMj1hx5CArvWYksz7LkfWEC0f6kZ9kXICG?=
 =?us-ascii?Q?80e8Az0/6wrkn3p/X0gtJ1BRHIMq1T0hPhLp8h/PpM3Gf3iPC/MeqeBTUm9a?=
 =?us-ascii?Q?sEzc999sU1wXSl5HRgmJaWErpUMtlLeorutZKGr6h8CJCJVL92Vg2P7mumvd?=
 =?us-ascii?Q?fnz/kDQetFiEZ78e1XCOXO9Q5qxhpJe5ziX/zQ7y37ioP4lnR1tmz8M5lj3E?=
 =?us-ascii?Q?QxXl9Dd7sXPf9NgOKexKy5ENiZuvnZ1dg/Fe9ire4vyBYZtNPtW7C5xARWAT?=
 =?us-ascii?Q?F42FM+dM65Dg/FPUb/oLo+yZRksaF6IUItF/hf7N/n+QqxnpqZiWosNc+aOk?=
 =?us-ascii?Q?r0NU4CHGgOrAX0IJ6MXexOonNGx2P5hDn+Iuzlj32If8kDYKLPclxEFxSJ6K?=
 =?us-ascii?Q?l4tJLDkYvyHRii3ZKuei9mXGZhxDY7CMCr/RkoyJPrQNAOOTmiXH85YhPqn2?=
 =?us-ascii?Q?AL3DeQWoxgtDEWjstXuQwlUHrD6tBS5SOjGSnpRPhvizwi+P7mCHnZ1jR2K6?=
 =?us-ascii?Q?k1P4j1xjzf2ZbyViySUyF9NW53dR9wqKffkTtSf3cX/m9IyzttRszD0hFDNG?=
 =?us-ascii?Q?Y7PcNZDAgipE3rK1+OaK9kLxAfjVMUSI3pyxBlFAw1I+rac3dCAn7y5c6g5q?=
 =?us-ascii?Q?dzqxCL97JtgRmsgEoR2VKl3MF0vl26lvgfypcdNbEKslVDj1Oc3KFIICLqRX?=
 =?us-ascii?Q?grkUaL5Rl0ARy45Fx7OkQdUt7IkFr0ieJRzA+ru2Vxln3Bnvn9rqmjOOTuF0?=
 =?us-ascii?Q?cR2oHj4BbQU3UoVivjR5XNNUbOYqoBz3N0rWeqKYjCRfxxCKzSKHTkQcz3Ps?=
 =?us-ascii?Q?a00kgDRD44XXw+dCqhL9fcXJcxOU5pSSY25sPD2SFfHYVkBZwLsO8Cfv+hSi?=
 =?us-ascii?Q?Su2pyIYpKbcsXAavuzkUDBxkz1IMoxC5YAjwoqmCD7iSTFg0LuABApU6U7Cl?=
 =?us-ascii?Q?+QoHAvIDZ1iEf4wAMQqXonK6BIm0PXHyjWARDAmNbQJavJ1boRynJfqQO6on?=
 =?us-ascii?Q?rhMOMVUVwjzYRul6BSoTuJFKNW9lOBhGFCoFY9dtsBQXy9gmn9OTh8bXjZl4?=
 =?us-ascii?Q?w6yVFkcR4zrDdTYY9n6OHu4VBIdEsGpHQqXbMjg442TqXtZ5jCRNdtWl/Etq?=
 =?us-ascii?Q?SKkOJSJXca3oTCrggVwnFk4PS82j5Zt9xc745fLo+n5fimEbLYrDrJli0zfE?=
 =?us-ascii?Q?2dBqokkc+LZ5PnE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 11:00:53.7182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2017e464-3346-43fa-3911-08dd3ad40a72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050

From: BH Hsieh <bhsieh@nvidia.com>

Observed VBUS_OVERRIDE & ID_OVERRIDE might be programmed
with unexpected value prior to XUSB PADCTL driver, this
could also occur in virtualization scenario.

For example, UEFI firmware programs ID_OVERRIDE=GROUNDED to set
a type-c port to host mode and keeps the value to kernel.
If the type-c port is connected a usb host, below errors can be
observed right after usb host mode driver gets probed. The errors
would keep until usb role class driver detects the type-c port
as device mode and notifies usb device mode driver to set both
ID_OVERRIDE and VBUS_OVERRIDE to correct value by XUSB PADCTL
driver.

[  173.765814] usb usb3-port2: Cannot enable. Maybe the USB cable is bad?
[  173.765837] usb usb3-port2: config error

Taking virtualization into account, asserting XUSB PADCTL
reset would break XUSB functions used by other guest OS,
hence only reset VBUS & ID OVERRIDE of the port in
utmi_phy_init.

Fixes: bbf711682cd5 ("phy: tegra: xusb: Add Tegra186 support")
Cc: stable@vger.kernel.org
Change-Id: Ic63058d4d49b4a1f8f9ab313196e20ad131cc591
Signed-off-by: BH Hsieh <bhsieh@nvidia.com>
Signed-off-by: Henry Lin <henryl@nvidia.com>
---
V1 -> V2: Only reset VBUS/ID OVERRIDE for otg/peripheral port

 drivers/phy/tegra/xusb-tegra186.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 0f60d5d1c167..fae6242aa730 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -928,6 +928,7 @@ static int tegra186_utmi_phy_init(struct phy *phy)
 	unsigned int index = lane->index;
 	struct device *dev = padctl->dev;
 	int err;
+	u32 reg;
 
 	port = tegra_xusb_find_usb2_port(padctl, index);
 	if (!port) {
@@ -935,6 +936,16 @@ static int tegra186_utmi_phy_init(struct phy *phy)
 		return -ENODEV;
 	}
 
+	if (port->mode == USB_DR_MODE_OTG ||
+	    port->mode == USB_DR_MODE_PERIPHERAL) {
+		/* reset VBUS&ID OVERRIDE */
+		reg = padctl_readl(padctl, USB2_VBUS_ID);
+		reg &= ~VBUS_OVERRIDE;
+		reg &= ~ID_OVERRIDE(~0);
+		reg |= ID_OVERRIDE_FLOATING;
+		padctl_writel(padctl, reg, USB2_VBUS_ID);
+	}
+
 	if (port->supply && port->mode == USB_DR_MODE_HOST) {
 		err = regulator_enable(port->supply);
 		if (err) {
-- 
2.17.1


