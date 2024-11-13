Return-Path: <stable+bounces-92892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D299C6991
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 07:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1298B26E19
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 06:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F5C17DFE9;
	Wed, 13 Nov 2024 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GdOo8JDZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3617C992;
	Wed, 13 Nov 2024 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731481031; cv=fail; b=FyTmQae4jn8LwUJ4SUy5t81BhbQpEQnYLueBG02f/LO6WREKBPX5FTMCy6pFVN8XRGNrgv2S4kkC6uqUG6y0mNTUi5xCuBUQCyCPK41oHVx8JqaGZzWeBcU/g+DlprTmzFBCQJ6Wk2XJ9IyPTOqUclNK4VqM9djwWD+LTH33DWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731481031; c=relaxed/simple;
	bh=0gx3NPsnC5kAc75Jd25H1lWiNOhuDneAfMTIzEP08l0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a1WJ7iFII6yXzvq6dVyezV/erobnBWvPed06Z1lscMoFfjWEfRKNT+SfmsGXK43RGnqh0Y+xyC2LvWxqGOw3w+VNEknHptKpKWhXGL+0ksNTHEtMZnzhnZ8rmC4Pc6pcVTKJA7/k2N8/IyEhVARnP8AVfQsSxlyR8TI0BFyIoA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GdOo8JDZ; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKCkFeVWmZQUoAHzbN2y7qx7BORyAeY10z7q5+ex1yBDCU01Ahi+ykurbfyWL4feXGtq9Wcbs0xmCkY62xmwGY+C42oEPpTo1phL7NfTQSjCLVcpDtjTb3KEqi3EzdOYyenS8R2Tnd9i/lManhZHREfXVwEko3KvZ9fG1IL2S6c/7MxTzgcaFBXwEfB+oCNdF+r5cj+0gSq48sO1ymQKRZWIXxQfpxpvAksBNwvkHuhvsWWtgByeF1zt6iSjNt+DGAEuh3wEN4388LteNBbAf50YCg1bfqzuq5Fe1In5dz2QwyMHtgrfPsSowG/lKkmRoyxFsFVBYwbMTqXOE1miPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRm/7x4Qg2mLRotFUPHNCuT9RUvBUb1a/mLmrkR+PQc=;
 b=rwd5vm3mf0M0PQazPvs92Jr8TGVupQTZNwEwcDqqsYWmmRuaSpiaU5+yRw9mlOSgFaS/6AFpjbbXBlsuoteX/E7Cw4hOzvpLfIP8o5bYT/0qeaaK54na/AuJC6MBYBWUdIM9l8yPZCTtYWhYLH8v0TDVmWiJR2u1amfRrUW2AJ+08sIKij77FrQIFTtmT1JvQRXmM0mE30TL+MeaTabuctQJbZ34AgAJLYQMAB9lp8HZThIOLv9lnkeb5g27y+RF1txxTeQ7eCirO13jitbVYcQ+tfcWUsKpymE/+LZDHqqfD/wcmCFaOpYu2ZQO+HwNG0JcL2kOfvbC50sXonNC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRm/7x4Qg2mLRotFUPHNCuT9RUvBUb1a/mLmrkR+PQc=;
 b=GdOo8JDZuEyCL+4ezv0kLGKda+iWawkpWvzOIMiBLiX6BiEaJIhA6z9NPXv49DRPeLHqRbgJOXmXjSVk3mlbSrtKXfrwHHg6EBlZ5GH3yQlSuuR6CXL+HAIq8seGrYIvaa9S9SS3NrOAo4SqwcFB9ufuBmYHbYAuoPtSP7+3tbo=
Received: from BN9PR03CA0199.namprd03.prod.outlook.com (2603:10b6:408:f9::24)
 by SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 06:57:04 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::b3) by BN9PR03CA0199.outlook.office365.com
 (2603:10b6:408:f9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 06:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 06:57:03 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 00:57:01 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <linux-usb@vger.kernel.org>
CC: <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, Raju Rangoju <Raju.Rangoju@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v3] usb: xhci: quirk for data loss in ISOC transfers
Date: Wed, 13 Nov 2024 12:26:32 +0530
Message-ID: <20241113065632.150451-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SJ0PR12MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 948660c1-a36c-451c-56d3-08dd03b06156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wE1+hSIVe/KqL030Gq3mT20BrDAQ4FEV7XnuCR9gDActO/dMKBCeWoRS7LGU?=
 =?us-ascii?Q?6E8mnzNECcFfTLGfgH7g6wl9LvwjvUJaehJOqv1iGpWUctJdon4idE3ygLg5?=
 =?us-ascii?Q?7qgCfsrUEQw80v6D/iUtffpYpXyYfmoMjtNmyoS8eWNnGLFyM7D0mb0+WDC0?=
 =?us-ascii?Q?88Qm5EG3hDFKb9tXA5fo7PYoQAipAxnY/xrieUaAFaPd6tmdnGRJlrCNkgkA?=
 =?us-ascii?Q?zxdr6Tz77BiTfRteJKl7MPq3cIo5IkvvXZzCCe2JoV+864xKqQOjExXCMGFW?=
 =?us-ascii?Q?yA9hMxEbpG09zz+shMt7vr0gRytWLEKGUdwiUADqmYn0fHWuqbWhP5e4ux95?=
 =?us-ascii?Q?r66U2I6UzvLOvDYDaxEVyUO6irt8drCvU7znmqRib7OeD0hfQDUIMZiIKMzl?=
 =?us-ascii?Q?F7hWI1CZeQ7bKY31SgRtbR/Pfxhimc9m0hYdfULuqisFGvyrPYt4IouE293S?=
 =?us-ascii?Q?Dqg5lOIbWvbFRkQIV3gnjStx8NojNVvHa8FRkeq8VTRG8wAXznNyPjPW4ueG?=
 =?us-ascii?Q?gT1Ih0bl3Dgwn6c6OIh6c1cegl5WuvE7ivZYxMnKxFkhsAtdW1smpTw3uQpI?=
 =?us-ascii?Q?SpC7s9RFz0x6r1XymFFr90WWupLSBwnd9xXUW23TH88pxpZr2BbBuO5/7i0o?=
 =?us-ascii?Q?OfeLpKiPHwLHO/vLLSjhlS9ndGU0TI38sya75o2G32xFJrZMtruXetRAsFrE?=
 =?us-ascii?Q?FpkMWuzQawEu9nK4L3j7FQz/Bt+MYq7hv5271fffS7xV9Qz3FeBZFc6dRjQc?=
 =?us-ascii?Q?oxuO8tof9c7hIC/k1qGvdpXFIIqQ6wVX0EOCC3J+Jwfs7mQbIRbEcIqm1nWR?=
 =?us-ascii?Q?iscJ5alQUmiMZ24A3pdBC2UmOUvnbM/6kfGv2iixUPFmfgOFTe7zT5HlK7fQ?=
 =?us-ascii?Q?sIjrs3CrRHgejtcgVoMebTVB4FdPCDH7RvTcov2tkojV4dEH10+SlmcLHj/p?=
 =?us-ascii?Q?XbrUtLMf+HderY8wmd4bmvAGL9fUuQI8EGmRDhaHMSmVzWAj4GCtNsS9GC01?=
 =?us-ascii?Q?OzJ2iYnGF8swHfIYqJM2irYFAGBqwDpOUUQa8lvPy+SLJ1sqo3FiyRR5XyrS?=
 =?us-ascii?Q?FUotE2yCH/7bCKA9UYC+4aOF7oStUtfJyYtpQiBXrrQLwgTKjrsnehUXxNAS?=
 =?us-ascii?Q?pwYoLR/msXRFfWTiKStMMTuQtqdQjkN9UhMlApp2oG97DOLOcjrX3mXMnIlf?=
 =?us-ascii?Q?NT9BIH4rL2ektRuR0l8gx7eTgkb+CA4DhgGOjpPtcDZL+5RXzAX/GrdCwoCO?=
 =?us-ascii?Q?J1ss6JZuXtp2U5Wqs9nbuLicvSMMh1T97CFJ0cWj3nTyQSS0MbajFcrL0XHN?=
 =?us-ascii?Q?NhDAWGwJ/+1afGz6FXlU0hSoTyfTuKQwATbU6e4/W6o3d3pzab9W3X+QhjMl?=
 =?us-ascii?Q?OOZCfrQHNLqAmFCcCcL8NcQYqDCwa+qeEC5lwPKFy9mxreBYtQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 06:57:03.7872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 948660c1-a36c-451c-56d3-08dd03b06156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065

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
index d2900197a49e..4892bb9afa6e 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1426,6 +1426,11 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
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
index cb07cee9ed0c..82657ca30030 100644
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
@@ -284,6 +294,21 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
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
index f0fb696d5619..fa69f7ac09b5 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1624,6 +1624,7 @@ struct xhci_hcd {
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
+#define XHCI_LIMIT_ENDPOINT_INTERVAL_9	BIT_ULL(49)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.34.1


