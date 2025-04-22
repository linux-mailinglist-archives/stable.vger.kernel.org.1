Return-Path: <stable+bounces-135096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6C4A967E5
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBF2188C9EF
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFCA276056;
	Tue, 22 Apr 2025 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="izL5No+a"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CC2AEE9;
	Tue, 22 Apr 2025 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322031; cv=fail; b=aw92U35RqtpiggQ70p/GOp5mzXRTT5gBj11RhjZkJRH1jb4K/7tkuK85RPPj3ETQvblDdxtSaBmxyiJi7Ic7bYItPMtteb2JKbGbHkflMFAj7/tWmw7SoK3V6PolVVVWtrqoBHTOtudjHempT5JhKm0Ft+W3CglpqvbO8+Kz1Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322031; c=relaxed/simple;
	bh=4ilMxYiLtTDS5alpIjGMmvaTG/rnjYZYOMAVnSJiIA0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RGRWeZ1Pepi6d87jiRWhjo3anP+H49s5LtvCoASTxjGk2chMpqrjAs04JQguFDAsW2DaQtXmOz1oJNCxvHPXRv8spO+CGfr5S3jarzLjlf6H6WJt53/Vw29pOPTBsTWRcbH31kAsBhvllhgavYvM+MuL060hLm5oW3my2wD03uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=izL5No+a; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOl3IZYn39DAPwe6v+HibLcMjHZ14a73PH9wH3o62gVooUqF1FB+TlbRDAvmBplRdSON6F4kA41xoWMxh3rb8ecz1iKQQZxCv0x98wnI8c7CIVG8D8ii2oYCQMIEDAjM9nERgKU/53LTzokdft0hXeUzzdmS0EecuFnmvii3IS/YlJgb3qryy5LdMEtPGKieFT+hAUrhjhkFseKCq8TtFSKOtxObgk/IOOh4/xsrCcgLyylhKzcZKmVtF+4NqMOy15pImBCkFilWjAdNEGHTIAbMyaozvyuJ+Q5nzkoeWxmHL4VHiBKBzrUpeN1Chk/QlQa8RrwlTCbCoh1ZJx2jOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3moZLRMZJA/3c7zH0UWU6y/u1JINPZhz5StqFl50TYE=;
 b=QzmunKrltL4aVQWKZAhvljHjL6OwvkMhIxXaS3V8ah5YMaypmGcs5lEv1wtAZUQm7ZwRb0U1LgQghxhOaTdWPCh7XmE11uO48iq2DAU3w5oVEDjIJmY1zIaE8i1gesId+nEdGnbvn/WKQkS467QJ8AdTa4UHVVNnJfNEaSrCfOdHIx07KdBKQj6vQ0LgEm4jJlt/o1PPzzlt3jbizTKBN+KUjoQuAkqCIOS27Po+CW4xqxmKJyZTEJVmoqd/sOJD8CDlNCjI9U4G1KGeH1WmZ7+6gRHSd/JEVJ56wQ3z1rPOS2xmjYTsz9fHM736D3ZH6C/AJniG9Qbai+vmsbX6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3moZLRMZJA/3c7zH0UWU6y/u1JINPZhz5StqFl50TYE=;
 b=izL5No+azyq49H1D+uNT30T8Ye7v33qh7mJILbbBEXsjxyq281d7v53I/woZwMshfWXouAZnk/OAfFbiYaJBI8UhUwuAf23GQ6bV9cORf+jdoucPNvq4BIrw7a0t72NujW6g072cWECUOf7zzsZHXFfyU8GoaHz9jZ3E5P4Lc0tugPISJJtWfH4f2HkVG8nle986BdZveYRdfwEaiswwp9VlcRiKXdqQ0Az/A20SytTvr8mAhDbmxznLK7SnnO5owmUSaZ3V7rDCCTX/uLBDJGPIvlehP+9FQ0DxS15XU8EVAlm+DkEpH1ljL1O1ZnWOeBtw+dmCTLwfVJ4xjVEDZQ==
Received: from DM6PR03CA0034.namprd03.prod.outlook.com (2603:10b6:5:40::47) by
 DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Tue, 22 Apr 2025 11:40:26 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::12) by DM6PR03CA0034.outlook.office365.com
 (2603:10b6:5:40::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Tue,
 22 Apr 2025 11:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 11:40:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Apr
 2025 04:40:10 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Apr
 2025 04:40:09 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Tue, 22 Apr 2025 04:40:08 -0700
From: Wayne Chang <waynec@nvidia.com>
To: <waynec@nvidia.com>, <mathias.nyman@intel.com>,
	<gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>
CC: <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jim Lin <jilin@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/1] usb: host: tegra: Prevent host controller crash when OTG port is used
Date: Tue, 22 Apr 2025 19:40:01 +0800
Message-ID: <20250422114001.126367-1-waynec@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fd7659-9ec2-482c-6feb-08dd81927988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t0QWlPUFiHfai0ckGzbHvjyCjwe7+LbamlATTWCJ3VaC5FUJMIA0iCqQG9RG?=
 =?us-ascii?Q?zshO+F6KiyjsFzDUbiAzo7/ApGfStps9+q3Dgf1+i/FLUrWLGdRbRbvvvzdo?=
 =?us-ascii?Q?k8CPqoG1Cyxm48aiVj0iQUpm16wkE2iyMVNBnSMYnqZyBemqzM3S1L3HkdLa?=
 =?us-ascii?Q?4sO/yhPK3kTiYsMHPjKgW++ahv/ZfMsPp59wlnCnNoJ2KpPcvDfYli1myPEK?=
 =?us-ascii?Q?LqXqLvYaCuGqMKlGFSRf8Id+cjBfwr3pqNbq6K2AifPLhyPuHNnSZ1wjbEsM?=
 =?us-ascii?Q?N4WzzlkO/nvbUvA6KpKJh5j22ze2BKy8gQPRU4k0Gb/VKZV7HsyZoP5qHBPp?=
 =?us-ascii?Q?/9fnvH7BAAu4pgpFZziRDBJPzfhYXTLiJQGQCmIOibddMsUNmG1T0/9maoyu?=
 =?us-ascii?Q?XMH459T93xTXeUV/YkJfnpAB0QJfgh9jR+v8VDuxr/3grymN3cL4ycdS1E3P?=
 =?us-ascii?Q?diKROP1Ugbd0HKZl62DoLKzPUA3pbeXLHMfdkESviYgiGAKp2ek8zt0/gt5E?=
 =?us-ascii?Q?wW2TheFtHDzmGtY16q+mPUEuo8Rz0TYm2cchePr3DFDg6EfxYc9tvVE0v1p3?=
 =?us-ascii?Q?I4MOcB6CHMbeGKI0o5uUV8TdMrB0NllXDhFdWpXe3aWBYgoh0gi2ruAJtRRS?=
 =?us-ascii?Q?GTM6tgiLMTe9W5XOVVgoxEdBN3ykorIGgZtOpEsZps8d9bvGErYCXfU9Sk44?=
 =?us-ascii?Q?vXn5Nj0vfJJZbFe2URrlBvZfBIXn3E8Jz4Y4Sch0dkC2nJ1FmB1WSshr049Z?=
 =?us-ascii?Q?UrNySJqjSLVIEWAuh+Wp9OftvyymIg06xbyOPf7KviS3crvqe/jQFxXMprym?=
 =?us-ascii?Q?Asi4FKDA5cBl4+ByUw0E2yKRBzq8aRsi1ym9uosnqUP4m0rg1q20Fto8f7rZ?=
 =?us-ascii?Q?/iUUnCbxXosBn+711Pqy27aRmvC5w39IlaD6Xeo31nMUYpP30cQVJY1yXOO6?=
 =?us-ascii?Q?s5q4xEN4fWD4Zxh9p3Fo4HuQqJFEth4zE+GM3BVgtSdFIu/gbbtdeoL9Etxz?=
 =?us-ascii?Q?cWjguDIh4k0UW1Rmhu2PN/xU3txegatEZW1qo0FYNmiRf0t+K8+xgTCT7gya?=
 =?us-ascii?Q?ulVKQC+KMKZSJDJhg2AZRDrs20j7uPn2kYKp1W3YdVWBgF2jGQuc1b+do8dt?=
 =?us-ascii?Q?opdLySdg3aCMCf1hn1MhHuaXdxqY0jM2jM3XpCQ6aQwAL6r7QS2588TRyZyx?=
 =?us-ascii?Q?b1q3Z2LluC9wtwy+FS3sYS8NEgeH6oQUSMXht3PqpbGvXMvFjw6mi2T3ffpJ?=
 =?us-ascii?Q?SDSEMjrrqTw6JReLO3EFPiq0yztZzJCBdWwrGIq5yXmqXvMVNuGXy9bMbYfw?=
 =?us-ascii?Q?saZTEW6zhOksiCPMsCcJNcwF1hBBQCbwlDWXxVsTxaBtzWgeUMYe/gGA/OUm?=
 =?us-ascii?Q?NNHRrc/5yvLGg/wXcw/bOYPRR9srRNMvP5nxsNQSpl97z8lGR7uexqIeptbt?=
 =?us-ascii?Q?wzOUm9H2lcCdZ64vxyfR0MY5/gXs95iJ4EVI11cH5plhNarVq28yVVnaS6+T?=
 =?us-ascii?Q?k2VuWY+rueKLblTGpaSVbcCAqIu+CPccNp6b?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 11:40:25.9577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fd7659-9ec2-482c-6feb-08dd81927988
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656

From: Jim Lin <jilin@nvidia.com>

When a USB device is connected to the OTG port, the tegra_xhci_id_work()
routine transitions the PHY to host mode and calls xhci_hub_control()
with the SetPortFeature command to enable port power.

In certain cases, the XHCI controller may be in a low-power state
when this operation occurs. If xhci_hub_control() is invoked while
the controller is suspended, the PORTSC register may return 0xFFFFFFFF,
indicating a read failure. This causes xhci_hc_died() to be triggered,
leading to host controller shutdown.

Example backtrace:
[  105.445736] Workqueue: events tegra_xhci_id_work
[  105.445747]  dump_backtrace+0x0/0x1e8
[  105.445759]  xhci_hc_died.part.48+0x40/0x270
[  105.445769]  tegra_xhci_set_port_power+0xc0/0x240
[  105.445774]  tegra_xhci_id_work+0x130/0x240

To prevent this, ensure the controller is fully resumed before
interacting with hardware registers by calling pm_runtime_get_sync()
prior to the host mode transition and xhci_hub_control().

Fixes: f836e7843036 ("usb: xhci-tegra: Add OTG support")
Cc: stable@vger.kernel.org
Signed-off-by: Jim Lin <jilin@nvidia.com>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 22dc86fb5254..70ec36e4ff5f 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1364,6 +1364,7 @@ static void tegra_xhci_id_work(struct work_struct *work)
 	tegra->otg_usb3_port = tegra_xusb_padctl_get_usb3_companion(tegra->padctl,
 								    tegra->otg_usb2_port);
 
+	pm_runtime_get_sync(tegra->dev);
 	if (tegra->host_mode) {
 		/* switch to host mode */
 		if (tegra->otg_usb3_port >= 0) {
@@ -1393,6 +1394,7 @@ static void tegra_xhci_id_work(struct work_struct *work)
 		}
 
 		tegra_xhci_set_port_power(tegra, true, true);
+		pm_runtime_mark_last_busy(tegra->dev);
 
 	} else {
 		if (tegra->otg_usb3_port >= 0)
@@ -1400,6 +1402,7 @@ static void tegra_xhci_id_work(struct work_struct *work)
 
 		tegra_xhci_set_port_power(tegra, true, false);
 	}
+	pm_runtime_put_autosuspend(tegra->dev);
 }
 
 #if IS_ENABLED(CONFIG_PM) || IS_ENABLED(CONFIG_PM_SLEEP)
-- 
2.25.1


