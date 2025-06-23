Return-Path: <stable+bounces-155308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3956AE3718
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 09:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635533B466B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 07:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53631F6667;
	Mon, 23 Jun 2025 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Its9StDN"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54E61E411C;
	Mon, 23 Jun 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664143; cv=fail; b=GpTeHRd3M870Q1vR3UthxPprvvE1cpH2zA2tEqX9MqYuwPKK/VrjHiymquWzpx5vsFPUtCC1FgxsxE08VYq4oPFGeqk4UQl0ge9wi0NXnDQsOKmGTo5KpAJOdjD9FPvZ39x7yAYbft0aGSZn/Eqz5/u9cEMAZt6DlbVO33H1El4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664143; c=relaxed/simple;
	bh=cCwC1lv+1uSyd551eTsWi2V09RxpzLidUZkgJxUC2eE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NoXxbUNnw6qdmDm+5EJWCZzPkRVdwdBBxdODuRwd6VOAG2CCkUb45V+9sjoFKGovC9NdqCpfl+DvLt7qxCymiXLYI/Trm60gQuCRtViaAh2vzHCjbqIZGQK6rpee2RK/u1OPaWaADV5/gUCCZeONuRlXkjV0t7tefEYIIcdA2nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Its9StDN; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgQQTojMDsfeUOeneUNlLOyTmr8VhJq3igfOOEcL8x7NXjJkx8MHM0HPYTceGXuy/uqpDgk5HKWJKd/yVeqF1LcRkwefdOFIbtXAycl/bs0Wx1zwRv2dQRxKWbX8Hx2ah2Tsp4zV3+l3qsdW7DGYlXwXhtQqg2g43XBjdxmnbkK59EUB+DTbLMwU6bXEukJdy9xVp9fJnqkQvn2JceF2zVqkFaUVjBaKnWZpgECpsUF6pZh3nwXulntJPNMx4JW/FkfPiQcXbC7X0PJIKT9+0/tAP+pMim9M1I9K1TGCOili9zo6ndzL79iofrLPFRAJbmWo9549Uc69341/Sn86Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC25BTX8iwq+9tyGinS7JH1mtkKDD1aSCFj4u6rm7Yk=;
 b=V+X6vVIl1WrA5toPt4c9u42Ni4xBZmscLI8qMDBdSXhrZh75YradUTMMTvW0v2Lr3OuOA3e5YPdPxEhQauAc1SWQs9AJNvX9Qt7uwK3qzrlaHVubEuL5EVfLHKSuVfDsFRCXHFZzPxKR622q4Wu46gU5UxsAJ46w4j5vXlh4lzvlnKKQFpMsWNCR2YFRDwXECVUuXPKkho3Ij2Ha9QQJRwaTcsN9i31IJX51UrZ+H/VlZyw2ShMdzNeUoiGoYQXtiJdkXWAsyV5qfHbVsnVp/Fh+kf+SBeMz7OL0WiO5DDALFdjnM6B+Uxn6buBzfWuf8LUkc876ukq0G7EosB/2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC25BTX8iwq+9tyGinS7JH1mtkKDD1aSCFj4u6rm7Yk=;
 b=Its9StDNaStAbs1oc3dhYGB5akbN9VnJSO/2wrRaJvvKl/NfjvCTk1tasmTub1yOEyap/A6HYo7+HFQMpAZeNneGqBjBHC5m8AVhEe+x8s+a/b3m5CHDAeb2geJj5Y0w4pv6hJLF1fd6BLMeD4BQdro81w+sWftWMKdJEeyl0K8=
Received: from SJ0PR13CA0208.namprd13.prod.outlook.com (2603:10b6:a03:2c3::33)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.38; Mon, 23 Jun
 2025 07:35:38 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::56) by SJ0PR13CA0208.outlook.office365.com
 (2603:10b6:a03:2c3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Mon,
 23 Jun 2025 07:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 07:35:37 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 02:35:34 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Raju Rangoju <Raju.Rangoju@amd.com>, <stable@vger.kernel.org>
Subject: [RESEND PATCH v5] usb: xhci: quirk for data loss in ISOC transfers
Date: Mon, 23 Jun 2025 13:05:18 +0530
Message-ID: <20250623073518.2264046-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0cc52c-b08d-49f0-a816-08ddb2288c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r8vFoKKYJwXRXHRktnW03tQy7t+yBj7muYG1A2RxBPggsMGHMDl50XecCZ8R?=
 =?us-ascii?Q?nlQeQjRMYjlOV/teocQW4Ysf70Myf4ZKHw+ZCeeag12PKGcY4mgvp04B+BM0?=
 =?us-ascii?Q?cXL7Mrt95pVwIPaYknmdrS/xUImlrhheH7YFiYpBqxKGHc1RbZF7Ufjvbh0+?=
 =?us-ascii?Q?2g6607ELqhR4gIKFBLZG5T9hW2J1D1cZJ21l/BRM8Ul/pPkwuGZ0KJWzFWp3?=
 =?us-ascii?Q?25mlFm4w7ZOn+VuSZWHbiowDVtTW0E4ChemYBGCvsIZjgJ1whqzREqFBv3c+?=
 =?us-ascii?Q?KmZL7ik2kaHHAojMy7V7zvtRCmJum71tGs49gI4QBX7JpGpug3PiUYZL3G/j?=
 =?us-ascii?Q?FYC0xu4ATMARyst7SnJ8uPbR6sH1a9bVi4uTLDgRYFof0KsGctYc3nnP5P9q?=
 =?us-ascii?Q?a6K7TKcfquHTxQhXkldkHpET5tUOHfDB7l7QyB/XzMbNeYAbwkUsLs8tCdq/?=
 =?us-ascii?Q?A8UtZOqJpARdEc0HVCX4ZnjpE9udqiXNXjY5+GL53R0+ggvIFq+O+tYWnUIe?=
 =?us-ascii?Q?vfi8kA6G7X9Go/ScWdpUD+pd3pFeVSvs+jCBS1KGZldLdX7qIlXNJHKda8sl?=
 =?us-ascii?Q?HKMUBKz2GiR9PkzV3jzpWNvcBZUUbeBFKZYz3K6u3z+TJP17B1rF0b5iyQqx?=
 =?us-ascii?Q?qlT3fNr4c5/mxjyJlp3HRMXf4zXdFcbOQS4m0Pcfts+/kpMNrI8VXUFOqBia?=
 =?us-ascii?Q?SDwTyawp8I+OL/tCZlfmdRoWrrPxnxNwh2Bg3ZWxYHT/lculSldjbgAbc1Jd?=
 =?us-ascii?Q?H/9eVYhw9IjFm4D7LxpeeJc9q6sl3YOskK+fX2nKNUrx9wN/FOwV6fvhzj3z?=
 =?us-ascii?Q?wDIoJXuAPYh4bPQoTq4he8DuRrLPQKBcKMbOm9B2YxFEFqw75AToNDFuIRXG?=
 =?us-ascii?Q?eeHbNZPLTef7ezJnNllPy8f8o501/q/8Sqo4kg5naER6YLNU6Y5TZnakkzQ/?=
 =?us-ascii?Q?1aHkW8qu69kUVkOvLZEEBMs2SLEg11LVNasB0F4gHeEQH+dqhEvq3G2rlR6r?=
 =?us-ascii?Q?0KZLxfvXHenoV3HeoUwlufe86pg4SuK7356g7UiwddsBOAX41otLZj9VrtWM?=
 =?us-ascii?Q?BWSIg+b35FAiYnG51H3zwVHRQfcMcb4qsMTome+HbUDyfpKvP80uE31wJfM5?=
 =?us-ascii?Q?oOARDHzYoBYSDDC1A4el/A+2Sw9jNDQOeOxoC4guuZhbw8nRI3tg81odmWIe?=
 =?us-ascii?Q?RSaIcIcQ35dRGKIE7vY5gFDDgp+4L346DS5T/737N/16ZB4Ykx2KO36OD+6o?=
 =?us-ascii?Q?Ijw+B4Im669qFQzLNfiGrzwN/xB+jk3jZAB2OXq/U/59Wphm8VOiiLO+zx1j?=
 =?us-ascii?Q?xjeBbNKzjhOMMUj5shv9x7NDiwJE7pOpfPShYlvYSwZKLy2dx1G3DcwwbP7f?=
 =?us-ascii?Q?HuY1Di58ie+fVM7Dtb5Q66DeS6smoK8dkwXrCa4AV3/exvOsXfa+kiG+6nwu?=
 =?us-ascii?Q?urmvIp6f2l5L0rgNp59Cs4KhoRwRDw2iFpofLb3NWL5zVYpG8HBVDdOf2J5C?=
 =?us-ascii?Q?ENuFie6kRh33ncksB36y6n4XnXgF26Vc22P1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 07:35:37.5894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0cc52c-b08d-49f0-a816-08ddb2288c35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292

During the High-Speed Isochronous Audio transfers, xHCI
controller on certain AMD platforms experiences momentary data
loss. This results in Missed Service Errors (MSE) being
generated by the xHCI.

The root cause of the MSE is attributed to the ISOC OUT endpoint
being omitted from scheduling. This can happen when an IN
endpoint with a 64ms service interval either is pre-scheduled
prior to the ISOC OUT endpoint or the interval of the ISOC OUT
endpoint is shorter than that of the IN endpoint. Consequently,
the OUT service is neglected when an IN endpoint with a service
interval exceeding 32ms is scheduled concurrently (every 64ms in
this scenario).

This issue is particularly seen on certain older AMD platforms.
To mitigate this problem, it is recommended to adjust the service
interval of the IN endpoint to not exceed 32ms (interval 8). This
adjustment ensures that the OUT endpoint will not be bypassed,
even if a smaller interval value is utilized.

Cc: stable@vger.kernel.org
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v4:
 - reword the commit message.
 - handle the potential corner case with ISOC IN ep with 64ms ESIT

Changes since v3:
 - Bump up the enum number XHCI_LIMIT_ENDPOINT_INTERVAL_9

Changes since v2:
 - added stable tag to backport to all stable kernels

Changes since v1:
 - replaced hex values with pci device names
 - corrected the commit message
---
 drivers/usb/host/xhci-mem.c |  4 ++++
 drivers/usb/host/xhci-pci.c | 25 +++++++++++++++++++++++++
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 30 insertions(+)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index bd745a0f2f78..6680afa4f596 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1449,6 +1449,10 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 	/* Periodic endpoint bInterval limit quirk */
 	if (usb_endpoint_xfer_int(&ep->desc) ||
 	    usb_endpoint_xfer_isoc(&ep->desc)) {
+		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_9) &&
+		    interval >= 9) {
+			interval = 8;
+		}
 		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_7) &&
 		    udev->speed >= USB_SPEED_HIGH &&
 		    interval >= 7) {
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 0c481cbc8f08..00fac8b233d2 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -71,12 +71,22 @@
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI		0x15ec
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI		0x15f0
 
+#define PCI_DEVICE_ID_AMD_ARIEL_TYPEC_XHCI		0x13ed
+#define PCI_DEVICE_ID_AMD_ARIEL_TYPEA_XHCI		0x13ee
+#define PCI_DEVICE_ID_AMD_STARSHIP_XHCI			0x148c
+#define PCI_DEVICE_ID_AMD_FIREFLIGHT_15D4_XHCI		0x15d4
+#define PCI_DEVICE_ID_AMD_FIREFLIGHT_15D5_XHCI		0x15d5
+#define PCI_DEVICE_ID_AMD_RAVEN_15E0_XHCI		0x15e0
+#define PCI_DEVICE_ID_AMD_RAVEN_15E1_XHCI		0x15e1
+#define PCI_DEVICE_ID_AMD_RAVEN2_XHCI			0x15e5
 #define PCI_DEVICE_ID_AMD_RENOIR_XHCI			0x1639
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
 
+#define PCI_DEVICE_ID_ATI_NAVI10_7316_XHCI		0x7316
+
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
 #define PCI_DEVICE_ID_ASMEDIA_1142_XHCI			0x1242
@@ -280,6 +290,21 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_NEC)
 		xhci->quirks |= XHCI_NEC_HOST;
 
+	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
+	    (pdev->device == PCI_DEVICE_ID_AMD_ARIEL_TYPEC_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_ARIEL_TYPEA_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_STARSHIP_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_FIREFLIGHT_15D4_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_FIREFLIGHT_15D5_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_RAVEN_15E0_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_RAVEN_15E1_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_RAVEN2_XHCI))
+		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_9;
+
+	if (pdev->vendor == PCI_VENDOR_ID_ATI &&
+	    pdev->device == PCI_DEVICE_ID_ATI_NAVI10_7316_XHCI)
+		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_9;
+
 	if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version == 0x96)
 		xhci->quirks |= XHCI_AMD_0x96_HOST;
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 49887a303e43..ef7eaabc12fd 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1643,6 +1643,7 @@ struct xhci_hcd {
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
 #define XHCI_ETRON_HOST	BIT_ULL(49)
+#define XHCI_LIMIT_ENDPOINT_INTERVAL_9 BIT_ULL(50)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.34.1


