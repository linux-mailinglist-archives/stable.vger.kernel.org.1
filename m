Return-Path: <stable+bounces-89806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B019BC8F1
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 10:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40FBB21C51
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D991CFED9;
	Tue,  5 Nov 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KJO6kGXw"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF51CCB2D;
	Tue,  5 Nov 2024 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798362; cv=fail; b=SR5EmuDXWqFXTLoc9A0aJATmiVj3lGJKw7MqUYsQcqtJux4PBDYCZHIOJdB5H/K/KeAdieLR+oJ1cYEy58GQxNAFq7fXl3ccBnkW0Ds9DO5rcSmHVa3W9ZlIDjyVAduihN/VrjWHbOXGtkn0fxNybo7jgqsudsyEam4IrtFKorA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798362; c=relaxed/simple;
	bh=CNt7Jy23UX3pBJ+u/6HfUDyHm7KE/OoI9UoetHcP7uo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m168xwd3NGDRcYSmbty+y+iVPTNUiOhqsHv2mBR3+Xf86ttfYgh2Yg0ykDrg38VN3u8Cmeq3GNwnIFy4ZAeQ5Lvbrn6Jd7EVwxKha2QnxnTkk4T9iaqH7OOwSfDm9wCD5vLIaoRML1pyDcOgAHYK0h34yyeZwY+0aftQLF//0lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KJO6kGXw; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtMLI39rsJ3x/eDTyeBBatJuNhQBSy8Qy7a/zInsiwdAtPfDp6RlPbQVADURW6EBPtlxoqV9O17MZ5bElW8M+euUW8tA7BmkDy+HMZVaUi6I0yPy+t5imkvYwwpvHiAWJj5mY0sSLaLavUCpqFHXrPmL+aa92J54wGm8qwNkrRQp6u6tn9zfIEnFppMVminzBV3Pq+/m1IOQ+w0/AsERIb7BwjpGPxTErRl5o3tKhEY96wnEjDC8q2T113UdsHPQXkuQBNoABxK2CxAEM50K6bed/PUGdVk6o9XTSK8OcDYFZcb3iYZxGW5sgemIzWOTajSCRNYi/zHEhVfYn++7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkg916vF4KeucAayrZqM1ZMU91tij8irqPzMl+lwFyM=;
 b=H2Qcw/N0F8RjkWdNqaZzXUHXYMlN6bRkWpmeq+M+d1tirO1hramr2oxVh3sQFt9E0ZWjXts5x3w2jqm6ekmr+k553wLCk4upfo7Y8L7y9v1L0YR+FdXEBeN/kyLxNeM0j7gZOyC8TVldyVhUq/Bqxtvp6FSdnDCDSqD2Iu1GvCOr/JLwgkT8/o7GfRtPeqM6Rq+W0WfmNb4CEplRyWzD/CIgbOuJJYY1AtcqGoLmW7+5eldMRJZaLNfP6PJDV2+4Qmc9yqu30JWJ5MWyFnRyWr6SP4OehKpYL8mT8nILYkXaxYKwRhqADt02+ouGauG0dYpZzaJ/NOEWkNQtMPs2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkg916vF4KeucAayrZqM1ZMU91tij8irqPzMl+lwFyM=;
 b=KJO6kGXwIhno9nrUPAPz8cKzyGnwT0ynAM42zvIZssyOxpD23cgSGwCSs3RSGeBDbVOkeTgBQaMdjLmvMlsN5g0vjEI7/ybOmE0oarvHp6t8Nd+iEvPrB0RNKdvlA2sRSuENsjE6rvJ8PiltiQEClUOcPI79OOb1/JzuRRzruF4=
Received: from MN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:52f::7)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 09:19:18 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:52f:cafe::9c) by MN0PR03CA0010.outlook.office365.com
 (2603:10b6:208:52f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 09:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 09:19:17 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 03:19:15 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <linux-usb@vger.kernel.org>
CC: <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, Raju Rangoju <Raju.Rangoju@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] usb: xhci: quirk for data loss in ISOC transfers
Date: Tue, 5 Nov 2024 14:48:50 +0530
Message-ID: <20241105091850.3094-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 074b6dc3-e9dc-4ffe-abd0-08dcfd7aeccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NOSBJc4PJqto2NFT0/hRMaPGKoznt1SWno64CesKTXhhvVjNyYtQ2FZ081/v?=
 =?us-ascii?Q?u1dIZcozpe55r5Sboy1AUETCibd+R4jEebpldYr7wpUDts4QAHwr5EFB/1WB?=
 =?us-ascii?Q?xhRSbhcAXm+dlejiell6Uk/v7cWiCIZIXv/DSWwEOYvhMVRrKACSFtaKvtER?=
 =?us-ascii?Q?h/PIscRK+TJ0KV2k8sMIlF2pToqbt58SmVHHrb1SZHF12n3spj0KrXSXU+fz?=
 =?us-ascii?Q?UH106jBKw270UAs/JN3+xWbeSdrEtqckcIfazubStgKeelIzudF4bw/zo0Jr?=
 =?us-ascii?Q?tEru8n43/FJgWkcwzTfEuyDdglWSzQIzXPcIXaBj2284DxImck2ZCI6Sn7F4?=
 =?us-ascii?Q?HiXWJrqY27SMmGmO53tzRSJUO/XOZJUdn8ccIcM+pmzuCjIO+bnm5f8bsQNm?=
 =?us-ascii?Q?cVODrlCjaE8NoaQILZkx704sZfiRGnxaJf5dOi383MELjEqEF7TcKck+JzYT?=
 =?us-ascii?Q?OP2DFYNnPjgORkRYxvIlmpcXjebnX2W5KIfdkm7AhG0Rv3TwpSOpNe2gLV+f?=
 =?us-ascii?Q?NpznJVAPN0jnaA1uCmmwhujdrXFMWF20OsKHlToUdrTu+q76TDxVHh1LDSmI?=
 =?us-ascii?Q?MnBApkoxflzMXaHNVfv1whGtDJZL/zp7s8jjAVOAJCbNUqxxgNPZIpvxUzDT?=
 =?us-ascii?Q?00i7StibRIRiw1NvyKV1Uzv75S/s0tB9dBnwhegRo5tKhJNB31s/N/wZRZhu?=
 =?us-ascii?Q?42SBqTT1Y17Q1ndWeirbNv1ZT+cOu3MDpD7CVYT+bG4Z0PshRmbbM+qr1rzq?=
 =?us-ascii?Q?LC+WPqeNbsX9SxgaCVnp1lX6UTlDUPZij8C6ADtgXz52LKd6ZEuN3xC9aNLW?=
 =?us-ascii?Q?4BTqMio1k5uo8SIub8Tv0YpuHbZum8Udjn/FmyaxBEjPaDCamtJAjWzs+DkF?=
 =?us-ascii?Q?JzR/weD5l4ytmBNJ4e9gMrF68L2+EcYQraKLX9wgqjwZZvUUb3sWRSl52cNN?=
 =?us-ascii?Q?cdftpN7frU8zb4m0uY4H5gtKgh0RByYk/VLX8lf02r3QDEnIyPEjXuAfAoDS?=
 =?us-ascii?Q?boxjW4uZXpTlYC+eZutT5T7EpOErr1OJqdMFf9KG5FPQdZ34Tjt/Y64nDWf4?=
 =?us-ascii?Q?mnj3xJzOf9Mgk+JKcX7Wqivscu/NguZhjFPwlzkxPxK3bqLNyjoEfQofVkQO?=
 =?us-ascii?Q?PsHammrlC+k/rWU2DjuB8A2/V7XNP1i96Q9P7FrPqKgdSUqx1S+R5pqhJ/1c?=
 =?us-ascii?Q?xlSlbfJs7/w6djd/A3kEdZlfokgY04N3rGD99979HyWxHqdCHa4hpgNn/+d9?=
 =?us-ascii?Q?/en5QWMhjnwyFOKylURCFXleUnhzWpwiqyvEYPSt4waZGhA4sdfMeg2OvIb8?=
 =?us-ascii?Q?oym1KfNyyEIdmdUyBEfV3W+EhGDfnIxZxCaTh4IfquzPjT4NCY5dUHpPIziA?=
 =?us-ascii?Q?SDkGhHVjya/fbzvn+U4oWTaBkUo61Q43V0Umy+cOxW3NGKCXJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 09:19:17.9882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 074b6dc3-e9dc-4ffe-abd0-08dcfd7aeccd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056

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
interval of the IN endpoint to exceed 32ms (interval 8). This
adjustment ensures that the OUT endpoint will not be bypassed,
even if a smaller interval value is utilized.

Cc: stable@vger.kernel.org
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/usb/host/xhci-mem.c |  5 +++++
 drivers/usb/host/xhci-pci.c | 14 ++++++++++++++
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 20 insertions(+)

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
index cb07cee9ed0c..a078e2e5517d 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -284,6 +284,20 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_NEC)
 		xhci->quirks |= XHCI_NEC_HOST;
 
+	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
+	    (pdev->device == 0x13ed ||
+	     pdev->device == 0x13ee ||
+	     pdev->device == 0x148c ||
+	     pdev->device == 0x15d4 ||
+	     pdev->device == 0x15d5 ||
+	     pdev->device == 0x15e0 ||
+	     pdev->device == 0x15e1 ||
+	     pdev->device == 0x15e5))
+		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_9;
+
+	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x7316)
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


