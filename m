Return-Path: <stable+bounces-110862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C7EA1D5C2
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 13:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D433A39D3
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6541FECBA;
	Mon, 27 Jan 2025 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S5FY3R3M"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498B0C2D1;
	Mon, 27 Jan 2025 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737979627; cv=fail; b=SOf6tKVMh4Cy//EERu31OQwOiWCUQaCKlJvlx+lBRe0rX4kADFMdDdiAYQcBJ63k8RHkvwXcl6On88rAibyNAAkRZSC5cRzfFrkxjvxQLd8EDn8NcRzEiQ17LncOqsiffpjUkBn60OWb3LZ/aQFWnxaIFH8gMny5u2qidEfDnoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737979627; c=relaxed/simple;
	bh=kXTKu7v8+TLXEPhge2I4bp3nMpxAyMH6wWqQoo13R80=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fkW6Zf++1qoOjuOv7pMQQlRh/mnlckLoEzDiHqJgJwJ/oq8znKaokp1J+CsMUvFFmj7oE4iCZ6DSOs8d8ah2QLmkEBaHviZ3kCqVHIv3WQGAVH4ujl51/UnUMWnD6c+rjAq7q+8CILBoBaeCfKptrCrYGWvFcgVWNXxjxNq4T6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S5FY3R3M; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lm9SH8iyZYdGBmhjfzFJ/fYpmUKKcoBhp5W823wYo9I/IyEek1G9oKfkCmug1g9binRnSUf+IkCPa1akwKe3IJJDNdyj+sXxA428oWA97o1HlDYRahaMQvwxYFhEUmapegCAbbGnVfKdMP4eP2EOI0k78pS3z91K0rbLpO0IRS4YEz9Hk8fVM4TsfNRIhEdGo8QVlGL/KfsSS3iR9fHpvCN8kEQtBtCnOhx2imtIcJGSZoMvUciWSac5CSKMScQo9L4smVY/vfDW8VC9l26olxMcMyAEndtBVAr9Q51odxTXGajVBfTLNSkp4Gdf+OcWtowqbeH70U80T0RlbUZqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTplnKXt5TouAwNQULi25C6XWPEt494nMOWh84OZtqg=;
 b=iUVDQMp/M1U1rR+2eQgJVZjr/U3VP2M4CeJTv4IAdilKGUpF3KEJJ7Lk+tcYmsBnRb0kUksuFiZFA2H/AUVTghYcX81jhxvEuCDrqZteIqnZ7IBec12/rMfxq/7Ll29BbIRZ64gyG3ZfKGy1sHBdqNz70uqZllxNe5lfYYA2JbaMKCFYNxogM2RrpLZVkyjI/NJitecrP+wsyYj71KRLZuPwRiuegHMiOdiv3+042sAjYK/eWDDow9JNuBquGVmBNQoR5lNBMRUnNSnP6Hm54K8vhzAhPI3ScNTW6E3rrN4Rfnv/qJp5zfdY5LrsIl/oW3BO001oJra6KvHowou+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTplnKXt5TouAwNQULi25C6XWPEt494nMOWh84OZtqg=;
 b=S5FY3R3MPKGoNaj2vI0DK2RR9ZaE/14OB6GAeBLV8Kj+6N1kAgDHtWyHia16gjHcwENxmobA5kuCnkVz7KXsRG7ZQTwGPkiH6LYwU/jsGe+0xe4QGa376JrS2hNZePaBdPRpo1jwuMae4uRgp9LorZ8ItCBYDeStnbFh/+yLXvE=
Received: from BL1PR13CA0388.namprd13.prod.outlook.com (2603:10b6:208:2c0::33)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 12:07:01 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:2c0:cafe::fb) by BL1PR13CA0388.outlook.office365.com
 (2603:10b6:208:2c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.13 via Frontend Transport; Mon,
 27 Jan 2025 12:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 27 Jan 2025 12:07:00 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Jan
 2025 06:06:58 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
	<Raju.Rangoju@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v4] usb: xhci: quirk for data loss in ISOC transfers
Date: Mon, 27 Jan 2025 17:36:31 +0530
Message-ID: <20250127120631.799287-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f06481-f563-4470-48c3-08dd3ecb1ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2YuK1SYjuqe6as6nBu6o9fWleyRdRw6IfhN8MdQuzb5CpPGB/j7a07o4pkEN?=
 =?us-ascii?Q?rkkzCIRW7qCyX3taMCHgu2uqzoenLiYpTEHSa+GREMLcMil68azobHYrJEh6?=
 =?us-ascii?Q?CKJqBGERJ6n9ZWy0tmAB3UP7Daq1WPEKKV6SCNgqxtohG9rHePSU/TMA5C6p?=
 =?us-ascii?Q?CMFNmeGalBl0HSNVYiXlbZbdgQy6kd4ImH5OIxoK7YO4/1/sEidTUoeujVIg?=
 =?us-ascii?Q?c+eRdZdyDErmJj1mt9Cm+vQIcnjJVV/nERIz+nxPxiQ82CF+jAq4ElXvSQM3?=
 =?us-ascii?Q?aEf3kcp6+btRHnmbl4xBZMJhprtOaTDq1Kf7tZmfpslXJvRRnqCG8v452LY2?=
 =?us-ascii?Q?6hTjlOOU7ETneOsd8+CP0C+HIh6rqJXJM77Q8WzD4At5ZzLtdcy6veRMC+xp?=
 =?us-ascii?Q?TJXC/ZKCVBHQS9dVbt95JefAPrp2/MSCs8uhJjwdeKHBiYmgjIEOM19Gxt00?=
 =?us-ascii?Q?DEh7+h4qSS7RV6Z1mBLK13iSi6szC4FWpGqEWrFnR3cnembUEZQNKQbd6fm1?=
 =?us-ascii?Q?r1xum+oqlYOGRdXS1THO1g1sNMBK92przi3xm7nrfRKWJqQAZ738Bj6kVkco?=
 =?us-ascii?Q?54TogkzLLNGAhrUeTmRZFp5kRXn5vnYmMeU1aRuh6+qmN8PvjO41ekjleebf?=
 =?us-ascii?Q?LBIFODdYMMaMKvbYraJZj8lGRtftXPCPszq6UGE/Y+pYNwJIB6TTS2SAqzLP?=
 =?us-ascii?Q?MHqk9GKi7Jom70/b6CYDVmKQ6gAH2fpzaRfYrpNlKku2H2aoUOHKaYlHtAX6?=
 =?us-ascii?Q?PFvToEYJAsGg8MJ4g9VNYA6yNPjChmnsFv67gD/9zBhLNbEh8AhD4PVhFc6k?=
 =?us-ascii?Q?mRGJ9dSY7IUSwEq0xo16b9Cj3g9qneeeJ3brESupRgje/XaBxz2VDwxLIAkN?=
 =?us-ascii?Q?KG0YYDwMZIbAkedXSC57kiZVPB+8oWiC5UzB6kOoykogmL4n3/iDr1rt3u6w?=
 =?us-ascii?Q?mSzvFcY/pFCjfuqpWZJK9F2Q814MCwUuAnqStffxWEHuwvcbNKdWnRJHBhq1?=
 =?us-ascii?Q?VikYXWzNwPBByqv5TVQR74D3GO630YLc3rqUrrmCs8iXXzbvNpUWLxnT4PV9?=
 =?us-ascii?Q?3UOVuyDnbwXnri1HBtbE4XkrQhGqd4+YDI4Ytm5cEcUnf6kQ1u5YPWKZyYJ+?=
 =?us-ascii?Q?JRc3+QySm/LNlIvraygRM4gXExVxr8NCpAIxqkA8EukD0bTB3v7ES6QYuIKB?=
 =?us-ascii?Q?QsPIgx3DNhbYyft2lTZmRe+cMt/a/7JVOwqf7dOtES0lLGnXVnMqb2ogqWn6?=
 =?us-ascii?Q?bJi8dMwoNfZ+Ghp9LdtaPCdJ0vgeIc2YCbfKP65xUa2RE7ReM/wXqeTz149a?=
 =?us-ascii?Q?zG94e6b93jlZsEEsWoc3N2OOQwWNYgjH3oykpRFSjxzyH3RwLeR+WkFYCOs8?=
 =?us-ascii?Q?c2pGQA6wITmuEkM/82diYQW3F2b96X1rtkClgB0Dpebem6KABSfjhoFOA9kE?=
 =?us-ascii?Q?NNYOEl1p2Cxm7Gz2vh5VKWsNLNlPJAk1ZwowwtXmDFW0UQ/81fmnKkCv/jO7?=
 =?us-ascii?Q?N50uRvqSpEGJRMM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 12:07:00.5453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f06481-f563-4470-48c3-08dd3ecb1ad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760

During the High-Speed Isochronous Audio transfers, xHCI
controller on certain AMD platforms experiences momentary data
loss. This results in Missed Service Errors (MSE) being
generated by the xHCI.

The root cause of the MSE is attributed to the ISOC OUT endpoint
being omitted from scheduling. This can happen either when an IN
endpoint with a 64ms service interval is pre-scheduled prior to
the ISOC OUT endpoint or when the interval of the ISOC OUT
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
Changes since v3:
 - Bump up the enum number XHCI_LIMIT_ENDPOINT_INTERVAL_9

Changes since v2:
 - added stable tag to backport to all stable kernels

Changes since v1:
 - replaced hex values with pci device names
 - corrected the commit message

 drivers/usb/host/xhci-mem.c |  5 +++++
 drivers/usb/host/xhci-pci.c | 25 +++++++++++++++++++++++++
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 92703efda1f7..d3182ba98788 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1420,6 +1420,11 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 	/* Periodic endpoint bInterval limit quirk */
 	if (usb_endpoint_xfer_int(&ep->desc) ||
 	    usb_endpoint_xfer_isoc(&ep->desc)) {
+		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_9) &&
+		    usb_endpoint_xfer_int(&ep->desc) &&
+		    interval >= 9) {
+			interval = 8;
+		}
 		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_7) &&
 		    udev->speed >= USB_SPEED_HIGH &&
 		    interval >= 7) {
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2d1e205c14c6..d23884afdf3f 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -69,12 +69,22 @@
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
@@ -278,6 +288,21 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
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
index 4914f0a10cff..36b77d3c0e7b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1633,6 +1633,7 @@ struct xhci_hcd {
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
 #define XHCI_ETRON_HOST	BIT_ULL(49)
+#define XHCI_LIMIT_ENDPOINT_INTERVAL_9 BIT_ULL(50)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.34.1


