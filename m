Return-Path: <stable+bounces-127287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A760A7746C
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 08:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD217A2EBE
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 06:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09C51DFE00;
	Tue,  1 Apr 2025 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yzk+f0+d"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CBA131E2D;
	Tue,  1 Apr 2025 06:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743488324; cv=fail; b=lNPgz59pGYsovXPoQp+Rr/aBUqeLRlNTmLyMhdIqgN0HvzU8SfDvDCUkI/J3o2JcX/ezXLus0d44pZQeuWo4Jj+Bs03TXdeRQwJ3leNkVYePJrFp2xAB9FzZbs5/L8qVZkhndPE0eUBwlEYWUNgE8u0voxNspkPcRhNwleOpW1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743488324; c=relaxed/simple;
	bh=kOsuPwImtADFq5cyJawsuvh/S1YCn9S1sNyKcnDm2WU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dzmyr5wYpZWevy6q+qIuO/lpMGwPLLCkBRiErRPqgo1uGZTq4wjeofEZh8aQAGVd3V91tMc21q8ZUo4kZZLVunidN9mw+ok15wjK+JNIJxBoQygLK0dCp0mut5aKWH0AvQcY1BC51RQJrXrhkStWYl71PFm1AV21E1IY8BsfitE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yzk+f0+d; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIaEljjncOb+aaScWDFViZCcqM/Y8Qb7JQA6V9tccDl1el1o01zoDABfwP5jFfkMKfF64lqnikAuLvNMZx8wPHbE0N+hHa9/6v9FcDQBTvmgykN3rraEzi3GD40RTNBLxqqphleuyxKyoL/eA8s4JasPVTj5IlgaQxcOlJFmedjSREYrd4qyFWPoejnqA8k50+qIzBLb4iDFBClU+ar0g+MEK5AgoUnWmjBLqME61TpOQVyGv1y1YkCTqMOvXv0Hox8Bd7QLQ0kDvwR5Ctd4U2YEJi1RAfGd5/uNPXCMYi3WlwIn8V+7sTzoetFw+uzVN4w3RNy1fluMF6foWQQFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szNTX3sbHWxH5aNq363FPKpROTDLOw/3T8YRVfaAf5I=;
 b=ArtjOWXhhx2B9YJwoaX3HUmyuOJXyQBmqVxQ2Fl0DNh5I8TXGhieBIfC4qSvNV2Tax4UobWQg4yJa+Lc2z7nyuhdVCycYO2uxQYtPK2YW6hTZxedsbmS/H4GRD2n6ENPKsmPQxxQGTfLHO+9LcXnue3KcUnFsakvjF3FGgytJGL6sl1FruDlQmn3/KDCNze/A+2n7OvYsaMd7v3GQdj2uQcIbdoZrPkuq+5iFob6zlAL5/4tN13ex8k1WZ9Dv52HK28YT9ZwLkhT3bqLJ8KxQ949xE1HN+M+TFP7gqCMlptw4Zjm4543RJBqzM3CI0Dkyts3nL5H1USif1r742IDeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szNTX3sbHWxH5aNq363FPKpROTDLOw/3T8YRVfaAf5I=;
 b=yzk+f0+dM2m7CERj43/6G1otPKCPGWuBZpe3ykEty+nOVZeOwSOOxzrUQc2IwErt+hBQMkqAnT7JogM8yPRay25OW9nkmo6Cp7cK2GzxKoYcGWjkCanop1duLwOd68vj68YXvK2l2GVyuLh07hVwcaauHMsgtIeMrvXJLyXJptg=
Received: from SJ0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:a03:333::27)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Tue, 1 Apr
 2025 06:18:38 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::32) by SJ0PR03CA0112.outlook.office365.com
 (2603:10b6:a03:333::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.52 via Frontend Transport; Tue,
 1 Apr 2025 06:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 06:18:38 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 01:18:35 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <mathias.nyman@intel.com>, <michal.pecio@gmail.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v5] usb: xhci: quirk for data loss in ISOC transfers
Date: Tue, 1 Apr 2025 11:47:25 +0530
Message-ID: <20250401061725.3039278-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: b16ef74a-0fad-4e0e-8d62-08dd70e50acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sBNBCkM1YxQnpc2KMLiHkvueOvP/Ed4G+HYBfAPBC3mEDSzY/ciRXfyF4TJe?=
 =?us-ascii?Q?t2H+K/cVcc2UKjHDY9meEEFZVXNlB+u6Y8K936iBp/YzX/umPBLJIImwteht?=
 =?us-ascii?Q?M+CtO9BwzvvmO2BZt/mLhx7g4G+1Ci0sVA1IIZU2wwcYKLOpQ7QKQcui6USC?=
 =?us-ascii?Q?O2o7j8YxO7OLsk1uN2y1pAqWVgFZTOL8LVxfrv3xpa3rmTfOAr/x6gEx4wdm?=
 =?us-ascii?Q?H7wD440Tjiz2BJL4SKDY+BsYAtnuTHzIgWQP8s33ydpx2r1Zb+AS4IHMoFWJ?=
 =?us-ascii?Q?iAdauCx8KMtPPLqmbAWLGDkAuRJNFzHMojhRVoaDtO+x4rai1qc6DjLiKC9O?=
 =?us-ascii?Q?5r5Z9l8QTz91P7AobgRBS+K9M7xqRIQaWR5nBoLn3Rffz0uN875aAN5eaGQ6?=
 =?us-ascii?Q?OlAm0U0IB5ju6F/yaQwvfGye/uD/2jgKY9ONygdkOwjV3EOhgVsoixVUWaUx?=
 =?us-ascii?Q?p66DKz7pDol/6kblS3E7w3SpS1e1tJB3TuuygFvo5pnGy4e2O8Jf7IOgWFQM?=
 =?us-ascii?Q?WD31Grvo9gLf1+uJoasTSkyFX0NErREUzMv144DtPSbeZHvFClxzaQTdfv/y?=
 =?us-ascii?Q?wjlE+XflJV1T44tUV6yAi1DD3F7z8z6Xqy2/FwwdwpC4oPkhHfJTS+11YVeE?=
 =?us-ascii?Q?853PEu2jBsJtNhLcaonCv8Pp7uhBFU0mIF1MtqGHhDRuVOFVV2c52RpzqwXO?=
 =?us-ascii?Q?jfo/Zh7E9C99gCy+aZUU15/O3O+V2h+30qCPYJvU8wkFShDtbu8BdiOhYNX7?=
 =?us-ascii?Q?otn0u5qy5tjq1k3uS5xt4See/0wfbiYzEfzAmHyIyzv5oxQIoUwRVUySMM+5?=
 =?us-ascii?Q?vUgpOMrguaUJlIno7eyfR+3pTjOost62W7EWgse1gkf8yxVOpfgb3BC5Q+Op?=
 =?us-ascii?Q?csArMtX/UYK5iuQ1cZT9IAJcqEvQaISEeoDOnorTPsi6unUE7FLc8JqgmIUL?=
 =?us-ascii?Q?/fVGgUbw0vKFBYo4FE3LPRSJDNVnzzYK69+mAbin2kOXaBhoWUutldut0utL?=
 =?us-ascii?Q?mQpczA16U3dKvBKBPAi8h0FLtkl7Syppd6yn1dbcLV7cz0FoJ3xaGM1onb3m?=
 =?us-ascii?Q?nR7xmAeFVw8YiZKVc1gfPQ3dVnxTZnU/mS0GoYKNWvWtsyyHOMDG06Y92lrA?=
 =?us-ascii?Q?6O0/OwK4YfvH5yiYlIpP82rrhlG4vQVHdcFQ2sQEVl/rpKvVPV68+XK2I3LP?=
 =?us-ascii?Q?LPXr798nOc4LTHI7pIFlH7Jwn8VgIbzZTEbBGcpAFwkHX/r7WxHt3sVMhWfQ?=
 =?us-ascii?Q?R6rDcFzqBN89uVtoagfEOirV0OM+9JZo5/0krDsrHTPQzPOcYQLZ0W3rZxP2?=
 =?us-ascii?Q?3nTKSOsBcjJNY3FwAshb9V1yV1TIv1gBq+r7j36WO/7MRZQl4gNGHxzpCCgU?=
 =?us-ascii?Q?9GUheip5R9+heweL1fzmdHRErHSFWpDjgvHgUtZIQWX2tKRGRu3SQsq90rak?=
 =?us-ascii?Q?6Ex6O4wgtcL+bqcfzn2Xn71ZabwbxkGz55lkkoXV2VlEidIiB5QcEa/IIQzf?=
 =?us-ascii?Q?e9CWndYK0oPP1no=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 06:18:38.6137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b16ef74a-0fad-4e0e-8d62-08dd70e50acd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763

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
index fdf0c1008225..364b5a9e7c3e 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1420,6 +1420,10 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
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
index 54460d11f7ee..6c15b4158f06 100644
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
index 779b01dee068..6de1164e2e53 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1637,6 +1637,7 @@ struct xhci_hcd {
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
 #define XHCI_ETRON_HOST	BIT_ULL(49)
+#define XHCI_LIMIT_ENDPOINT_INTERVAL_9 BIT_ULL(50)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.34.1


