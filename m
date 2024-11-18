Return-Path: <stable+bounces-93803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E77E9D140C
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 16:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AB11F22150
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7451AF0DE;
	Mon, 18 Nov 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KDt8Icr1"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C91AF0A3;
	Mon, 18 Nov 2024 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942519; cv=fail; b=XDYyMH2+j4JSpFNT0S/1LN1lzIkaGrm90QGJ2g9Cik258Qc/VExbP+97tikJv/qop1wqeThEQ70U77TwnANs7rQlfUMTMCt7j/67cSfelGTER+OHzsBtjWsqHvJjw0nAfGvn/B6Yi0hDxdKTJqWGOuQHjSAgE4c1DE6GM7WTyy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942519; c=relaxed/simple;
	bh=Zkx0nzMDUxUoFmYetv+U1Ux2W/ySWBGNOQ58jhtn0+w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CVZoIPMNyl82CPZRjH5YxsAmg0EVGc8EiGL510vuU2tt6OY3TEssU3vmvfyHRy3adDB3vICWplK1Qsi1EepEkW4uVBRwWwj7CXdMKspzgUMQtzFwkEIS+yKymmyVdNPv6drQebmMZXmg3FvMZ3oNMJDXiSid4c//tyDjc9zvB1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KDt8Icr1; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4o48sTMClG3uiB8X+A5XnimMgqIfmmbI+jjSgFzvwnaNo7IH1xGIdoR62xHMDl9s7ODh6thIi4eUfg2JwKrUsN+TKCo9EergMP1RdRzmI4DS66NtfEn9V78rdRBgZq+S9QzUZMsmjGAYXrhncVWC0hZWuToV5cHS4cdbQUXmYphovOVMnU8ZX5Za3jQ/zc3+XmVk0TkfspqVkaqQAMlR8kieyLRM3B/zuhcu8L7sgar064mDxlH9VUqXsj4xUDx9iQK077TE9cEaKzOLodhaHcwKPK4KGO3gU1tIrYXvI9a1Gg3cXiRpAU+CPPbyuJ42W4dVdo12b6KxN+h5q8HiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqX/+YS8HQkrgSLStWGErKa2bZe5H7aZiEUmfPnTz0o=;
 b=p3BjVIcyWy8IRd5p2Egh6OIyTWABe9TZxOaLagRa6nkY1LJ9m39j/MOzWvOud2PrdN+BffG1uaSWYS6b5P2wt4ORcWjsstEZ6Rw6/QMHVAM8KaaZwiRL7dFOGb2R0YeN/wzUDdYWANqLSknK4hGQP6hNWC5CLPUf7tAuxRCG32G2c5K8Kb9o0Ll9oSkxfbA/oP3BZt2foPHvSC91rE1HK7gEeqTEVJ6UbEDkuTalIlSqzq9ZekfM8l1n4yqi/jzla2j/wyue/Vupo8EeftC2oYmzM5LeDE2d0eCeIrLDTarMt6jw5fzvzl4LMJ/o9UAkfQVMrEPqVhdgQ5WeYIhroQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqX/+YS8HQkrgSLStWGErKa2bZe5H7aZiEUmfPnTz0o=;
 b=KDt8Icr12nonU1LSzjLT9+q287xNWa9IFUCo86qd18SeOCKAJhGQDbfNJh9563JUdS32syfolzuz1eqMlIY3IKNIe9eRmLJiaiMLkZfhqw2f7VNt24ATutNFaiErjqHHorwzujxeZirRJh7ar5CqPOIcCJ1i+XEK+BSAkAsIy/c=
Received: from SA9PR13CA0161.namprd13.prod.outlook.com (2603:10b6:806:28::16)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Mon, 18 Nov
 2024 15:08:33 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::bf) by SA9PR13CA0161.outlook.office365.com
 (2603:10b6:806:28::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.12 via Frontend
 Transport; Mon, 18 Nov 2024 15:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 15:08:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 09:08:28 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 09:08:25 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>, <robert.hancock@calian.com>
CC: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Neal Frager
	<neal.frager@amd.com>, <stable@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH v2] usb: dwc3: xilinx: make sure pipe clock is deselected in usb2 only mode
Date: Mon, 18 Nov 2024 20:38:11 +0530
Message-ID: <1731942491-1992368-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 640baccf-39e5-4184-66da-08dd07e2dcc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J8E7SIFkWV31nFHa8l/AurmIl3dvFa4qrJLXnC3/tzungbJtRgS09MV3yDE3?=
 =?us-ascii?Q?x/uoR2IqHhKmFCGxOKNe9R1ZL7HIsGRSw3PWJFQMX5gv6aX34aEyyAbKjizl?=
 =?us-ascii?Q?7xQLT7pIxEOR/TQ/HYGyY0Tr2dvNHP83435GFjqv+KaJ0OvY2tRTEkUVkY+W?=
 =?us-ascii?Q?w3wfBMVndoiIAXkvC75J2Wf2MaOQ1n3cuAEmXdaghw67eN/1bwEZGpHLsOjb?=
 =?us-ascii?Q?XXQBnnReHpYYlijcz9KPb7DjUOjFRx8uD1cSySSJg5cRM5+3FUJcKpry/FiX?=
 =?us-ascii?Q?/hEOe2FKLUvNhZjGCjoNyOV1PfV7BfxJC5QKUEEUllTZO3sw3voBmy7EC03g?=
 =?us-ascii?Q?/Qv0BlgOBhYGwgfkva4wGRnij9vcRSIEVxoTz2DSLUKHPLOumH8qaXwv2iPj?=
 =?us-ascii?Q?HVYRZtRth4VXfe4HuqNsAud5dJ5d6U+eSJ3whKSPE/lbYb/YKfceVsJ3gFWw?=
 =?us-ascii?Q?WrGeNHIupbYDofPItXJBlMCb92+ZdkwV6wBhHZUJ3XkHNJIejEZOAEziSRF6?=
 =?us-ascii?Q?S48B/WRx2dFJzoZAfxgKW7Dptzue0uwYlMrcAKTw2UzuRdRB8MXt7t61uOC5?=
 =?us-ascii?Q?9+FRdXwzy7szmsv5C4rdqX7lyzt+RXZpUdhJwlSqDIeJemJKwMvwp4ZQ9L3+?=
 =?us-ascii?Q?bQoJEL7dGQNK/MOnAuQM1JQnRmTIQV+4iNVrdGDFAzFMc47Uluycso+jr3xs?=
 =?us-ascii?Q?7V7aRG61lmSK04RdXhFbJmiOzCveEvK3YXTZH/fkDxKMsphAQy9oUOMI8x6t?=
 =?us-ascii?Q?UnteN00yPUP1iqlUB9v19rfYwvfN1x4i8YPonfyJRQXZTxrxfN2UC/u5lcbL?=
 =?us-ascii?Q?hZrgEH5v8B8JJys327k4t5lP82kZsuXMDMPFPfYADP8OldmUVlB1kWQpH4jR?=
 =?us-ascii?Q?MYZ3aQ0f7JUZ/ovtn0wmca7rjGsp4ErlgHWsqoNoL69A8c7jhZUv/3XUOgLc?=
 =?us-ascii?Q?na78Pf1CK3fRu3K4pOAfrSgVt1wBJ9nRB7xvSD9DGVcywhbgNQaXuWHKFUep?=
 =?us-ascii?Q?bu8G8AUrQxFjN8Ut0TnCY3cOOkd0U+3P8bUmNcqy0Z5FZrpJvrD8/WHgB1ee?=
 =?us-ascii?Q?IaRLScGsG+LKkd5P4GMae93yagfvesVtSRf5IUY7SjhXLL1pQs6eDwVmR5nY?=
 =?us-ascii?Q?LXQKkCox+I+TOnDh5svewy0O2KkY4te4Gr4EYG33qSYxzR6zPKpWymv4lq30?=
 =?us-ascii?Q?NzNVamQESBA50XxXJONNzYRM12lYPbM8B/SXR2YgCU3b2MWzHaxTpm+V8CA6?=
 =?us-ascii?Q?I3hVqcw7uYqRPIv9qXMYQuYcDoHKoCH34+bfNqOHAf+Fxy3V96EV+j+Cku7T?=
 =?us-ascii?Q?o5Hx2QueScUMDZauIXkJXlHxznrL8fqXjanYjlqcCBxjV7bl8tPI4gDJqF44?=
 =?us-ascii?Q?p0sp22vODTMhMhmtY1Idokl171cZABeX1Rt5gmL2jIdzwjUUJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 15:08:30.3403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640baccf-39e5-4184-66da-08dd07e2dcc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968

From: Neal Frager <neal.frager@amd.com>

When the USB3 PHY is not defined in the Linux device tree, there could
still be a case where there is a USB3 PHY is active on the board and
enabled by the first stage bootloader.  If serdes clock is being used
then the USB will fail to enumerate devices in 2.0 only mode.

To solve this, make sure that the PIPE clock is deselected whenever the
USB3 PHY is not defined and guarantees that the USB2 only mode will work
in all cases.

Fixes: 9678f3361afc ("usb: dwc3: xilinx: Skip resets and USB3 register settings for USB2.0 mode")
Cc: stable@vger.kernel.org
Signed-off-by: Neal Frager <neal.frager@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:
- Add stable@vger.kernel.org in CC.
---
 drivers/usb/dwc3/dwc3-xilinx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index e3738e1610db..a33a42ba0249 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -121,8 +121,11 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	 * in use but the usb3-phy entry is missing from the device tree.
 	 * Therefore, skip these operations in this case.
 	 */
-	if (!priv_data->usb3_phy)
+	if (!priv_data->usb3_phy) {
+		/* Deselect the PIPE Clock Select bit in FPD PIPE Clock register */
+		writel(PIPE_CLK_DESELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
 		goto skip_usb3_phy;
+	}
 
 	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
 	if (IS_ERR(crst)) {

base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
-- 
2.34.1


